//
//  SyncRelation.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class SyncRelation: NSObject {
    var relatedEntityTypes: BaseEntity.Type
    var relatedEntityColumn: String
    
    init(_ relatedEntityTypes: BaseEntity.Type, _ relatedEntityColumn: String) {
        self.relatedEntityTypes = relatedEntityTypes
        self.relatedEntityColumn = relatedEntityColumn
    }
}
