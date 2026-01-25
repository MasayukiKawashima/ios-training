//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/01/16.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
  
  
  //MARK: - Properties
  
  //MARK: IBoutlet
  
  @IBOutlet weak var weatherImageView: UIImageView!
  
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var reloadButton: UIButton!
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  //MARK: -  Methods
  
  //MARK: IBAction
  @IBAction func closeButtonAction(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func reloadButtonAction(_ sender: Any) {
    
    let inputInfo = inputInfo(area: "Tokyo", date: Date())
    
    print ("最初のinputInfo構造体のデータ\(inputInfo)")
    setWeatherImageOfCodableVer(input: inputInfo)
  }
  
  // fetchWeatherCondition()のThrows verのメソッド
  private func setWeaterImageOfThorowsVer() {
    
    do {
      let result = try YumemiWeather.fetchWeatherCondition(at: "東京")
      setWeatherCondtionImage(imageString: result)
    } catch {
      displayErrorAlert {
        self.setWeaterImageOfThorowsVer()
      }
    }
  }
  // fetchWeatherCondition()のsimple Verのメソッド
  private func setWeaterImageOfSimpleVer() {
    
    let result = YumemiWeather.fetchWeatherCondition()
    setWeatherCondtionImage(imageString: result)
  }
  
  //fetchWeather()のJSON Verのメソッド
  private func setWeatherImageOfJSONVer(input: [String: Any]) {
    
    // 元データの作成
    let inputData = input
    var inputJsonString = String()
    var outputJsonString = String()
    
    // JSONにエンコードし、Stringに変換
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: inputData, options: [])
      inputJsonString = String(data: jsonData, encoding: .utf8)!
    } catch {
      print("InputのJSONエンコードに失敗")
      
      return
    }
    
    // フェッチ
    do {
      outputJsonString = try YumemiWeather.fetchWeather(inputJsonString)
    } catch {
      print("天気情報の取得失敗")
      displayErrorAlert {
        self.setWeatherImageOfJSONVer(input: inputData)
      }
      
      return
    }
    
    //　JSONにエンコードして各値を抽出
    let data = Data(outputJsonString.utf8)
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
      
      let maxTemperature = json["max_temperature"] as! Double
      let minTemperature = json["min_temperature"] as! Double
      let weatherCondition = json["weather_condition"] as! String
      
      // 各値をUIに表示
      maxTempLabel.text = String(maxTemperature)
      minTempLabel.text = String(minTemperature)
      setWeatherCondtionImage(imageString: weatherCondition)
    } catch {
      print("OutputのJSON解析に失敗")
      
      return
    }
  }
  
  //Codableを使用したfetchWeather()のJSON Verのメソッド
  private func setWeatherImageOfCodableVer(input: inputInfo) {
    
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
      
      return
    }
    
    print ("フェッチ直前のinputJsonString\(inputJsonString)")
    
    // フェッチ
    do {
      outputJsonString = try YumemiWeather.fetchWeather(inputJsonString)
    } catch {
      print("天気情報の取得失敗")
      displayErrorAlert {
        self.setWeatherImageOfCodableVer(input: inputData)
      }
      
      return
    }
    
    print("フェッチ直後のoutputJsonString\(outputJsonString)")
    
    //　JSONにエンコードして各値を抽出
    let data = Data(outputJsonString.utf8)
    
    let decoder = JSONDecoder()
    let result = try! decoder.decode(weaterInfo.self, from: data)
    
    // 各値をUIに表示
    let maxTemperatureString = String(result.maxTemperature)
    let minTemperatureString = String(result.minTemperature)
    
    maxTempLabel.text = maxTemperatureString
    minTempLabel.text = minTemperatureString
    let weatherCondition = result.weatherCondition
    setWeatherCondtionImage(imageString: weatherCondition)
  }
  
  // weatherConditionImageをセットするメソッド
  private func setWeatherCondtionImage(imageString: String) {
    
    switch imageString {
    case "sunny":
      weatherImageView.image = UIImage(named: "Sunny")
    case "cloudy":
      weatherImageView.image = UIImage(named: "Cloudy")
    case "rainy":
      weatherImageView.image = UIImage(named: "Rainy")
    default:
      break
    }
  }
  
  // WeatherConditionのフェッチに失敗したときのアラートを表示するメソッド
  private func displayErrorAlert(reloadActionMethod: @escaping () -> Void) {
    
    let alert = UIAlertController(title: "天気情報を取得できませんでした", message: "再読み込みをしてください", preferredStyle: .alert)
    let reloadAction = UIAlertAction(title: "再読み込み", style: .default) { _ in
      reloadActionMethod()
      alert.dismiss(animated: true, completion: nil)
    }
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    
    alert.addAction(reloadAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }
}


