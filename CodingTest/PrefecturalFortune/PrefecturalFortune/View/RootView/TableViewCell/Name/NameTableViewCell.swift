//
//  NameTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

protocol NameTableViewCellDelegate {

  func nameTableViewCell(_ cell: NameTableViewCell, didChangeText text: String)
  func nameTableViewCell(_ cell: NameTableViewCell, didEndEditing text: String?)
  func nameTableViewCell(_ cell: NameTableViewCell, shouldReturn text: String?) -> Bool
}

class NameTableViewCell: UITableViewCell {


  // MARK: - Properties
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var errorMessageLabel: UILabel!

  var delegate: NameTableViewCellDelegate?
  

  // MARK: - LifeCycle

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    textField.delegate = self
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  // MARK: - Methods

  @objc private func textDidChange(_ sender: UITextField) {
    delegate?.nameTableViewCell(self, didChangeText: sender.text ?? "")
  }
}


// MARK: - UITextFieldDelegate

extension NameTableViewCell: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return delegate!.nameTableViewCell(self, shouldReturn: textField.text ?? "")
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.nameTableViewCell(self, didEndEditing: textField.text ?? "")
  }
}
