//
//  UpdateEntity+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension UpdateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UpdateEntity> {
        return NSFetchRequest<UpdateEntity>(entityName: "UpdateEntity")
    }

    @NSManaged public var tableName: String?

}
