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
  
  @IBOutlet weak var weatherImageView: UIImageView!
  
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  
 
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var reloadButton: UIButton!
  

  
  var weaterProvider: WeatherFetching!
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    weaterProvider.delegate = self
    
    indicator.hidesWhenStopped = true
    
    // NotificationCenterでアプリがバックグラウンドからフォアグラウンドに移行することを監視
    NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
  }
  
  deinit {
    print("deinitされました")
  }
  
  //MARK: - Methods
  
  //MARK: - IBAction
  @IBAction func closeButtonAction(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func reloadButtonAction(_ sender: Any) {
    self.indicator.startAnimating()
    let inputInfo = InputInfo(area: "Tokyo", date: Date())
    
    settingWeatherImageOfSyncAndDelegateVer(input: inputInfo)
  }
  
  //MARK: - NotificationCenter ObserverMethod
  
  @objc func applicationWillEnterForeground() {
    
    //フォアグラウンドに戻った時の処理
    let inputInfo = InputInfo(area: "Tokyo", date: Date())
    
    settingWeatherImageOfSyncAndDelegateVer(input: inputInfo)
  }
  
  //MARK: - Sync ver
  
  func settingWeatherImageOfSyncVer(input: InputInfo, completion: ((Result<WeatherInfo, WeatherError>) -> Void)? = nil) {
    
    weaterProvider.fethchWeatherOfSyncVer(input: input) { result in
      
      DispatchQueue.main.async {
        self.indicator.stopAnimating()
        
        switch result {
        case .success(let response):
          self.setWeatherImageInfo(weatherInfo: response)
        case .failure(let error):
          switch error {
          case .jsonEncodeError:
            print("エンコードに失敗しました")
          case .jsonDecodeError:
            print("デコードに失敗しました")
          case .unknownError:
            self.displayErrorAlert {
              self.indicator.startAnimating()
              self.settingWeatherImageOfSyncVer(input: input, completion: completion)
            }
          }
        }
        //テスト用
        guard let completion = completion else { return }
        completion(result)
      }
    }
  }
  
  //MARK: - SyncAndDelegate ver
  
  func settingWeatherImageOfSyncAndDelegateVer(input: InputInfo, completion: ((Result<WeatherInfo, WeatherError>) -> Void)? = nil) {
    
    weaterProvider.fetchWeaterOfSyncAndDelegateVer(input: input, completion: completion)
  }
  
  //MARK: - Throws ver
  
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
  
  //MARK: - Simple ver
  // fetchWeatherCondition()のsimple Verのメソッド
  private func setWeaterImageOfSimpleVer() {
    
    let result = YumemiWeather.fetchWeatherCondition()
    setWeatherCondtionImage(imageString: result)
  }
  
  //MARK: - Json ver
  
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
  
  //MARK: - Codable ver
  
  // 天気情報の取得からUI部品へのセットまでのメソッド
  func settingWeatherImageOfCodableVer(input: InputInfo) {
    
    let fetchErrorHandle = {
      print("天気情報の取得失敗")
      self.displayErrorAlert {
        self.settingWeatherImageOfCodableVer(input: input)
      }
    }
    
    let result = weaterProvider.fetchWeatherInfoOfCodableVer(input: input, fetchErrorHandle: fetchErrorHandle)
    
    if let result = result {
      setWeatherImageInfo(weatherInfo: result)
    } else {
      displayErrorAlert {
        self.settingWeatherImageOfCodableVer(input: input)
      }
    }
  }
  
  //MARK: - Common
  
  // 各UI部品に値をセットするメソッド
  private func setWeatherImageInfo(weatherInfo: WeatherInfo) {
    
    
    let maxTemperatureString = String(weatherInfo.maxTemperature)
    let minTemperatureString = String(weatherInfo.minTemperature)
    
    maxTempLabel.text = maxTemperatureString
    minTempLabel.text = minTemperatureString
    let weatherCondition = weatherInfo.weatherCondition
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
  
  func weatherProviderInjection (weatherProvider: WeatherProvider) {
    self.weaterProvider = weatherProvider
  }
}

extension ViewController: WeatherProviderDelegate {
  
  func weatherProvider(_ weatherProvider: WeatherProvider, didFetchWeatherInfo result: Result<WeatherInfo, WeatherError>, inputInfo: InputInfo, completion: ((Result<WeatherInfo, WeatherError>) -> Void)?) {
    
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      
      switch result {
      case .success(let response):
        self.setWeatherImageInfo(weatherInfo: response)
      case .failure(let error):
        switch error {
        case .jsonEncodeError:
          print("エンコードに失敗しました")
        case .jsonDecodeError:
          print("デコードに失敗しました")
        case .unknownError:
          self.displayErrorAlert {
            self.indicator.startAnimating()
            self.settingWeatherImageOfSyncAndDelegateVer(input: inputInfo)
          }
        }
      }
      //テスト用
      guard let completion = completion else { return }
      completion(result)
    }
  }
}
