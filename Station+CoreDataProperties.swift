//
//  Station+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var name: String?
    @NSManaged public var coordinateX: NSNumber?
    @NSManaged public var coordinateY: NSNumber?
    @NSManaged public var stock: NSNumber?
    @NSManaged public var need: NSNumber?
    @NSManaged public var capacity: NSNumber?
    @NSManaged public var isSelect: NSNumber?
    @NSManaged public var isCurrent: NSNumber?
    @NSManaged public var isTravelled: NSNumber?
}
