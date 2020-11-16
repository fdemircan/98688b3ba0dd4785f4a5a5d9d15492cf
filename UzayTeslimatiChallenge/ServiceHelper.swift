//
//  ServiceHelper.swift
//  UzayTeslimatiChallenge
//
//  Created by Fetiye Demircan on 15.11.2020.
//  Copyright © 2020 Fetiye Demircan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceHelper {
    static let WEBSERVICE_STATUS_OK = "OK"
    
    func getRequest() -> URLRequest {
        let url = "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2"
        let serviceUrl = URL(string: url)
        
        var request = URLRequest(url: serviceUrl!)
        request.httpMethod = "POST"
        
        return request
    }
    
    func getError<T>(response: DataResponse<T>) -> String? {
        if response.response != nil && response.response?.statusCode != nil && response.response?.statusCode == 200 {
            return nil
        } else {
            return "ws_error"
        }
    }
    
    func validateResponse<T>(response: DataResponse<T>) -> (Any?, String?) {
        if let error = getError(response: response) {
            return (nil, error)
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: response.data!)
            return (json, "ws_success")
        } catch {
            return(nil, "ws_error")
        }
    }
    
    func doRequest(completion:@escaping (Any?,String?) -> ()){
        let request = getRequest()
        Alamofire.request(request).responseString { (tempResponse) in
            let validResponse = self.validateResponse(response: tempResponse)
            DispatchQueue.main.async() {
                completion(validResponse.0, validResponse.1)
            }
        }
    }
}
