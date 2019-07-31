//
//  InnerWeather.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 30/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct InnerWeather {
    let code: Int
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let code = json["code"] as? Int else {throw SerializationError.missing("code is missing")}
        self.code = code
    }
}
