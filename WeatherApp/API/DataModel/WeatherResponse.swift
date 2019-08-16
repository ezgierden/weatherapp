//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 16/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    var currentWeather: CurrentWeather
    var hourlyWeather: HourlyWeather
    var dailyWeather: DailyWeather
    
    private enum CodingKeys: String, CodingKey {
        case currentWeather = "currently", hourlyWeather = "hourly", dailyWeather = "daily"
    }
}

struct CurrentWeather: Codable {
    var time: Int
    var humidity:Double
    var cloudCover:Double
    var windSpeed:Double
    var visibility:Double
    var temperature:Double
    var summary:String
    var icon:String
}

extension CurrentWeather {
    func getFormattedTemp() -> String {
        return String(Int(temperature))
    }
}

struct HourlyWeather: Codable {
    var data: [HourlyData]
}

struct DailyWeather: Codable{
    var data: [DailyData]
}

struct DailyData: Codable {
    var timeStamp: Int
    var maxTemp: Double
    var minTemp: Double
    
    private enum CodingKeys: String, CodingKey {
        case timeStamp = "time", maxTemp = "temperatureMax", minTemp = "temperatureMin"
    }
}

extension DailyData{
    func getFormattedMaxTemp() -> String {
        return String(Int(maxTemp))
    }
    func getFormattedMinTemp() -> String {
        return String(Int(minTemp))
    }
    func getFormattedTimeStamp() -> Date{
        return Date(timeIntervalSince1970: Double(timeStamp))
    }
}

struct HourlyData: Codable {
    var time: Int
    var icon: String
    var temperature: Double
}

extension HourlyData {
    func getFormattedTemperature() -> String {
        return String(Int(temperature))
    }
    func getFormattedTime() -> Date {
        return Date(timeIntervalSince1970: Double(time))
    }
}
