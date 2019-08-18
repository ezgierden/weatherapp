//
//  WeatherAPIClientProtocol.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 18/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

protocol WeatherAPIClientProtocol {
    
    func get16DaysForecast(with latitude:String, with longitude:String, completion: @escaping (Weather16DaysResponse) -> ())
    func getForecast(with location:String, completion: @escaping (WeatherResponse) -> ())
}
