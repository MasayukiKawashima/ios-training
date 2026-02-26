//
//  NameTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

protocol NameTableViewCellDelegate {

  func nameTableViewCell(_ cell: NameTableViewCell, didChangeText text: String)
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
