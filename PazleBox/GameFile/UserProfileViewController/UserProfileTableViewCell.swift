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
}
