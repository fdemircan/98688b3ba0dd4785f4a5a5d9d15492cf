//
//  FavoriteManager.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class FavoriteManager: BaseManager {
    func retrieveAll() throws -> [Favorite] {
        let fetchRequest = BaseManager.createFetchRequest(Favorite.self)
        return try executeFetchRequest(fetchRequest) as [Favorite]
    }
    
    func deleteFavorite(entity: Favorite) throws {
        deleteEntity(entity: entity)
        try save(entity: entity)
    }
    
    func save(entity: Favorite) throws {
        saveEntity(entity: entity)
        try saveWithParrentContext()
    }
}
