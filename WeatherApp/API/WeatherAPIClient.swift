//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 16/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

class WeatherAPIClient {
    
    static let baseApiPath = "https://api.weatherbit.io/v2.0/forecast/daily?key=fd7e5b1fdf024c4c802025ddbe08dec0"
    
    static func get16DaysForecast(withLatitude lat:String, withLongitude long:String, completion: @escaping (Weather16DaysResponse) -> ()) {
        
        let url = baseApiPath + "&lat=" + lat + "&lon=" + long
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
}

