//
//  WeatherProviderTest.swift
//  YumemiWeatherAppTests
//
//  Created by 川島真之 on 2026/02/11.
//

import XCTest
@testable import YumemiWeatherApp

final class WeatherProviderTest: XCTestCase {
  
  var weatherProvider: WeatherFetching!
  var mockJSONStringProvider: MockJSONStringProvider!
  let inputInfo = InputInfo(area: "Tokyo", date: Date())
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mockJSONStringProvider = MockJSONStringProvider()
    weatherProvider = WeatherProvider(jsonStringProvider: mockJSONStringProvider)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testFetchWeatherOfSyncAndConcurrencyAndThrowsVerWhenSuccess() throws {
    
    Task {
      let dummyResponseString = """
{
    "max_temperature": 25,
    "date": "2020-04-01T12:00:00+09:00",
    "min_temperature": 7,
    "weather_condition": "cloudy"
}
"""
      
      mockJSONStringProvider.fetchHandler = { _ in
        return dummyResponseString
      }
      
      let result = try? await weatherProvider.fetchWeatherOfSyncAndConcurrencyAndThrowsVer(input: inputInfo)
      
      print(result!)
      XCTAssertTrue(result != nil)
    }
  }
    
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }
    
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

class MockJSONStringProvider: JSONStringFetching {
  
  var fetchHandler:((String) -> String)!
  
  func wrappedSyncFetchWeather(jsonString: String) throws -> String {
    return fetchHandler(jsonString)
  }
}
