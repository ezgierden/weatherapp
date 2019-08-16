//
//  Weather16DaysResponse.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 15/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct Weather16DaysResponse: Codable {
    var data: [SixteenDaysWeather]
    var location: String
    
    private enum CodingKeys: String, CodingKey {
        case data, location = "city_name"
    }
}

struct SixteenDaysWeather: Codable {
    var timeStamp: Int
    var temperature: Double
    var maxTemp: Double
    var minTemp: Double
    var weatherCode: WeatherCode
    
    private enum CodingKeys : String, CodingKey {
        case timeStamp = "ts", temperature = "temp", maxTemp = "max_temp", minTemp = "min_temp", weatherCode = "weather"
    }
}

struct WeatherCode: Codable {
    var code: Int
}


