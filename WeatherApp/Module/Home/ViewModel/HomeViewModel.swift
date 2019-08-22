//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation
import Bond

class HomeViewModel {
    
    private var apiClient: WeatherAPIClient
    let isLoading = Observable<Bool>(true)
    let hourlyList = Observable<HourlyWeather?>(nil)
    let time = Observable<Int?>(nil)
    let humidity = Observable<String>("")
    let cloudCover = Observable<String>("")
    let windSpeed = Observable<String>("")
    let visibility = Observable<String>("")
    let temperature = Observable<String>("")
    let summary = Observable<String>("")
    let icon = Observable<String>("")
    let date = Observable<Date?>(nil)
    let maxTemp = Observable<String>("")
    let minTemp = Observable<String>("")
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(location: String){
        isLoading.value = true
        apiClient.getForecast(with: location) { [weak self] (weatherResponse: WeatherResponse) in
            self?.isLoading.value = false
            
            self?.hourlyList.value = weatherResponse.hourlyWeather
            
            self?.time.value = weatherResponse.currentWeather.time
            self?.humidity.value = String(weatherResponse.currentWeather.humidity)
            self?.cloudCover.value = String(weatherResponse.currentWeather.cloudCover)
            self?.windSpeed.value = String(weatherResponse.currentWeather.windSpeed)
            self?.visibility.value = String(weatherResponse.currentWeather.visibility)
            self?.temperature.value = weatherResponse.currentWeather.getFormattedTemp()
            self?.summary.value = String(weatherResponse.currentWeather.summary)
            self?.icon.value = weatherResponse.currentWeather.icon + "BG"
            
            self?.date.value = weatherResponse.dailyWeather.data[0].getFormattedTimeStamp()
            self?.maxTemp.value = weatherResponse.dailyWeather.data[0].getFormattedMaxTemp()
            self?.minTemp.value = weatherResponse.dailyWeather.data[0].getFormattedMinTemp()
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
        // TODO: Get it from the user
        return "London, UK"
    }
    
    func getWeatherAtIndex(index: Int) -> HourlyData {
        return hourlyList.value!.data[index]
    }
    
    func getHourlyCount() -> Int {
        return hourlyList.value?.data.count ?? 0
    }
    
    func formatIntToString(int:Int) -> String {
        return String(int)
    }
    
    func formatDoubleToString(double:Double) -> String {
        return String(double)
    }

}

