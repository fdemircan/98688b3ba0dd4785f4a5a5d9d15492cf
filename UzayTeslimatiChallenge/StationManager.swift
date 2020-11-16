//
//  StationManager.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation

class StationManager: BaseManager {
    func calculateUGS(ugs: Float) -> Float {
        var result: Float = 0
        result = Float(ugs * 10000)
        return result
    }
    
    func calculateEUS(eus: Float) -> Float {
        var result: Float = 0
        result = Float(eus * 20)
        return result
    }
    
    func calculateDS(ds: Int) -> Int {
        var result: Int = 0
        result = Int(ds * 10000)
        return result
    }
    
    func createStation(stationList: NSArray) {
        for value in stationList {
            if ((value as? [String: Any]) != nil) {
                let station = self.createEntity(entityType: Station.self)
                StationParseObject().getStationParsed(station: station, column: value as! [String : Any])
            }
        }
    }
    
    func postRequestFromServer(completionHandler: @escaping (Bool) -> ()) {
        ServiceHelper().doRequest { response, arg in
            if response != nil {
                if let arrResponse = response as? NSArray {
                    self.createStation(stationList: arrResponse)
                    completionHandler(true)
                }
            }
        }
    }
    
    func retrieveAll() throws -> [Station] {
        let fetchRequest = BaseManager.createFetchRequest(Station.self)
        return try executeFetchRequest(fetchRequest) as [Station]
    }
    
    func calculateDistanceBetweenTwoStations(currentStation: Station, nextStation: Station) -> Float {
        let calculateX = abs(currentStation.coordinateX!.floatValue - nextStation.coordinateX!.floatValue)
        let calculateY = abs(currentStation.coordinateY!.floatValue - nextStation.coordinateY!.floatValue)
        let powXY: Float = calculateX * calculateX + calculateY * calculateY
        let sqrtXY = sqrt(powXY)
        
        return sqrtXY
    }
    
    func travelCalculate(currentStation: Station, station: Station, spaceCraft: SpaceCraft) -> Station? {
        let need = station.capacity!.floatValue - station.stock!.floatValue
        let ugs = calculateUGS(ugs: spaceCraft.capacity!.floatValue)
        let newCapacity: Float = (ugs - abs(need)) / 10000
        spaceCraft.capacity = NSNumber(value: newCapacity)
        
        let EUS = calculateEUS(eus: spaceCraft.speed!.floatValue)
        let calculateDistance = calculateDistanceBetweenTwoStations(currentStation: currentStation, nextStation: station)
        let newEUS = EUS - calculateDistance
        spaceCraft.speed = NSNumber(value: newEUS / 20)
        
        station.stock = NSNumber(integerLiteral: station.stock!.intValue + Int(need))
        station.isTravelled = true
        
        var currentStation: Station!
        if spaceCraft.capacity!.floatValue <= 0 {
            currentStation = nil
            spaceCraft.capacity = nil
        }
        else if spaceCraft.speed!.floatValue <= 0 {
            currentStation = nil
            spaceCraft.speed = nil
        }
        else {
           currentStation = station
        }
        
        return currentStation
    }
}
