//
//  16DaysViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 06/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

protocol SixteenDaysViewModelProtocol {
    
    func getForecast(lat:String, long:String, completion: @escaping () -> ())
    func getLocation() -> String
    func getCount() -> Int
    func formatDate(date:Date) -> String
    func getWeatherAtIndex(index:Int) -> Weather16Days
}

class SixteenDaysViewModel: SixteenDaysViewModelProtocol {
    
    private var sixteenDaysForecastResponse: WeatherApiResponse?
    
    func getForecast(lat:String, long:String, completion: @escaping () -> ()) {
        Weather16Days.get16DaysForecast(withLatitude: lat, withLongitude: long) { (weatherApiResponse:WeatherApiResponse) in
            self.sixteenDaysForecastResponse = weatherApiResponse
            completion()
        }
    }
    
    func getLocation() -> String {
        return self.sixteenDaysForecastResponse!.location
    }
    
    func getCount() -> Int {
        if sixteenDaysForecastResponse != nil {
            return sixteenDaysForecastResponse!.weatherList.count
        } else {
            return 0
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM, dd"
        return dateFormatter.string(from: date)
    }
    
    func getWeatherAtIndex(index:Int) -> Weather16Days {
        return sixteenDaysForecastResponse!.weatherList[index]
    }

}
