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
    let isLoading = Observable<Bool>(false)
    let location = Observable<String>("")
    let weatherList = Observable<[SixteenDaysWeather]>([])
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getForecast(latitude: String, longitude: String) {
        isLoading.value = true
        apiClient.get16DaysForecast(with: latitude, with: longitude) { [weak self] (weather16DaysResponse: Weather16DaysResponse) in
            self?.isLoading.value = false
            self?.weatherList.value = weather16DaysResponse.data
            self?.location.value = weather16DaysResponse.location
        }
    }
    
    func getCount() -> Int {
        return weatherList.value.count
    }
    
    func getWeatherAtIndex(index:Int) -> SixteenDaysWeather {
        return weatherList.value[index]
    }
}
