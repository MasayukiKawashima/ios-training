//
//  FirstDisplayViewController.swift
//  YumemiWeatherApp
//
//  Created by 川島真之 on 2026/01/25.
//

import UIKit

class FirstDisplayViewController: UIViewController {
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let nextVC = storyboard.instantiateViewController(identifier: "MainVC") as! ViewController
    
    // weatherProviderの注入
    let weatherProvider = WeatherProvider()
    nextVC.weatherProviderInjection(weatherProvider: weatherProvider)
    
    nextVC.modalPresentationStyle = .fullScreen
    
    self.present(nextVC, animated: true, completion: nil)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
