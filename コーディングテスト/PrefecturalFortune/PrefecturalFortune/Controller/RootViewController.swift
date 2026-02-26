//
//  RootViewController.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

// MARK: - Enums

enum CellRowType: Int, CaseIterable {

  case nameTableViewCell
  case dateOfBirthTableViewCell
  case bloodTypeTableViewCell
}

class RootViewController: UIViewController {

  // MARK: - Properties

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var fortuneButton: UIButton!
  @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

  let cellIdentifiers: [String] = ["NameTableViewCell", "DateOfBirthTableViewCell", "BloodTypeTableViewCell"]

  // MARK: - LifeCycle

  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.isScrollEnabled = false
    tableView.separatorStyle = .none

    registerCells(cellIdentifiers: cellIdentifiers)
    }

  override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      tableView.layoutIfNeeded()
      tableViewHeightConstraint.constant = tableView.contentSize.height
  }

  // MARK: - Methods

  //各セルの登録メソッド
  private func registerCells(cellIdentifiers: [String]) {

    for identifier in cellIdentifiers {
      tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
  }


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
// MARK: - UITableViewDataSource, UITableViewDelegate

extension RootViewController: UITableViewDataSource, UITableViewDelegate {


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return CellRowType.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cellRowType = CellRowType(rawValue: indexPath.row) else {
      print("セル作成エラー")
      return UITableViewCell()
    }

    switch cellRowType {

    case .nameTableViewCell:
      let cell: NameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell

      cell.textField.delegate = self
      return cell
      
    case .dateOfBirthTableViewCell:
      let cell: DateOfBirthTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DateOfBirthTableViewCell", for: indexPath) as! DateOfBirthTableViewCell
      return cell

    case .bloodTypeTableViewCell:
      let cell: BloodTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BloodTypeTableViewCell", for: indexPath) as! BloodTypeTableViewCell
      return cell
    }
  }
}

// MARK: - UITextFieldDelegate

extension RootViewController: UITextFieldDelegate{

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    view.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()
    return true
  }

}

