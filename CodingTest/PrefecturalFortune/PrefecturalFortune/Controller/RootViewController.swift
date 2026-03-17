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

  var formItems = RootFormItems()

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

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }


  @IBAction func fortuneButtonAction(_ sender: Any) {
    formItemsValidate(validator: RootFormItemsValidator(), value: self.formItems) { result in
      switch result.result() {
      case .valid:
        print("FormItemsのバリデーション結果：問題なし")
        Task {
          let fortuneRequestBody = createFortuneRequestBody()
          do {
            let fortuneResponse = try await executeFortuneRequest(body: fortuneRequestBody)
            print("------------------------------------------------------")
            print("デコード後のレスポンスデータ")
            print(fortuneResponse)
            print("------------------------------------------------------")
//            guard let prefecturalImage = await fetchPrefecturalImage(urlString: fortuneResponse.logoURL) else {
//              return
//            }
//            print("------------------------------------------------------")
//            print("画像")
//            print(prefecturalImage)
//            print("------------------------------------------------------")

            // 画面遷移
            // fortuneResponseを渡しながらモーダル（フルスクリーン）遷移
            // 画像の取得はモーダルViewControllerで行う

            presentResultViewController(fortune: fortuneResponse)

          } catch {
            print("最終的に上がってきたAPI通信エラー\(error)")
          }
        }
      case.invalid(let error):
        print("FormItemsのバリデーション結果：問題発生!!!")
        let title = RootFormItemsValidationAlertText.title
        let message = RootFormItemsValidationAlertText.message(error as! RootFormItemsValidationError)
        showValidationErrorAlert(title: title, message: message)
      }
    }
  }

  private func createFortuneRequestBody() -> FortuneRequestBody {
    let name = formItems.name!
    let bloodType = formItems.bloodType!.rawValue

    let birthday = convertToYearMonthDay(date: formItems.dateOfBirth!)
    let today = convertToYearMonthDay(date: Date())

    let body = FortuneRequestBody(
      name: name,
      birthday: birthday,
      bloodType: bloodType,
      today: today
    )
    return body
  }

  private func convertToYearMonthDay(date: Date) -> YearMonthDay {
    let components = Calendar.current.dateComponents([.year, .month, .day], from: date)

    return YearMonthDay(
      year: components.year!,
      month: components.month!,
      day: components.day!
    )
  }

  private func executeFortuneRequest(body: FortuneRequestBody) async throws -> FortuneRequest.Response {
    let request = FortuneRequest(body: body)
    let apiClient = APIClient(session: URLSession.shared)
    let response = try await apiClient.request(request)
    return response
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

  func presentResultViewController(fortune: FortuneResponseBody) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    guard let resultVC = storyboard.instantiateViewController(
      withIdentifier: "ResultViewController"
    ) as? ResultViewController else {
      print("ResultVCイニシャライズ失敗")
      return
    }
    resultVC.fortune = fortune
    resultVC.modalPresentationStyle = .fullScreen
    present(resultVC, animated: true, completion: nil)
  }

//  private func testFetchFortuneContents() async -> (FortuneRequest.Response, UIImage)? {
//    do {
//      let result = try await testRequest()
//      let logoURL = URL(string: result.logoURL)
//
//      if let url = logoURL {
//        let image = try await testFetchImage(url: url)
//        if let image = image {
//          return (result, image)
//        }
//      }
//    } catch {
//      print(error)
//    }
//    return nil
//  }
//
//  private func testRequest() async throws -> FortuneRequest.Response {
//
//    let apiClient = APIClient(session: URLSession.shared)
//
//    let todayDate = Date()
//    let components = Calendar.current.dateComponents([.year, .month, .day], from: todayDate)
//    let todayYear = components.year!
//    let todayMonth = components.month!
//    let todayDay = components.day!
//
//    let name = "ゆめみん"
//    let birthday = YearMonthDay(year: 2000, month: 1, day: 27)
//    let bloodType = BloodType.ab.rawValue
//    let today = YearMonthDay(year: todayYear, month: todayMonth, day: todayDay)
//
//    let stub = FortuneRequestBody(name: name, birthday: birthday, bloodType: bloodType, today: today)
//    print("------------------------------------------------------")
//    print("リクエスト作成前のリクエストBody")
//    print(stub)
//    print("------------------------------------------------------")
//    let request = FortuneRequest(body: stub)
//
//      let result = try await apiClient.request(request)
//      print("------------------------------------------------------")
//      print("デコード後のレスポンスデータ")
//      print(result)
//      print("------------------------------------------------------")
//      return result
//  }
//
//  private func testFetchImage(url: URL) async throws -> UIImage? {
//
//    let imageFetcher = ImageFetcher(session: URLSession.shared)
//    let result: UIImage?
//
//    let resultData = try await imageFetcher.fetch(url: url)
//    result = UIImage(data: resultData)
//    return result
//  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  private func formItemsValidate(validator: RootFormItemsValidator,
                                 value: RootFormItems,
                                 completionHandler: (_ result: ValidationResult) -> Void) {
    let validationResult = validator.validate(value)
    completionHandler(validationResult)
  }

  private func formsValidate(validator: any RootFormValidator,
                            value: String,
                            completionHandler: (_ result: ValidationResult) -> Void) {
    let validationResult = validator.validate(value)
    completionHandler(validationResult)
  }

  private func formsValidationAlertOKActionHandle(textField: UITextField) {
    DispatchQueue.main.async {
      textField.becomeFirstResponder()
      DispatchQueue.main.async {
        textField.selectAll(nil)
      }
    }
  }

  private func showValidationErrorAlert(title: String, message: String, completionHandler: (() -> Void)? = nil) {
    let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
      completionHandler?()
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

    formsValidate(validator: NameValidator(), value: text) { result in
      switch result.result() {
      case .valid:
        formItems.name = text
      case.invalid(let error):
        let title = RootFormValidationAlertText.title
        let message = RootFormValidationAlertText.message(error as! FormValidationError)
        showValidationErrorAlert(title: title, message: message) {
          self.formsValidationAlertOKActionHandle(textField: cell.textField)
        }
      }
    }
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

    formsValidate(validator: DateOfBirthValidator(), value: text) { result in
      switch result.result() {
      case .valid:
        let date = convertStringToDate(string: text)
        formItems.dateOfBirth = date
      case.invalid(let error):
        let title = RootFormValidationAlertText.title
        let message = RootFormValidationAlertText.message(error as! FormValidationError)
        showValidationErrorAlert(title: title, message: message) {
          self.formsValidationAlertOKActionHandle(textField: cell.textField)
        }
      }
    }
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
