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
    func formatDate(timeStamp: Int) -> String
    func getWeatherAtIndex(index: Int) -> SixteenDaysWeather
}

class SixteenDaysViewModel: SixteenDaysViewModelProtocol {
    
    private var sixteenDaysForecastResponse: Weather16DaysResponse?
    private var apiClient: WeatherAPIClient
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(lat: String, long: String, completion: @escaping () -> ()) {
        apiClient.get16DaysForecast(withLatitude: lat, withLongitude: long) { (weather16DaysResponse: Weather16DaysResponse) in
            self.sixteenDaysForecastResponse = weather16DaysResponse
            completion()
        }
    }
    
   /* func getForecast(lat:String, long:String, completion: @escaping () -> ()) {
        Weather16Days.get16DaysForecast(withLatitude: lat, withLongitude: long) { (weatherApiResponse:WeatherApiResponse) in
            self.sixteenDaysForecastResponse = weatherApiResponse
            completion()
        }
    }*/
    
    func getLocation() -> String {
        return self.sixteenDaysForecastResponse!.location
    }
    
    func getCount() -> Int {
        if sixteenDaysForecastResponse != nil {
            return sixteenDaysForecastResponse!.data.count
        } else {
            return 0
        }
    }
    
    func formatDate(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM, dd"
        return dateFormatter.string(from: date)
    }
    
    func getWeatherAtIndex(index:Int) -> SixteenDaysWeather {
        return sixteenDaysForecastResponse!.data[index]
    }
}
