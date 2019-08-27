//
//  HomeViewModelTest.swift
//  WeatherAppTests
//
//  Created by Ezgi Erden on 17/08/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HomeViewModelTest: XCTestCase {
    
    let apiClient = MockAPIClient()
    
    var givenTime = 710777599
    var givenHumidity = 12.5
    var givenCloudCover = 11.5
    var givenWindSpeed = 9.3
    var givenVisibility = 8.5
    var givenTemparature = 22.1
    var givenSummary = "Some summary"
    var givenIcon = "some_icon"
    
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(apiClient: apiClient)
    }
    
    func testPageTitle() {
        XCTAssertEqual("London, UK", viewModel.getLocation())
    }
    
    func testFormatDate() {
        let givenDate = Date(timeIntervalSince1970: TimeInterval(710777599))
        let result = viewModel.formatDate(date: givenDate)
        
        XCTAssertEqual(result, "July, 10")
    }
    
    func testGetWeatherAtIndex_givenHourlyList_returnsCorrectItem() {
        givenWeatherResponse()
        givenWeatherRequestIsMade()
        let index = 2
        let result = viewModel.getWeatherAtIndex(index: index)
        
        let expectedTime = givenTime + 2
        let expectedTemperature = givenTemparature + 2
        
        XCTAssertEqual(result.icon, givenIcon)
        XCTAssertEqual(result.time, expectedTime)
        XCTAssertEqual(result.temperature, expectedTemperature)
        
    }
    
    //MARK: GIVEN
    
    private func givenWeatherResponse() {
        let currentWeather = CurrentWeather(time: givenTime, humidity: givenHumidity, cloudCover: givenCloudCover, windSpeed: givenWindSpeed, visibility: givenVisibility, temperature: givenTemparature, summary: givenSummary, icon: givenIcon)
        
        var hourlyWeatherList = [HourlyData]()
        for index in 0...25{
            hourlyWeatherList.append(HourlyData(time: givenTime + index, icon: givenIcon, temperature: givenTemparature + Double(index)))
        }
        
        let hourlyWeather = HourlyWeather(data: hourlyWeatherList)
        
        var dailyWeatherList = [DailyData]()
        dailyWeatherList.append(DailyData(timeStamp: givenTime, maxTemp: givenTemparature, minTemp: givenTemparature))
        
        let dailyWeather = DailyWeather(data: dailyWeatherList)
        
        let response = WeatherResponse(currentWeather: currentWeather, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather)
        apiClient.givenWeatherResponse(weatherResponse: response)
    }
    
    private func givenWeatherRequestIsMade() {
        viewModel.getForecast(location: "")
    }
}
