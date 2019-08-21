//
//  Weather16DaysResponse.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 15/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct Weather16DaysResponse: Decodable {
    let data: [SixteenDaysWeather]
    let location: String
    
    private enum CodingKeys: String, CodingKey {
        case data, location = "city_name"
    }
}

struct SixteenDaysWeather: Decodable {
    let timeStamp: Int
    let temperature: Double
    let maxTemp: Double
    let minTemp: Double
    let weatherCode: WeatherCode
    
    private enum CodingKeys : String, CodingKey {
        case timeStamp = "ts", temperature = "temp", maxTemp = "max_temp", minTemp = "min_temp", weatherCode = "weather"
    }
}

extension SixteenDaysWeather{
    var formattedMaxTemp:String {
        return String(Int(maxTemp)) + "°"
    }
    var formattedMinTemp:String {
        return String(Int(minTemp)) + "°"
    }
    
    var dateAsString: String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM, dd"
        return dateFormatter.string(from: date)
    }
}

struct WeatherCode: Decodable {
    let code: Int
}

extension WeatherCode{
    var codeAsString:String {
        return String(code)
    }
    
}
