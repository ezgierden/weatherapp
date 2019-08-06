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
    func getMaxTemp() -> String
    func getMinTemp() -> String
    func getSummary() -> String
    func getDegree() -> String
    func getWindSpeed() -> String
    func getCloudCover() -> String
    func getVisibility() -> String
    func getCurrentDate() -> Date
    func getLocation() -> String
    func getWeatherAtIndex(index: Int) -> Weather
    func getHourlyCount() -> Int
    func getBackgroundImageName() -> String
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
    
    func getMaxTemp() -> String {
        return String(self.forecastResponse!.dailyList[0].temperatureMax!)
    }
    
    func getMinTemp() -> String {
        return String(self.forecastResponse!.dailyList[0].temperatureMin!)
    }
    
    func getSummary() -> String {
        return String(self.forecastResponse!.currentWeather.summary)
    }
    
    func getDegree() -> String {
        return String(Int(self.forecastResponse!.currentWeather.temperature))
    }
    
    func getWindSpeed() -> String {
        return String(self.forecastResponse!.currentWeather.windSpeed)
    }
    
    func getCloudCover() -> String {
        return String(self.forecastResponse!.currentWeather.cloudCover)
    }
    
    func getVisibility() -> String {
        return String(self.forecastResponse!.currentWeather.visibility)
    }
    
    func getCurrentDate() -> Date {
        return self.forecastResponse!.dailyList[0].time
    }
    
    func getLocation() -> String {
        return "Boston, MA"
    }
    
    func getBackgroundImageName() -> String {
        return forecastResponse!.currentWeather.icon + "BG"
    }
    
    func getWeatherAtIndex(index: Int) -> Weather {
        return forecastResponse!.hourlyList[index]
    }
    
    func getHourlyCount() -> Int {
        if forecastResponse != nil {
            return forecastResponse!.hourlyList.count
        } else {
            return 0
        }
    }
}
