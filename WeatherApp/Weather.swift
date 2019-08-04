//
//  Weather.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 22/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct Weather {
    
    let time:Date
    let summary:String
    let icon:String
    let temperatureMax:Double?
    let temperatureMin:Double?
    let temperature:Int?
    let humidity:Double
    let windSpeed:Double
    let cloudCover:Double
    let visibility: Double
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws{
        
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("Summary is missing")}
        guard let time = json["time"] as? Int else{throw SerializationError.missing("Time is missing")}
        guard let icon = json["icon"] as? String else{throw SerializationError.missing("icon is missing")}
        guard let humidity = json["humidity"] as? Double else {throw SerializationError.missing("humidity is missing")}
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("windSpeed is missing")}
        guard let cloudCover = json["cloudCover"] as? Double else {throw SerializationError.missing("cloudCover is missing")}
        guard let visibility = json["visibility"] as? Double else {throw SerializationError.missing("visibility is missing")}
        let temperatureMax = json["temperatureMax"] as? Double
        let temperatureMin = json["temperatureMin"] as? Double
        let temperature = json["temperature"] as? Double
        
        self.summary = summary
        self.time = Date(timeIntervalSince1970: Double(time))
        self.icon = icon
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.cloudCover = cloudCover
        self.visibility = visibility
        
        if temperatureMax != nil{
            self.temperatureMax = temperatureMax
        }else{
            self.temperatureMax = nil
        }
        if temperatureMin != nil {
            self.temperatureMin = temperatureMin
        }else{
            self.temperatureMin = nil
        }
        if temperature != nil {
            self.temperature = Int(temperature!)
        } else {
            self.temperature = nil
        }
    }

    static let apiPath = "https://api.darksky.net/forecast/b38f6ad6d1efcbed678dabbbe76ffc6e/"
    
    static func forecast(withLocation location:String, completion: @escaping (DarkSkyApiResponse) -> ()) {
        
        let url = apiPath + location
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var dailyForecastArray:[Weather] = []
            var hourlyForecastArray:[Weather] = []
            var currentForecastArray:[String:Any] = [:]
            
            if let data = data {
                do{
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        if let dailyForecasts = jsonResponse["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        dailyForecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        if let hourlyForecasts = jsonResponse["hourly"] as? [String:Any] {
                            if let hourlyData = hourlyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in hourlyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        hourlyForecastArray.append(weatherObject)
                                    }
                            }
                        }
                    }
                        if let currentForecast = jsonResponse["currently"] as? [String:Any] {
                                    currentForecastArray = currentForecast
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
                let darkSkyApiResponse = DarkSkyApiResponse(hourlyList: hourlyForecastArray, dailyList: dailyForecastArray, currentList: currentForecastArray)
                completion(darkSkyApiResponse)
            }
        }
        task.resume()
    }
}
