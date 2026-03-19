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

    guard let fortune else {
      print("forutne情報が取得されていません")
      return
    }

    Task {
      let prefecturalImage = await fetchPrefecturalImage(urlString: fortune.logoURL)
      self.prefecturalImageView.image = prefecturalImage
    }
    setUpPrefecturalViews(fortune: fortune)
    // Do any additional setup after loading the view.
  }


  // MARK: - Methods


  @IBAction func closeButtonAction(_ sender: Any) {
  }

  private func setUpPrefecturalViews(fortune: FortuneResponseBody) {
    prefecturalNameLabel.text = fortune.name
    capitalLabel.text = FortuneResultText.fullCapitalText(capital: fortune.capital)
    briefTextView.text = fortune.brief
    citizenDayLabel.text = FortuneResultText.fullCitizenDayText(citizenDay: fortune.citizenDay)
    coastLineLabel.text = FortuneResultText.fullCoastLineText(hasCoastLine: fortune.hasCoastLine)
  }

  private func fetchPrefecturalImage(urlString: String) async -> UIImage? {
    let imageFetcher = ImageDataFetcher(session: URLSession.shared)
    let logoURL = URL(string: urlString)
    guard let url = logoURL else {
      print("画像URLの変換エラー")
      return nil
    }
    do {
      let resultData = try await imageFetcher.fetch(url: url)
      return UIImage(data: resultData)
    } catch {
      print("画像の取得失敗。エラー内容:\(error)")
      return nil
    }
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
