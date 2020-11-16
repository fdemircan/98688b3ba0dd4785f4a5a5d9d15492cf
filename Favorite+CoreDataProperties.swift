//
//  Favorite+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var stationName: String?
    @NSManaged public var eus: NSNumber?

}
