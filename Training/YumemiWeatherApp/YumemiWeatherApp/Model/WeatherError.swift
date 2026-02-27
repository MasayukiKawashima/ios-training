//
//  WeatherError.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/02/02.
//

import Foundation


enum WeatherError: Error {
    case jsonEncodeError
    case jsonDecodeError
    case unknownError
}
