//
//  ForeignKeyDetail.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 14.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class ForeignKeyDetail: NSObject {
    var entityTypeOfKey: BaseEntity.Type
    var fieldNameOfKey: String
    var relationName: String
    var toMany: Bool
    
    init(_ entityTypeOfKey: BaseEntity.Type, _ fieldNameOfKey: String, _ relationName: String, _ toMany: Bool) {
        self.entityTypeOfKey = entityTypeOfKey
        self.fieldNameOfKey = fieldNameOfKey
        self.relationName = relationName
        self.toMany = toMany
    }
}
