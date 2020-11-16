//
//  FavoritesViewController.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoriteList: [Favorite] = []
    var favoriteManager: FavoriteManager!
    var managedObjectContext = BaseManager.createChildManagedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteManager = FavoriteManager(managedObjectContext: managedObjectContext)
        
        let nib = UINib(nibName: String(describing: FavoriteCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: FavoriteCollectionViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.initialize()
        }
    }
    
    @objc func refreshList() {
        self.collectionView.reloadData()
    }
    
    func initialize() {
        do {
            self.favoriteList = try self.favoriteManager.retrieveAll()
            self.performSelector(onMainThread: #selector(self.refreshList), with: nil, waitUntilDone: false)
        } catch {}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCollectionViewCell.self), for: indexPath) as! FavoriteCollectionViewCell
        
        let favorite = favoriteList[indexPath.row]
        cell.stationNameLabel.text = favorite.stationName
        cell.stationEUSLabel.text = favorite.eus!.stringValue + " EUS"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
