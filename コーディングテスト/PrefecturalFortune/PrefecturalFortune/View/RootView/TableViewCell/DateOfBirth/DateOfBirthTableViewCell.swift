//
//  DateOfBirthTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

class DateOfBirthTableViewCell: UITableViewCell {

  // MARK: - Properties

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var errorMessageLabel: UILabel!

  // MARK: - LifeCycle

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    setDatePicker()
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
    textField.inputView = datePickerView
  }
}




