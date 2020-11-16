//
//  BaseEntity+CoreDataClass.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//
//

import Foundation
import CoreData

public class BaseEntity: NSManagedObject {
    static let ID_FIELD_NAME = "id"
    
    func isPersisted() -> Bool {
        return !self.objectID.isTemporaryID
    }
    
    class func getSyncRelations() -> [SyncRelation]! {
        return nil
    }
    
    class func getForeignKeyDetails() -> [ForeignKeyDetail]! {
        return nil
    }
    
    class func getRelationShips() -> [[String:String]]! {
        return nil
    }
    
}
