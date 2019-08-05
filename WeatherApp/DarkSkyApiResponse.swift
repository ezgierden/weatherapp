//
//  DarkSkyApiResponse.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 04/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

struct DarkSkyApiResponse {
    
    var hourlyList:[Weather]
    var dailyList:[Weather]
    var currentWeather: CurrentWeather
}
