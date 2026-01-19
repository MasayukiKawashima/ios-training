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
    
  }
  
  @IBAction func reloadButtonAction(_ sender: Any) {
    setWeaterImageOfThorowsVer()
  }
  
  // fetchWeatherCondition()のThrows verのメソッド
  private func setWeaterImageOfThorowsVer() {
    
    do {
      let result = try YumemiWeather.fetchWeatherCondition(at: "東京")
      setImageWhenFetchWeatherConditionSucceeded(result: result)
    } catch {
      displayErrorAlert()
    }
  }
  // fetchWeatherCondition()のsimple Verのメソッド
  private func setWeaterImageOfSimpleVer() {
    
    let result = YumemiWeather.fetchWeatherCondition()
    setImageWhenFetchWeatherConditionSucceeded(result: result)
  }
  
  // フェッチが成功した時に画像をセットするメソッド
  private func setImageWhenFetchWeatherConditionSucceeded(result: String) {
    
    switch result {
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
  private func displayErrorAlert() {
    
    let alert = UIAlertController(title: "天気情報を取得できませんでした", message: "再読み込みをしてください", preferredStyle: .alert)
    let reloadAction = UIAlertAction(title: "再読み込み", style: .default) { _ in
      alert.dismiss(animated: true, completion: nil)
      self.setWeaterImageOfThorowsVer()
    }
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
    
    alert.addAction(reloadAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }
  
}

