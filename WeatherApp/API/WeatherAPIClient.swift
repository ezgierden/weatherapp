//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 16/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

class WeatherAPIClient {
    
    private let weatherApi16DaysUrl = "https://api.weatherbit.io/v2.0/forecast/daily?key=fd7e5b1fdf024c4c802025ddbe08dec0"
    private let weatherApiUrl = "https://api.darksky.net/forecast/b38f6ad6d1efcbed678dabbbe76ffc6e/"
    
    func get16DaysForecast(with latitude:String, with longitude:String, completion: @escaping (Weather16DaysResponse) -> ()) {
        
        let url = weatherApi16DaysUrl + "&lat=" + latitude + "&lon=" + longitude
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if let data = data {
                if let response = try? JSONDecoder().decode(Weather16DaysResponse.self, from: data) {
                    completion(response)
                    return
                }
            }
        }
        task.resume()
    }
    
    func getForecast(with location:String, completion: @escaping (WeatherResponse) -> ()) {
        
        let url = weatherApiUrl + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if let data = data {
                if let response = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    completion(response)
                    return
                }
            }
        }
        task.resume()
    }
}
