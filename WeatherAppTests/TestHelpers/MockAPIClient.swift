//
//  MockAPIClient.swift
//  WeatherAppTests
//
//  Created by Ezgi Erden on 18/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//
@testable import WeatherApp

class MockAPIClient: WeatherAPIClientProtocol {
    
    var givenWeather16DaysResponse: Weather16DaysResponse? = nil
    var givenWeatherResponse: WeatherResponse? = nil
    
    func givenWeather16DaysResponse(weather16DaysResponse: Weather16DaysResponse) {
        givenWeather16DaysResponse = weather16DaysResponse
    }
    
    func givenWeatherResponse(weatherResponse: WeatherResponse) {
        givenWeatherResponse = weatherResponse
    }
    
    func get16DaysForecast(with latitude: String, with longitude: String, completion: @escaping (Weather16DaysResponse) -> ()) {
        completion(givenWeather16DaysResponse!)
    }
    
    func getForecast(with location: String, completion: @escaping (WeatherResponse) -> ()) {
        completion(givenWeatherResponse!)
    }
    
}
