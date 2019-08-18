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
        XCTAssertEqual("Boston, MA", viewModel.getLocation())
    }
    
    func testFormatDate() {
        let givenDate = Date(timeIntervalSince1970: TimeInterval(710777599))
        let result = viewModel.formatDate(date: givenDate)
        
        XCTAssertEqual(result, "July, 10")
    }
    
    func testFormatDateToHour() {
        let givenDate = Date(timeIntervalSince1970: TimeInterval(710777599))
        let result = viewModel.formatDateToHour(date: givenDate)
        
        XCTAssertEqual(result, "14")
    }
    
    func testGivenWeatherResponseIsSuccessful_whenGetHumidity_thenReturnsValidValue(){
        givenWeatherResponse()
        givenWeatherRequestIsMade()
        
        //WHEN
        
        let result = viewModel.getHumidity()
        
        //THEN
        
        XCTAssertEqual(result, "12.5")
    }
    
    func testGivenWeatherResponseIsSuccessfull_whenGetBackgroundImageName_thenReturnsValidValue() {
        givenWeatherResponse ()
        givenWeatherRequestIsMade()
        
        let result = viewModel.getBackgroundImageName()
        
        XCTAssertEqual(result, "some_iconBG")
    }
    
    //MARK: GIVEN
    private func givenWeatherResponse() {
        let currentWeather = CurrentWeather(time: givenTime, humidity: givenHumidity, cloudCover: givenCloudCover, windSpeed: givenWindSpeed, visibility: givenVisibility, temperature: givenTemparature, summary: givenSummary, icon: givenIcon)
        
        let hourlyWeather = HourlyWeather(data: [])
        let dailyWeather = DailyWeather(data: [])
        
        let response = WeatherResponse(currentWeather: currentWeather, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather)
        apiClient.givenWeatherResponse(weatherResponse: response)
    }
    
    private func givenWeatherRequestIsMade() {
        viewModel.getForecast(location: "") {
            // Ignore
        }
    }
    
    //MARK: WHEN
}
