//
//  StationViewController.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class StationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ModernSearchBarDelegate {

    @IBOutlet weak var ugsLabel: UILabel!
    @IBOutlet weak var eusLabel: UILabel!
    @IBOutlet weak var dsLabel: UILabel!
    @IBOutlet weak var spaceCraftName: UILabel!
    @IBOutlet weak var modernSearchBar: ModernSearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var damageCapacityLabel: UILabel!
    @IBOutlet weak var remainingDurabilityLabel: UILabel!
    
    var spaceCraft: SpaceCraft!
    var stationManager: StationManager!
    var favoriteManager: FavoriteManager!
    var managedObjectContext = BaseManager.createChildManagedObjectContext()
    var stationList: [Station] = []
    var favoriteList: [Favorite] = []
    var currentStation: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationManager = StationManager(managedObjectContext: managedObjectContext)
        favoriteManager = FavoriteManager(managedObjectContext: managedObjectContext)
        
        let nib = UINib(nibName: String(describing: StationCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: StationCollectionViewCell.self))
        
        getCurrentStation(stationName: "Dünya")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customDesignModernSearchBar()
    }
    
    func customDesignModernSearchBar() {
        modernSearchBar.searchLabel_font = UIFont(name: "Chalkboard SE", size: 16)
        modernSearchBar.searchLabel_textColor = UIColor.black
        modernSearchBar.searchLabel_backgroundColor = UIColor.clear
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    private func configureSearchBar(){
        var array = Array<ModernSearchBarModel>()
        
        for station in stationList{
            array.append(ModernSearchBarModel(name: station.name!, id: 0))
            
        }
        ///Adding delegate
        self.modernSearchBar.delegateModernSearchBar = self
        
        ///Set datas to search bar
        self.modernSearchBar.setDatasWithUrl(datas: array)
        
        ///Increase size of suggestionsView icon
        self.modernSearchBar.suggestionsView_searchIcon_height = 40
        self.modernSearchBar.suggestionsView_searchIcon_width = 40
    }
    
    @objc func refreshList() {
        self.collectionView.reloadData()
    }
    
    func getCurrentStation(stationName: String) {
        currentStation = stationList.first(where: {$0.name == stationName})
    }
    
    func initialize() {
        do {
            self.favoriteList = try self.favoriteManager.retrieveAll()
        } catch {}
        
        ugsLabel.text = "\(Int(stationManager.calculateUGS(ugs: spaceCraft.capacity!.floatValue)))"
        eusLabel.text = "\(stationManager.calculateEUS(eus: spaceCraft.speed!.floatValue))"
        dsLabel.text =  "\(stationManager.calculateDS(ds: spaceCraft.durability!.intValue))"
        
        spaceCraftName.text = spaceCraft.name!
        damageCapacityLabel.text = "100"
        remainingDurabilityLabel.text = "\(spaceCraft.durability!.intValue * 10)"
        stationNameLabel.text = currentStation.name

        self.configureSearchBar()
        self.refreshList()
    }
    
    @objc func travelButtonAction(sender: UIButton) {
        let station = stationList[sender.tag]
        
        currentStation = stationManager.travelCalculate(currentStation: currentStation,
                                                        station: station,
                                                        spaceCraft: spaceCraft)
        if currentStation == nil {
            getCurrentStation(stationName: "Dünya")
        }
        
        initialize()
    }
    
    @objc func starIconAction(sender: UITapGestureRecognizer) {
        let station = stationList[sender.view!.tag]
        if station.isSelect == true {
            station.isSelect = false
        }
        else {
            station.isSelect = true
        }
        
        createFavStation(station: station)
        refreshList()
    }
    
    func createFavStation(station: Station) {
        if let favorite = favoriteList.first(where: {$0.stationName == station.name}) {
            do {
                try favoriteManager.deleteFavorite(entity: favorite)
            } catch let error as NSError {
                print(error)
            }
            refreshList()
            return
        }
        
        let favorite = favoriteManager.createEntity(entityType: Favorite.self)
        favorite.eus = NSNumber(value: stationManager.calculateEUS(eus: spaceCraft.speed!.floatValue))
        favorite.stationName = station.name
        
        do {
            try favoriteManager.save(entity: favorite)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StationCollectionViewCell.self), for: indexPath) as! StationCollectionViewCell
        
        let station = stationList[indexPath.row]
        cell.stationName.text = station.name
        cell.capacityStockLabel.text = station.capacity!.stringValue +
                                    "/" +
                                    station.stock!.stringValue
        
        cell.eusLabel.text = "\(stationManager.calculateEUS(eus: spaceCraft.speed!.floatValue)) EUS"
        
        cell.travelButton.tag = indexPath.row
        cell.travelButton.addTarget(self, action: #selector(travelButtonAction(sender:)), for: .touchUpInside)
        
        if station.isSelect!.boolValue {
            cell.starIcon.image = UIImage(named: "favoriteIcon")
        } else {
            cell.starIcon.image = UIImage(named: "starIcon")
        }
        
        if station.isTravelled!.boolValue {
            cell.travelButton.isEnabled = false
            cell.travelButton.setTitleColor(UIColor.gray, for: .normal)
        } else {
            cell.travelButton.isEnabled = true
            cell.travelButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        let starIconTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(starIconAction(sender:)))
        cell.starIcon.isUserInteractionEnabled = true
        cell.starIcon.tag = indexPath.row
        cell.starIcon.addGestureRecognizer(starIconTapRecognizer)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height - 12)
    }

}
