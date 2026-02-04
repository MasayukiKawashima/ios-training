//
//  CodableStructure.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/01/24.
//

import Foundation

// エンコード用
struct InputInfo: Codable {
  
  var area: String
  var date: Date
}

// デコード用
struct WeatherInfo: Codable {
  
  var maxTemperature: Int
  var date: String
  var minTemperature: Int
  var weatherCondition: String
  
  private enum CodingKeys: String, CodingKey {
    
    case maxTemperature = "max_temperature"
    case date = "date"
    case minTemperature = "min_temperature"
    case weatherCondition = "weather_condition"
  }
}

