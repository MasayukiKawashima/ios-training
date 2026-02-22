//
//  RootViewController.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

class RootViewController: UIViewController {

  // MARK: - Properties

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var fortuneButton: UIButton!

  // MARK: - LifeCycle
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  // MARK: - Methods
  @IBAction func fortuneButtonAction(_ sender: Any) {
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
