//
//  OtherUsersProfileTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/02/27.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class OtherUsersProfileTableViewCell: UITableViewCell {
   
   @IBOutlet weak var OtherUsersNameImageView: UIImageView!
   @IBOutlet weak var OtherUsersNameLabel: UILabel!
   
   @IBOutlet weak var OtherUsersPostedStageImageView: UIImageView!
   @IBOutlet weak var OtherUsersPostedStageTitleLabel: UILabel!
   
   @IBOutlet weak var OtherUsersPostedStageRatedLabel: UILabel!
   @IBOutlet weak var OtherUsersPostedStagePlayCountLabel: UILabel!
   @IBOutlet weak var OtherUsersPostedStageDateLabel: UILabel!
   
   
   @IBOutlet weak var OtherUsersPostReportButton: UIButton!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      
      SetUpUsersStageTitlelLabel()
      OtherUsersPostedStageImageView.contentMode = .scaleAspectFill
   }

   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
   
   private func SetUpUsersStageTitlelLabel() {
      OtherUsersPostedStageTitleLabel.adjustsFontSizeToFitWidth = true
      OtherUsersPostedStageTitleLabel.minimumScaleFactor = 0.4
   }

}
