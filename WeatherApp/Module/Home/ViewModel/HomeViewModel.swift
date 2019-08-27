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
    
    private var apiClient: WeatherAPIClientProtocol
    let isLoading = Observable<Bool>(true)
    let hourlyList = Observable<[HourlyData]>([])
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
    
    init(apiClient: WeatherAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getForecast(location: String){
        isLoading.value = true
        apiClient.getForecast(with: location) { [weak self] (weatherResponse: WeatherResponse) in
            self?.isLoading.value = false
            
            self?.hourlyList.value = Array(weatherResponse.hourlyWeather.data[0...23])
            
            self?.time.value = weatherResponse.currentWeather.time
            self?.humidity.value = String(weatherResponse.currentWeather.humidity)
            self?.cloudCover.value = String(weatherResponse.currentWeather.cloudCover)
            self?.windSpeed.value = String(weatherResponse.currentWeather.windSpeed)
            self?.visibility.value = String(weatherResponse.currentWeather.visibility)
            self?.temperature.value = weatherResponse.currentWeather.formattedTemp
            self?.summary.value = String(weatherResponse.currentWeather.summary)
            self?.icon.value = weatherResponse.currentWeather.icon + "BG"
            
            self?.date.value = weatherResponse.dailyWeather.data[0].formattedTimeStamp
            self?.maxTemp.value = weatherResponse.dailyWeather.data[0].formattedMaxTemp
            self?.minTemp.value = weatherResponse.dailyWeather.data[0].formattedMinTemp
        }
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
        return hourlyList.value[index]
    }
    
    func getHourlyCount() -> Int {
        return hourlyList.value.count
    }
}

