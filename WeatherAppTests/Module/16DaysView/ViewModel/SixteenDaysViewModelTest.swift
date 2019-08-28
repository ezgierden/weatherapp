//
//  SixteenDaysViewModelTest.swift
//  WeatherAppTests
//
//  Created by Ezgi Erden on 28/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import XCTest
@testable import WeatherApp

class SixteenDaysViewModelTest: XCTestCase {
    
    let apiClient = MockAPIClient ()
    
    var givenLocation = "London, UK"
    var givenTimeStamp = 710777599
    var givenTemperature = 23.35
    var givenMaxTemp = 50.5
    var givenMinTemp = 20.5
    var givenWeatherCode = WeatherCode(code: 800)
    
    var sixteenDaysViewModel: SixteenDaysViewModel!
    
    override func setUp() {
        super.setUp()
        sixteenDaysViewModel = SixteenDaysViewModel(apiClient: apiClient)
    }
    
    func testGetCount() {
        givenWeather16DaysResponse()
        givenWeatherRequestIsMade()
        
        let result = sixteenDaysViewModel.getCount()
        XCTAssertEqual(result, 11)
    }
    
    func testGetWeatherAtIndex_givenWeatherList_returnsCorrectItem() {
        givenWeather16DaysResponse()
        givenWeatherRequestIsMade()
        
        let index = 3
        let result = sixteenDaysViewModel.getWeatherAtIndex(index: index)
        
        let expectedTimeStamp = givenTimeStamp + 3
        let expectedTemperature = givenTemperature + 3
        
        XCTAssertEqual(result.timeStamp, expectedTimeStamp)
        XCTAssertEqual(result.temperature, expectedTemperature)
        XCTAssertEqual(result.maxTemp, givenMaxTemp)
        XCTAssertEqual(result.weatherCode.code, 800)
    }
    
    //MARK: GIVEN
    
    private func givenWeather16DaysResponse() {
        
        var sixteenDaysData = [SixteenDaysWeather]()
        for index in 0...10 {
            sixteenDaysData.append(SixteenDaysWeather(timeStamp: givenTimeStamp + index, temperature: givenTemperature + Double(index), maxTemp: givenMaxTemp, minTemp: givenMinTemp + Double(index), weatherCode: givenWeatherCode))
        }
        let response = Weather16DaysResponse(data: sixteenDaysData, location: givenLocation)
        apiClient.givenWeather16DaysResponse(weather16DaysResponse: response)
    }
    
    private func givenWeatherRequestIsMade() {
        sixteenDaysViewModel.getForecast(latitude: "", longitude: "")
    }
}
