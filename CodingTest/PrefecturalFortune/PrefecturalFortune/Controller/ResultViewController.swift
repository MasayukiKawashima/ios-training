//
//  ResultViewController.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/17.
//

import UIKit

class ResultViewController: UIViewController {


  // MARK: - Properties

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var prefecturalNameLabel: UILabel!
  @IBOutlet weak var prefecturalImageView: UIImageView!
  @IBOutlet weak var capitalLabel: UILabel!
  @IBOutlet weak var citizenDayLabel: UILabel!
  @IBOutlet weak var coastLineLabel: UILabel!
  @IBOutlet weak var briefTextView: UITextView!

  var fortune: FortuneResponseBody?

  // MARK: - LifeCycle

  override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }


  // MARK: - Methods


  @IBAction func closeButtonAction(_ sender: Any) {
  }

  private func setUpPrefecturalViews(fortune: FortuneResponseBody?, prefecturalImage: UIImage) {

    guard let fortune = fortune else {
      print("forutne情報が取得されていません")
      return
    }

    prefecturalNameLabel.text = fortune.name

    let combinedCapitalString = "県庁所在地：" + fortune.capital
    capitalLabel.text = combinedCapitalString

    briefTextView.text = fortune.brief

    if let citizenDay = fortune.citizenDay {
      let day = String(citizenDay.day)
      let month = String(citizenDay.month)
      let combinedString = "都道府県民の日： " + month + "月" + day + "日"
      citizenDayLabel.text = combinedString
    } else {
      let combinedString = "都道府県民の日：なし"
      citizenDayLabel.text = combinedString
    }

    if fortune.hasCoastLine {
      coastLineLabel.text = "海岸線: あり"
    } else {
      coastLineLabel.text = "海岸線: なし"
    }

    prefecturalImageView.image = prefecturalImage
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
