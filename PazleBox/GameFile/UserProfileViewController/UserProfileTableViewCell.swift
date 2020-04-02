//
//  UserProfileTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/02/25.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    
   @IBOutlet weak var UsersPfofileImageView: UIImageView!
   @IBOutlet weak var UsersNameLabel: UILabel!
   
   
   @IBOutlet weak var UsersPostedStageImageView: UIImageView!
   @IBOutlet weak var UsersPostedStageTitleLabel: UILabel!
   
   
   @IBOutlet weak var UsersPostedStageReviewLabel: UILabel!
   @IBOutlet weak var UsersPostedStagePlayCountLabel: UILabel!
   @IBOutlet weak var UsersPostedStageAddDateLabel: UILabel!
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      SetUpUsersProfileImage()
      SetUpUsersStageTitlelLabel()
      UsersPostedStageImageView.contentMode = .scaleAspectFill
   }
   
   func SetUpUsersProfileImage() {
      UsersPfofileImageView.layer.cornerRadius = UsersPfofileImageView.frame.width / 2
      UsersPfofileImageView.layer.masksToBounds = true
   }
   
   private func SetUpUsersStageTitlelLabel() {
      UsersPostedStageTitleLabel.adjustsFontSizeToFitWidth = true
      UsersPostedStageTitleLabel.minimumScaleFactor = 0.4
   }
}
