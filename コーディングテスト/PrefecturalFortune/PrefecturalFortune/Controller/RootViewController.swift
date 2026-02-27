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
  @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

  var formItems = FormItems()

  let cellIdentifiers: [String] = ["NameTableViewCell", "DateOfBirthTableViewCell", "BloodTypeTableViewCell"]


  // MARK: - Enums

  enum CellRowType: Int, CaseIterable {

    case nameTableViewCell
    case dateOfBirthTableViewCell
    case bloodTypeTableViewCell
  }

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

    let missingFields = formItems.missingFields()
    if !missingFields.isEmpty {
      // 入力されていないフォームがあった場合の処理
      print("入力されていないフォーム一覧：\(missingFields))")
    }
    // 入力フォームが全て埋まっていた場合の処理
    print(formItems)
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

      cell.delegate = self
      cell.textField.delegate = self
      return cell
      
    case .dateOfBirthTableViewCell:
      let cell: DateOfBirthTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DateOfBirthTableViewCell", for: indexPath) as! DateOfBirthTableViewCell

      cell.delegate = self
      return cell

    case .bloodTypeTableViewCell:
      let cell: BloodTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BloodTypeTableViewCell", for: indexPath) as! BloodTypeTableViewCell

      cell.delegate = self
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

// MARK: - NameTableViewCellDelegate

extension RootViewController: NameTableViewCellDelegate {

  func nameTableViewCell(_ cell: NameTableViewCell, didChangeText text: String) {

    if text == "" {
      return
    }
    formItems.name = text
  }
}

// MARK: - DateOfBirthTableViewCellDelegate

extension RootViewController: DateOfBirthTableViewCellDelegate {

  func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didChangeDate date: Date) {

    formItems.dateOfBirth = date
    cell.textField.text = convertDateToString(date: date)
  }

  func convertDateToString(date: Date) -> String {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.locale = Locale(identifier: "ja_JP")
    return dateFormatter.string(from: date)
  }


  func doneButtonDidTapped(_ cell: DateOfBirthTableViewCell) {

    cell.textField.resignFirstResponder()
  }
}

// MARK: - BloodTypeTableViewCellDelegate

extension RootViewController: BloodTypeTableViewCellDelegate {

  func segmentedControlChangedSegment(_ sender: UISegmentedControl) {

    let selectedType = BloodType.allCases[sender.selectedSegmentIndex]
    formItems.bloodType = selectedType
  }
}
