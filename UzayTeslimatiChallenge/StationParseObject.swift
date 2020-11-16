//
//  StationParseObject.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class StationParseObject {
    func getStationParsed(station: Station, column: [String: Any]) {
        station.capacity = column["capacity"] as? NSNumber
        station.need = column["need"] as? NSNumber
        station.stock = column["stock"] as? NSNumber
        station.coordinateX = column["coordinateX"] as? NSNumber
        station.coordinateY = column["coordinateY"] as? NSNumber
        station.name = column["name"] as? String
        station.isSelect = false
        station.isCurrent = false
        station.isTravelled = false
    }
}
