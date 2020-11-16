//
//  BaseEntity+CoreDataProperties.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData


extension BaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseEntity> {
        return NSFetchRequest<BaseEntity>(entityName: "BaseEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var insertedEntites: NSSet?

}

// MARK: Generated accessors for insertedEntites
extension BaseEntity {

    @objc(addInsertedEntitesObject:)
    @NSManaged public func addToInsertedEntites(_ value: InsertedEntities)

    @objc(removeInsertedEntitesObject:)
    @NSManaged public func removeFromInsertedEntites(_ value: InsertedEntities)

    @objc(addInsertedEntites:)
    @NSManaged public func addToInsertedEntites(_ values: NSSet)

    @objc(removeInsertedEntites:)
    @NSManaged public func removeFromInsertedEntites(_ values: NSSet)

}
