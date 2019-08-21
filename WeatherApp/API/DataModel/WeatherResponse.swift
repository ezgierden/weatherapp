//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 16/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let currentWeather: CurrentWeather
    let hourlyWeather: HourlyWeather
    let dailyWeather: DailyWeather
    
    private enum CodingKeys: String, CodingKey {
        case currentWeather = "currently", hourlyWeather = "hourly", dailyWeather = "daily"
    }
}

struct CurrentWeather: Decodable {
    let time: Int
    let humidity:Double
    let cloudCover:Double
    let windSpeed:Double
    let visibility:Double
    let temperature:Double
    let summary:String
    let icon:String
}

extension CurrentWeather {
    
    func getFormattedTemp() -> String {
        return String(Int((temperature - 32) / 1.8)) + "°"
    }
}

struct HourlyWeather: Decodable {
    let data: [HourlyData]
}

struct DailyWeather: Decodable{
    let data: [DailyData]
}

struct DailyData: Decodable {
    let timeStamp: Int
    let maxTemp: Double
    let minTemp: Double
    
    private enum CodingKeys: String, CodingKey {
        case timeStamp = "time", maxTemp = "temperatureMax", minTemp = "temperatureMin"
    }
}

extension DailyData{
    func getFormattedMaxTemp() -> String {
        return String(Int((maxTemp - 32) / 1.8)) + "°"
    }
    func getFormattedMinTemp() -> String {
        return String(Int((minTemp - 32) / 1.8)) + "°"
    }
    func getFormattedTimeStamp() -> Date{
        return Date(timeIntervalSince1970: Double(timeStamp))
    }
}

struct HourlyData: Decodable {
    let time: Int
    let icon: String
    let temperature: Double
}

extension HourlyData {
    func getFormattedTemperature() -> String {
        return String(Int((temperature - 32) / 1.8))
    }
    func getFormattedTime() -> Date {
        return Date(timeIntervalSince1970: Double(time))
    }
}
