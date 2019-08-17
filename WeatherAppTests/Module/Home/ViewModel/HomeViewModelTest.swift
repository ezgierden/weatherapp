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
    
    func testExample() {
        XCTAssertEqual(1 + 1 , 2)
    }
    
    func testPageTitle() {
        let viewModel = makeSUT()
        XCTAssertEqual("Boston, MA", viewModel.getLocation())
    }
    
    private func makeSUT() -> HomeViewModel {
        return HomeViewModel(apiClient: WeatherAPIClient())
    }
    
}


