//
//  WeatherProvider.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/01/27.
//

import Foundation
import YumemiWeather

protocol WeatherFetching {
  
  func fetchWeaterInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void) -> WeaterInfo?
}

class WeatherProvider: WeatherFetching {
  
  func fetchWeaterInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void) -> WeaterInfo? {
    
    // 元データの作成
    let inputData = input
    var inputJsonString = String()
    var outputJsonString = String()
    
    // JSONにエンコードし、Stringに変換
    do {
      let encoder = JSONEncoder()
      encoder.dateEncodingStrategy = .iso8601
      let jsonData = try encoder.encode(inputData)
      inputJsonString = String(data: jsonData, encoding: .utf8)!
    } catch {
      print("InputのJSONエンコードに失敗")
      
      return nil
    }
    // フェッチ
    do {
      outputJsonString = try YumemiWeather.fetchWeather(inputJsonString)
    } catch {
  
      fetchErrorHandle()
      return nil
    }
    
    //　JSONにエンコードして各値を抽出
    let data = Data(outputJsonString.utf8)
    let decoder = JSONDecoder()
    let result = try! decoder.decode(WeaterInfo.self, from: data)
    
    return result
  }
}
