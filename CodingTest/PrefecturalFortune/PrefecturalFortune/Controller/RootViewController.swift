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
  let cellErrorMessage = "入力エラー"


  // MARK: - Enums

  enum CellRowType: Int, CaseIterable {

    case nameTableViewCell
    case dateOfBirthTableViewCell
    case bloodTypeTableViewCell
  }

  enum FormField {
    case name
    case dateOfBirth
    case bloodType
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

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    view.endEditing(true)
  }


  @IBAction func fortuneButtonAction(_ sender: Any) {

  }

  private func testFetchFortuneContents() async -> (FortuneRequest.Response, UIImage)? {
    do {
      let result = try await testRequest()
      let logoURL = URL(string: result.logoURL)

      if let url = logoURL {
        let image = try await testFetchImage(url: url)
        if let image = image {
          return (result, image)
        }
      }
    } catch {
      print(error)
    }
    return nil
  }

  private func testRequest() async throws -> FortuneRequest.Response {

    let apiClient = APIClient(session: URLSession.shared)

    let todayDate = Date()
    let components = Calendar.current.dateComponents([.year, .month, .day], from: todayDate)
    let todayYear = components.year!
    let todayMonth = components.month!
    let todayDay = components.day!

    let name = "ゆめみん"
    let birthday = YearMonthDay(year: 2000, month: 1, day: 27)
    let bloodType = BloodType.ab.rawValue
    let today = YearMonthDay(year: todayYear, month: todayMonth, day: todayDay)

    let stub = FortuneRequestBody(name: name, birthday: birthday, bloodType: bloodType, today: today)
    print("------------------------------------------------------")
    print("リクエスト作成前のリクエストBody")
    print(stub)
    print("------------------------------------------------------")
    let request = FortuneRequest(body: stub)

      let result = try await apiClient.request(request)
      print("------------------------------------------------------")
      print("デコード後のレスポンスデータ")
      print(result)
      print("------------------------------------------------------")
      return result
  }

  private func testFetchImage(url: URL) async throws -> UIImage? {

    let imageFetcher = ImageFetcher(session: URLSession.shared)
    let result: UIImage?

    let resultData = try await imageFetcher.fetch(url: url)
    result = UIImage(data: resultData)
    return result
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  func showValidationErrorAlert(title: String, message: String, completionHandler: @escaping () -> Void) {
    let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
      completionHandler()
    }
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
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
      cell.errorMessageLabel.isHidden = true
      cell.delegate = self
      return cell
      
    case .dateOfBirthTableViewCell:
      let cell: DateOfBirthTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DateOfBirthTableViewCell", for: indexPath) as! DateOfBirthTableViewCell
      cell.errorMessageLabel.isHidden = true
      cell.delegate = self
      return cell

    case .bloodTypeTableViewCell:
      let cell: BloodTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BloodTypeTableViewCell", for: indexPath) as! BloodTypeTableViewCell
      cell.errorMessageLabel.isHidden = true
      let defaultBloodType: BloodType = .a
      formItems.bloodType = defaultBloodType
      cell.delegate = self
      return cell
    }
  }
}

// MARK: - UITextFieldDelegate

extension RootViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()
    return true
  }
}


// MARK: - NameTableViewCellDelegate

extension RootViewController: NameTableViewCellDelegate {
  func nameTableViewCell(_ cell: NameTableViewCell, didEndEditing text: String?) {
    guard let text else {
      print("名前フォームの値がnilです")
      return
    }
    let result = nameTextFieldValidate(value: text)

    // バリデーション後のハンドル

    switch result {
      case .valid:
      print("有効な値です")
      formItems.name = text
    case .invalid(let reason):

    }
    print("名前バリデーションの結果：\(result)")
  }

  private func nameTextFieldValidate(value: String) -> FormValidationState {
    let nameValidator = NameValidator()
    let result = nameValidator.validate(value)
    return result.result()
  }

  func nameTableViewCell(_ cell: NameTableViewCell, shouldReturn text: String?) -> Bool {
    cell.textField.resignFirstResponder()
    return true
  }
  
  func nameTableViewCell(_ cell: NameTableViewCell, didChangeText text: String) {
  }
}


// MARK: - DateOfBirthTableViewCellDelegate

extension RootViewController: DateOfBirthTableViewCellDelegate {
  func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didEndEditing text: String?) {
    guard let text else {
      print("誕生日フォームの値がnilです")
      return
    }

    let result = dateOfBirthTextFieldValidate(value: text)
    print("誕生日バリデーションの結果：\(result)")

    // バリデーション後のハンドル。
    let date = convertStringToDate(string: text)
    formItems.dateOfBirth = date
  }

  private func dateOfBirthTextFieldValidate(value: String) -> FormValidationState {
    let dateOfBirthValidator = DateOfBirthValidator()
    let result = dateOfBirthValidator.validate(value)
    return result.result()
  }


  func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didChangeDate date: Date) {
    cell.textField.text = convertDateToString(date: date)
  }

  private func convertDateToString(date: Date) -> String {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    return dateFormatter.string(from: date)
  }

  private func convertStringToDate(string: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

    guard let date = dateFormatter.date(from: string) else {
      print("変換失敗")
      return nil
    }
    return date
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
