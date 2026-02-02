//
//  WeatherProvider.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/01/27.
//

import Foundation
import YumemiWeather

protocol WeatherFetching {
  
  func fetchWeaterInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void)  -> WeaterInfo?
  func fethchWeatherOfSyncVer(input: InputInfo, completion: @escaping(Result<WeaterInfo, WeatherError>) -> Void)
}

class WeatherProvider: WeatherFetching {
  
  //MARK: - Codable Ver
  func fetchWeaterInfoOfCodableVer(input: InputInfo, fetchErrorHandle: @escaping () -> Void)  -> WeaterInfo? {
    
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
  
  //MARK: - Sync Ver
  
  func jsonString(input: InputInfo) throws -> String {
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    let jsonData = try encoder.encode(input)
    
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
      throw WeatherError.jsonEncodeError
    }
    
    return jsonString
  }
  
  func response(jsonString: String) throws -> WeaterInfo {
    
    let decoder = JSONDecoder()
    
    guard let jsonData = jsonString.data(using: .utf8) else {
      throw WeatherError.jsonDecodeError
    }
    
    return  try decoder.decode(WeaterInfo.self, from: jsonData)
  }
  
  func fethchWeatherOfSyncVer(input: InputInfo, completion: @escaping(Result<WeaterInfo, WeatherError>) -> Void) {
    
    if let jsonString = try? jsonString(input: input) {
      DispatchQueue.global().async {
        if let responseJsonString = try? YumemiWeather.syncFetchWeather(jsonString) {
          if let weatherInfo = try? self.response(jsonString: responseJsonString) {
            return completion(.success(weatherInfo))
          } else {
            return completion(.failure(.jsonDecodeError))
          }
        } else {
          return completion(.failure(.unknownError))
        }
      }
    }
  }
  
}
