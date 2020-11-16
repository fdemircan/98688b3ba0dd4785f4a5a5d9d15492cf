//
//  HomeViewController.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

protocol UpdateTabbar {
    func updateTabbar()
}

class HomeViewController: UITabBarController, UpdateTabbar {
    static let STATION_INDEX = 0
    static let FAVORITES_INDEX = 1
    
    var managedObjectContext = BaseManager.createChildManagedObjectContext()
    var spaceCraftManager: SpaceCraftManager!
    var stationManager: StationManager!
    var spaceCraftList: [SpaceCraft] = []
    var itemList: [UITabBarItem] = []
    var items: [Int : UITabBarItem] = [:]
    var tempViewControllers: [Int: UIViewController] = [:]
    var spaceCraft: SpaceCraft!
    var stationList: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationManager = StationManager(managedObjectContext: managedObjectContext)
        spaceCraftManager = SpaceCraftManager(managedObjectContext: managedObjectContext)
        
        DispatchQueue.main.async {
            self.initialize()
        }
    }
    
    func initialize() {
        stationManager.postRequestFromServer(completionHandler: { response in
            do{
                self.stationList = try self.stationManager.retrieveAll()
                self.spaceCraftList = try self.spaceCraftManager.retrieveAll()
                self.spaceCraft = self.spaceCraftList.last
            }catch let error as NSError{
                print(error)
            }
            
            self.buildTabbar()
            AppDelegate().sharedInstance().updateTabBarDelegate = self
        })
    }
    
    func updateTabbar() {
        buildTabbar()
    }
    
    func buildTabbar() {
        var viewControllers: [UIViewController] = []
        
        let stationViewController = StationViewController()
        items[HomeViewController.STATION_INDEX] = UITabBarItem(title: "station_title".localized,
                                                               image: UIImage(named: "stationIcon"),
                                                               tag: HomeViewController.STATION_INDEX)
        stationViewController.tabBarItem = items[HomeViewController.STATION_INDEX]
        stationViewController.spaceCraft = spaceCraft
        stationViewController.stationList = stationList
        viewControllers.append(stationViewController)
        tempViewControllers[HomeViewController.STATION_INDEX] = stationViewController
        
        
        let favoritesViewController = FavoritesViewController()
        items[HomeViewController.FAVORITES_INDEX] = UITabBarItem(title: "favorites_title".localized,
                                                                 image: UIImage(named: "favoriteIcon"),
                                                                 tag: HomeViewController.FAVORITES_INDEX)
        favoritesViewController.tabBarItem = items[HomeViewController.FAVORITES_INDEX]
        viewControllers.append(favoritesViewController)
        tempViewControllers[HomeViewController.FAVORITES_INDEX] = favoritesViewController
        
        setViewControllers(viewControllers, animated: true)
    }
}
