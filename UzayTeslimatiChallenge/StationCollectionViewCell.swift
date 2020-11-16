//
//  StationCollectionViewCell.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class StationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stationView: UIView!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var capacityStockLabel: UILabel!
    @IBOutlet weak var eusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stationView.layer.cornerRadius = stationView.frame.width / 8
        stationView.layer.borderWidth = 2
        stationView.layer.borderColor = UIColor.black.cgColor
        
        travelButton.addBorder(color: UIColor.black)
    }

}
