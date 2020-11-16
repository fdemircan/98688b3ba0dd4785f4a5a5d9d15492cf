//
//  FavoriteCollectionViewCell.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var starIconImageView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationEUSLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteView.layer.borderWidth = 2
        favoriteView.layer.borderColor = UIColor.black.cgColor
    }

}
