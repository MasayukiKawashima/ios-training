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


  // MARK: - LifeCycle

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


  // MARK: - Methods


  @IBAction func closeButtonAction(_ sender: Any) {
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
