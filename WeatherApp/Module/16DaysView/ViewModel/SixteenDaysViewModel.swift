//
//  16DaysViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 06/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

protocol SixteenDaysViewModelProtocol {
    
    func getForecast(latitude:String, longitude:String, completion: @escaping () -> ())
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
    
    func getForecast(latitude: String, longitude: String, completion: @escaping () -> Void) {
        apiClient.get16DaysForecast(with: latitude, with: longitude) { [weak self] (weather16DaysResponse: Weather16DaysResponse) in
            self?.sixteenDaysForecastResponse = weather16DaysResponse
            completion()
        }
    }
    
    func getLocation() -> String {
        return self.sixteenDaysForecastResponse!.location
    }
    
    func getCount() -> Int {
        return sixteenDaysForecastResponse?.data.count ?? 0
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
