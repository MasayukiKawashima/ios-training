//
//  JSONStringProvider.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/02/11.
//

import Foundation
import YumemiWeather

protocol JSONStringFetching {
  
  func wrappedSyncFetchWeather(jsonString: String) throws -> String
}
class JSONStringProvider: JSONStringFetching {
  
  func wrappedSyncFetchWeather(jsonString: String) throws -> String {
    return try YumemiWeather.syncFetchWeather(jsonString)
  }
  
}
