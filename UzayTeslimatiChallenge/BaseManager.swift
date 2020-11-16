//
//  BaseManager.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import CoreData
import SwiftyJSON

class BaseManager {
    var managedObjectContext: NSManagedObjectContext?
    
    required init (managedObjectContext: NSManagedObjectContext?) {
        self.managedObjectContext = managedObjectContext
    }
    
    static func createFetchRequest<T>(_ entityType: T.Type) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: String(describing: entityType))
    }
    
    static func mainContext() -> NSManagedObjectContext {
        return AppDelegate().sharedInstance().managedObjectContext;
    }
    
    static func createChildManagedObjectContext() -> NSManagedObjectContext {
        let childContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        childContext.parent = mainContext()
        
        return childContext
    }
    
    func createEntity<T>(entityType: T.Type) -> T {
        let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: entityType),
                                                         into: managedObjectContext!) as! T
        return entity
    }
    
    func getAllProperty<T>(entityType: T.Type) -> ([String], [NSAttributeType]) {
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: entityType),
                                                           in: self.managedObjectContext!)
        let attributes = entityDescription?.attributesByName
        var attributeList: [String] = []
        var typeList: [NSAttributeType] = []
        
        for (attribute, value) in attributes! {
            attributeList.append(attribute)
            typeList.append(value.attributeType)
        }
        
        return (attributeList, typeList)
    }
    
    func executeFetchRequest<T>(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>, _ fetchDeleteds: Bool = false) throws -> Array<T> {
        return try (managedObjectContext!.fetch(fetchRequest) as NSArray) as! Array<T>
    }
    
    func createEntityFromDictionary<T>(entityType: T.Type, dictionary: NSArray.Element, destEntity: BaseEntity) {
        let type = entityType as! NSManagedObject.Type
        let propertyNames = getAllProperty(entityType: type)
        
        for property in propertyNames.0 {
            destEntity.setValue(dictionary, forKey: property)
        }
        
    }
    
    func saveEntity(entity: BaseEntity) {
        var existingEntity: BaseEntity?
        
        do {
            existingEntity = try AppDelegate().sharedInstance().managedObjectContext.existingObject(with: entity.objectID) as? BaseEntity
        }
        catch let error as NSError {
            print(error)
        }
        
        if existingEntity != nil {
            let propertyList = getAllProperty(entityType: type(of: entity))
            var diffMap = [String:NSObject?]()
            var updateEntity: UpdateEntity!
            let baseProperties = getAllProperty(entityType: BaseEntity.self)
            
            var foreignKeyNames: [String] = []
            let foreignKeyDetails = type(of: entity).getForeignKeyDetails()
            
            if foreignKeyDetails != nil {
                for tempForeignKeyDetail in foreignKeyDetails! {
                    foreignKeyNames.append(tempForeignKeyDetail.fieldNameOfKey)
                }
            }
            
            for property in propertyList.0 {
                if !baseProperties.0.contains(property) {
                    let newValue = entity.value(forKey: property) as? NSObject
                    let value = existingEntity?.value(forKey: property) as? NSObject
                    
                    if foreignKeyNames.contains(property)
                        && newValue is NSNumber?
                        && newValue != nil
                        && (newValue as? NSNumber )!.intValue <= 0 {
                        continue
                    }
                    
                    if value != nil && newValue == nil {
                        diffMap[property] = NSNull()
                    }
                    else {
                        diffMap[property] = newValue
                    }
                }
                
                if diffMap.count > 0 {
                    if updateEntity == nil {
                        updateEntity = createEntity(entityType: UpdateEntity.self)
                        
                        let entityName = String(describing: type(of: entity))
                        updateEntity.tableName = entityName
                    }
                }
            }
        }
    }
    
    func saveWithParrentContext() throws {
        if managedObjectContext != nil {
            try managedObjectContext?.obtainPermanentIDs(for: Array(managedObjectContext!.insertedObjects))
            try managedObjectContext?.save()
            
            if managedObjectContext!.parent != nil {
                try managedObjectContext!.parent?.save()
            }
        }
    }
    
    func deleteEntity(entity: BaseEntity) {
        managedObjectContext?.delete(entity)
    }
    
    func clearAllCoreData() {
        clearEntity(entityName: "Station")
        clearEntity(entityName: "Favorite")
        clearEntity(entityName: "SpaceCraft")
    }
    
    func clearEntity(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.includesPropertyValues = false

        do {
            let items = try managedObjectContext?.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                managedObjectContext?.delete(item)
            }
            
            try managedObjectContext?.save()
        } catch {}
    }
    
}
