//
//  ViewControllerTests.swift
//  YumemiWeatherAppTests
//
//  Created by 川島真之 on 2026/01/29.
//

import XCTest
@testable import YumemiWeatherApp

final class ViewControllerTests: XCTestCase {
  
  var viewController: ViewController!
  var weatherProvider: WeatherProviderMock!
  let inputInfo = InputInfo(area: "Tokyo", date: Date())
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    weatherProvider = WeatherProviderMock()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard.instantiateViewController(identifier: "MainVC") as ViewController
    viewController.weaterProvider = weatherProvider
    _ = viewController.view
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_天気予報がsunnyだったらImageViewのimageにsunnyが設定されること() throws {
    
    let sunnyInfo = WeaterInfo(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: "sunny")
    
    weatherProvider.fetchHandler = { _ in
      return sunnyInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Sunny")!)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

class WeatherProviderMock: WeatherFetching {
  
  var fetchHandler: ((InputInfo)  -> WeaterInfo)!
  
  func fetchWeaterInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void) -> WeaterInfo? {
    return  fetchHandler(input)
  }
}
