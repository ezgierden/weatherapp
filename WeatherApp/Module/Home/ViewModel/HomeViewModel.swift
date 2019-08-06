//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func formatDate(date:Date) -> String
    func formatDateToHour(date:Date) -> String
    func getForecast(location:String, completion: @escaping () -> ())
    func getHumidity() -> String
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var forecastResponse: DarkSkyApiResponse?
    
    func getForecast(location: String, completion: @escaping () -> ()){
        Weather.forecast(withLocation: location) { (darkSkyApiResponse:DarkSkyApiResponse) in
            self.forecastResponse = darkSkyApiResponse
            completion()
        }
    }
    
    func formatDateToHour(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "HH"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM, dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func getHumidity() -> String {
        return String(self.forecastResponse!.currentWeather.humidity)
    }
}
