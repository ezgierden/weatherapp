//
//  Weather16Days.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 27/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct Weather16Days {
    
    let maxTemp:Int
    let minTemp:Int
    let validDate:String
    let timeStamp:Date
    let location:String?
    let weather:InnerWeather
    
    enum SerializationError:Error{
        
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        
        guard let maxTemp = json["max_temp"] as? Double else {throw SerializationError.missing("max_temp is missing")}
        guard let minTemp = json["min_temp"] as? Double else {throw SerializationError.missing("min_temp is missing")}
        guard let validDate = json["valid_date"] as? String else {throw SerializationError.missing("valid_date is missing")}
        guard let weather = json["weather"] as? [String:Any] else {throw SerializationError.missing("weather is missing")}
        guard let timeStamp = json["ts"] as? Int else {throw SerializationError.missing("timeStamp is missing")}
        let location = json["city_name"] as? String
        
        self.maxTemp = Int(maxTemp)
        self.minTemp = Int(minTemp)
        self.validDate = validDate
        self.timeStamp = Date(timeIntervalSince1970: Double(timeStamp))
        
        if location != nil{
            self.location = location
        }else{
            self.location = nil
        }
        
        if let weather = try? InnerWeather(json: weather){
            self.weather = weather
        }else{
            throw SerializationError.missing("weather is missing")
        }
    }
    
    
    
    static let baseApiPath = "https://api.weatherbit.io/v2.0/forecast/daily?key=fd7e5b1fdf024c4c802025ddbe08dec0"
    
    static func get16DaysForecast(withLatitude lat:String, withLongitude long:String, completion: @escaping (WeatherApiResponse) -> ()) {
        
        let url = baseApiPath + "&lat=" + lat + "&lon=" + long
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray16Days:[Weather16Days] = []
            var location:String = ""
           /* var weatherDataArray:[Weather16Days] = []*/
            
            if let data = data {
                do{
                     if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        print(jsonResponse)
                        
                        if let dailyData = jsonResponse["data"] as? [[String:Any]] {
                            for dataPoint in dailyData {

                                    if let weatherObject = try? Weather16Days(json: dataPoint) {
                                        forecastArray16Days.append(weatherObject)
                
                            }
                        }
                        
                    }
                        if let cityName = jsonResponse["city_name"] as? String {
                            location = cityName
                        }
                        
                        
                      /*  if let dailyWeather = jsonResponse["data"] as? [[String:Any]] {
                            if let weatherData = dailyWeather["weather"] as? [String:Any] {
                                for dataPoint in weatherData {
                                    if let weatherObject = try? Weather16Days(json: dataPoint){
                                        weatherDataArray.append(weatherObject)
                                    }
                                    
                                }
                                
                                
                            }
                }*/
                }
                }catch{
                    print(error.localizedDescription)
                }
                let weatherApiResponse = WeatherApiResponse(weatherList: forecastArray16Days, location: location)
                completion(weatherApiResponse)
            }
        }
        
        task.resume()
    }
    
    
}

