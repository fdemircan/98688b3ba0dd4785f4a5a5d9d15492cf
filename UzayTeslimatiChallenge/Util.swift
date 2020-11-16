//
//  Util.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import UIKit

class Util {
    static func creatAlertDialog(_ title: String, _ message: String, completion: (() -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "accept".localized, style: .default) { (action:UIAlertAction!) in
            if completion != nil {
                completion!()
            }
        }
        
        alertController.addAction(acceptAction)
        return alertController
    }
}
