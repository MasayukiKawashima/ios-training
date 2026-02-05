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
    weatherProvider.delegate = viewController
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  //MARK: - Codable Ver Tests
  func test_CodableVer_天気予報がsunnyだったらImageViewのimageにSunnyが設定されること() throws {
    
    let sunnyInfo = WeatherInfo(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: "sunny")
    
    weatherProvider.fetchHandler = { _ in
      return sunnyInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Sunny")!)
  }
  
  func test_CodableVer_天気予報がcloudyだったらImageViewのimageにCloudyが設定されること() throws {
    
    let cloudyInfo = WeatherInfo(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: "cloudy")
    
    weatherProvider.fetchHandler = { _ in
      return cloudyInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Cloudy")!)
  }
  
  func test_CodableVer_天気予報がrainyだったらImageViewのimageにRainyが設定されること() throws {
    
    let rainyInfo = WeatherInfo(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: "rainy")
    
    weatherProvider.fetchHandler = { _ in
      return rainyInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Rainy")!)
  }
  
  func test_CodableVer_天気予報の最高気温がmaxTempLabelのtextに設定されること() throws {
    
    let maxTempInfo = WeatherInfo(maxTemperature: 100, date: "", minTemperature: 0, weatherCondition: "sunny")
    
    weatherProvider.fetchHandler = { _ in
      return maxTempInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.maxTempLabel.text, String(maxTempInfo.maxTemperature))
  }
  
  func test_CodableVer_天気予報の最高気温がminTempLabelのtextに設定されること() throws {
    
    let minTempInfo = WeatherInfo(maxTemperature: 0, date: "", minTemperature: 5, weatherCondition: "sunny")
    
    weatherProvider.fetchHandler = { _ in
      return minTempInfo
    }
    
    viewController.settingWeatherImageOfCodableVer(input: inputInfo)
    XCTAssertEqual(viewController.minTempLabel.text, String(minTempInfo.minTemperature))
  }
  
  //MARK: - Sync Ver Tests
  
  func test_SyncVer_天気予報がSunnyだったらImageViewのimageにSunnyが設定されること() throws {
    
    let weatherInfo = WeatherInfo(maxTemperature: 0, date: "", minTemperature: 0, weatherCondition: "sunny")
    
    weatherProvider.resultStub = .success(weatherInfo)
    
    let expectation = XCTestExpectation(description: "Weather fetched")
    
    viewController.settingWeatherImageOfSyncVer(input: inputInfo) { result in
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
    XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Sunny")!)
  }
  
  func test_SyncVer_天気予報の最高気温がmaxTempLabelのtextに設定されること() {
    
    let weatherInfo = WeatherInfo(maxTemperature: 35, date: "", minTemperature: 0, weatherCondition: "sunny")
    
    weatherProvider.resultStub = .success(weatherInfo)
    
    let expectation = XCTestExpectation(description: "Weather fetched")
    
    viewController.settingWeatherImageOfSyncVer(input: inputInfo) { result in
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
    XCTAssertEqual(viewController.maxTempLabel.text, String(weatherInfo.maxTemperature))
  }
  
  //MARK: - SyncAndDelegate Ver Tests
  
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

class WeatherProviderMock: WeatherFetching {
  
  var fetchHandler: ((InputInfo) -> WeatherInfo)!
  var resultStub: Result<WeatherInfo, WeatherError>!
  var delegate: WeatherProviderDelegate?
  var expectation: XCTestExpectation?
  
  func fetchWeatherInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void) -> WeatherInfo? {
    return  fetchHandler(input)
  }
  
  func fethchWeatherOfSyncVer(input: InputInfo, completion: @escaping (Result<WeatherInfo, WeatherError>) -> Void) {
    return completion(resultStub)
  }
  
  func fetchWeaterOfSyncAndDelegateVer(input: InputInfo) {
    
    self.delegate?.weatherProvider(self, didFetchWeatherInfo: self.resultStub, inputInfo: input)
    
    self.expectation?.fulfill()
  }
  
  func fetchWeatherOfSyncAndConcurrencyVer(input: YumemiWeatherApp.InputInfo) async throws -> (Result<YumemiWeatherApp.WeatherInfo, YumemiWeatherApp.WeatherError>) {
    <#code#>
  }
}
