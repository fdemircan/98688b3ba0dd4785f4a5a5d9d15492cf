//
//  UIKit+Extension.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

extension UIButton {
    func addBorder(color : UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2.0
    }
}

extension UITextField {
    func addBorder(color : UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2.0
    }
}
