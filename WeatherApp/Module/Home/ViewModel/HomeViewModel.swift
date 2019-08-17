//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    
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
    func getWeatherAtIndex(index: Int) -> HourlyData
    func getHourlyCount() -> Int
    func getBackgroundImageName() -> String
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var forecastResponse: WeatherResponse?
    private var apiClient: WeatherAPIClient
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(location: String, completion: @escaping () -> Void){
        apiClient.getForecast (with: location) { [weak self] (weatherResponse: WeatherResponse) in
            self?.forecastResponse = weatherResponse
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
        return String(self.forecastResponse!.dailyWeather.data[0].getFormattedMaxTemp())
    }
    
    func getMinTemp() -> String {
        return String(self.forecastResponse!.dailyWeather.data[0].getFormattedMinTemp())
    }
    
    func getSummary() -> String {
        return String(self.forecastResponse!.currentWeather.summary)
    }
    
    func getDegree() -> String {
        return String(self.forecastResponse!.currentWeather.getFormattedTemp())
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
        return self.forecastResponse!.dailyWeather.data[0].getFormattedTimeStamp()
    }
    
    func getLocation() -> String {
        return "Boston, MA"
    }
    
    func getBackgroundImageName() -> String {
        return forecastResponse!.currentWeather.icon + "BG"
    }
    
    func getWeatherAtIndex(index: Int) -> HourlyData {
        return forecastResponse!.hourlyWeather.data[index]
    }
    
    func getHourlyCount() -> Int {
        return forecastResponse?.hourlyWeather.data.count ?? 0
    }
}
