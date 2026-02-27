//
//  BloodTypeTableViewCell.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/22.
//

import UIKit

protocol BloodTypeTableViewCellDelegate {

  func segmentedControlChangedSegment(_ sender: UISegmentedControl)
}

class BloodTypeTableViewCell: UITableViewCell {


  // MARK: - Properties

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var errorMessageLabel: UILabel!

  var delegate: BloodTypeTableViewCellDelegate?


  // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  

  // MARK: - Methods

  @IBAction func segmentChangedAction(_ sender: Any) {

    delegate?.segmentedControlChangedSegment(sender as! UISegmentedControl)
  }
}
