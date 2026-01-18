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
    let result = YumemiWeather.fetchWeatherCondition()
    
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
  
  
}

