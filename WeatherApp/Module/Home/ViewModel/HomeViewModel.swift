//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation
import Bond

/*protocol HomeViewModelProtocol: AnyObject {
 
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
 }*/

class HomeViewModel {
    
    private var apiClient: WeatherAPIClient
    let forecastResponse = Observable<WeatherResponse?>(nil)
    
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(location: String){
        apiClient.getForecast(with: location) { [weak self] (weatherResponse: WeatherResponse) in
            self?.forecastResponse.value = weatherResponse
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
    
    func getLocation() -> String {
        return "Boston, MA"
    }
    
    func formatBackgroundImageName(iconName: String) -> String {
        return iconName + "BG"
    }
    
    func getWeatherAtIndex(index: Int) -> HourlyData {
        return forecastResponse.value!.hourlyWeather.data[index]
    }
    
    func getHourlyCount() -> Int {
        return forecastResponse.value?.hourlyWeather.data.count ?? 0
    }
    
    func formatIntToString(int:Int) -> String {
        return String(int)
    }
    
    func formatDoubleToString(double:Double) -> String {
        return String(double)
    }

}



/* func getHumidity() -> String {
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
 
 
 func getBackgroundImageName() -> String {
 return forecastResponse!.currentWeather.icon + "BG"
 }*/


