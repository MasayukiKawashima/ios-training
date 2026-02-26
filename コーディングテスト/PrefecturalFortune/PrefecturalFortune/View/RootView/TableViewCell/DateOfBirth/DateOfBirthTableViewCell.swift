//
//  DateOfBirthTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

protocol DateOfBirthTableViewCellDelegate {

  func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didChangeDate date: Date)
}

class DateOfBirthTableViewCell: UITableViewCell {

  // MARK: - Properties

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var errorMessageLabel: UILabel!

  var delegate: DateOfBirthTableViewCellDelegate?

  // MARK: - LifeCycle

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    setDatePicker()
    setUpToolBar()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  // MARK: - Methods

  private func setDatePicker() {

    let datePickerView:UIDatePicker = UIDatePicker()
    datePickerView.datePickerMode = UIDatePicker.Mode.date
    datePickerView.preferredDatePickerStyle = .wheels
    datePickerView.locale = Locale(identifier: "ja_JP")
    textField.inputView = datePickerView
    datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
  }

  @objc private func datePickerValueChanged(sender: UIDatePicker) {

    delegate?.dateOfBirthTableViewCell(self, didChangeDate: sender.date)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.locale = Locale(identifier: "ja_JP")
    textField.text = dateFormatter.string(from: sender.date)
  }

  private func setUpToolBar() {

    let toolBar = UIToolbar()
    toolBar.sizeToFit()

    let dummySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "決定", style: .plain, target: self, action: #selector (doneButtonAction))

    toolBar.items = [dummySpace, doneButton]
    textField.inputAccessoryView = toolBar
  }

  @objc private func doneButtonAction() {
    textField.resignFirstResponder()
  }
}




