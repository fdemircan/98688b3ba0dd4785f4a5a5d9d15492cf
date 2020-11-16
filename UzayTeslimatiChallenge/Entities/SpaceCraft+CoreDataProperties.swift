//
//  SpaceCraft+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension SpaceCraft {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpaceCraft> {
        return NSFetchRequest<SpaceCraft>(entityName: "SpaceCraft")
    }

    @NSManaged public var capacity: NSNumber?
    @NSManaged public var durability: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var speed: NSNumber?

}
