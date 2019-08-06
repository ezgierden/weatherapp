//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct CurrentWeather{
    
    let humidity:Double
    let cloudCover:Double
    let windSpeed:Double
    let visibility:Double
    let temperature:Double
    let summary:String
    let icon:String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let humidity = json["humidity"] as? Double else {throw SerializationError.missing("humidity is missing")}
        self.humidity = humidity
        guard let cloudCover = json["cloudCover"] as? Double else {throw SerializationError.missing("cloudCover is missing")}
        self.cloudCover = cloudCover
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("windSpeed is missing")}
        self.windSpeed = windSpeed
        guard let visibility = json["visibility"] as? Double else {throw SerializationError.missing("visibility is missing")}
        self.visibility = visibility
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        self.summary = summary
        guard let temperature = json["temperature"] as? Double else {throw SerializationError.missing("temperature is missing")}
        self.temperature = temperature
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        self.icon = icon
    }
}
