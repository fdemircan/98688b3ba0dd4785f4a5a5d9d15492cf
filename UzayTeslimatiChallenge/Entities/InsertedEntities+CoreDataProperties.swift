//
//  InsertedEntities+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension InsertedEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InsertedEntities> {
        return NSFetchRequest<InsertedEntities>(entityName: "InsertedEntities")
    } 

    @NSManaged public var entityId: Int64
    @NSManaged public var name: String?
    @NSManaged public var insertedEntity: BaseEntity?

}
