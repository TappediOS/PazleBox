//
//  WorldTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/03/01.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class WorldTableViewCell: UITableViewCell {
   
   
   @IBOutlet weak var UsersImageViewButton: UIButton!
   @IBOutlet weak var UserNameLabel: UILabel!
   @IBOutlet weak var UsersGameImageView: UIImageView!
   
   @IBOutlet weak var UsersStageTitlelLabel: UILabel!
   
   @IBOutlet weak var UsersStageReviewLabel: UILabel!
   @IBOutlet weak var UsersStagePlayCountLabel: UILabel!
   @IBOutlet weak var UsersStagePostedDateLabel: UILabel!
   
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      
      SetUpUsersStageTitlelLabel()
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   func SetUpUsersStageTitlelLabel() {
      UsersStageTitlelLabel.adjustsFontSizeToFitWidth = true
      UsersStageTitlelLabel.minimumScaleFactor = 0.4
   }

}
