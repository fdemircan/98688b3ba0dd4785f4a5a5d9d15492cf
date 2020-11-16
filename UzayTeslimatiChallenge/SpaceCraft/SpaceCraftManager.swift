//
//  SpaceCraftManager.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class SpaceCraftManager: BaseManager {
    func retrieveAll() throws -> [SpaceCraft] {
        let fetchRequest = BaseManager.createFetchRequest(SpaceCraft.self)
        return try executeFetchRequest(fetchRequest) as [SpaceCraft]
    }
    
    func save(entity: SpaceCraft) throws {
        saveEntity(entity: entity)
        try saveWithParrentContext()
    }
}
