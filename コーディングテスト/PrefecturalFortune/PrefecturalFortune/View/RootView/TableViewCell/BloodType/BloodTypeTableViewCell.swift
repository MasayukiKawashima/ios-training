//
//  BloodTypeTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

class BloodTypeTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var errorMessageLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
