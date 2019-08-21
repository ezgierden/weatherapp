//
//  16DaysViewModel.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 06/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import Foundation
import Bond

class SixteenDaysViewModel {
    
    private var apiClient: WeatherAPIClient
    let sixteenDaysForecastResponse = Observable<Weather16DaysResponse?>(nil)
    let isLoading = Observable<Bool>(false)
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(latitude: String, longitude: String) {
        isLoading.value = true
        apiClient.get16DaysForecast(with: latitude, with: longitude) { [weak self] (weather16DaysResponse: Weather16DaysResponse) in
            self?.isLoading.value = false
            self?.sixteenDaysForecastResponse.value = weather16DaysResponse
        }
    }
    
    func getCount() -> Int {
        return sixteenDaysForecastResponse.value?.data.count ?? 0
    }
    
    func formatDate(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMMM, dd"
        return dateFormatter.string(from: date)
    }
    
    func getWeatherAtIndex(index:Int) -> SixteenDaysWeather {
        return sixteenDaysForecastResponse.value!.data[index]
    }
}
