//
//  SpaceCraftViewController.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class SpaceCraftViewController: UIViewController{

    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var rocketNameTextField: UITextField!
    @IBOutlet weak var durabilitySlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var capacitySlider: UISlider!
    @IBOutlet weak var continueButton: UIButton!
    
    var managedObjectContext = BaseManager.createChildManagedObjectContext()
    var spaceCraftManager: SpaceCraftManager!
    var favoriteManager: FavoriteManager!
    
    var totalPoint: Int = 15
    var durability: Int = 0
    var speed: Int = 0
    var capacity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteManager = FavoriteManager(managedObjectContext: managedObjectContext)
        spaceCraftManager = SpaceCraftManager(managedObjectContext: managedObjectContext)
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func initialize() {
        favoriteManager.clearAllCoreData()
    }
    
    func setupUI() {
        rocketNameTextField.addBorder(color: UIColor.black)
        continueButton.addBorder(color: UIColor.black)
    }
    
    func clearAllSlider() {
        durabilitySlider.value = 0
        speedSlider.value = 0
        capacitySlider.value = 0
        durability = 0
        speed = 0
        capacity = 0
        
        totalPoint = 15
        pointLabel.text = "\(totalPoint)"
    }
    
    func updatePointLabel() {
        let total = durability + speed + capacity
        let result = totalPoint - total
        guard result < 0 else {
            pointLabel.text = "\(result)"
            return
        }

        clearAllSlider()
        let dialog = Util.creatAlertDialog("warning".localized,
                                           "create_spacecraft_alert".localized,
                                           completion: nil)
        self.present(dialog, animated: true, completion: nil)
    }
    
    @IBAction func durabilitySliderAction(_ sender: UISlider) {
        durability = Int(sender.value)
        updatePointLabel()
    }
    
    @IBAction func speedSliderAction(_ sender: UISlider) {
        speed = Int(sender.value)
        updatePointLabel()
    }
    
    @IBAction func capacitySliderAction(_ sender: UISlider) {
        capacity = Int(sender.value)
        updatePointLabel()
    }
    
    func saveSpaceCraft() {
        let spaceCraft = spaceCraftManager.createEntity(entityType: SpaceCraft.self)
        spaceCraft.name = rocketNameTextField.text
        spaceCraft.durability = NSNumber(value: durability)
        spaceCraft.capacity = NSNumber(value: capacity)
        spaceCraft.speed = NSNumber(value: speed)
        
        do {
            try spaceCraftManager.save(entity: spaceCraft)
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        saveSpaceCraft()
        
        let homeViewController = HomeViewController()
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }
}

