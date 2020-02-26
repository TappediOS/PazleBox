//
//  UserProfileTapCellViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/26.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserProfileTapCellViewController: UIViewController {
   
   
   @IBOutlet weak var UsersProfileImageView: UIImageView!
   @IBOutlet weak var UsersNameLabel: UILabel!
   
   var UsersProfileImage = UIImage()
   var UsersName: String = ""
   
   @IBOutlet weak var UsersPostedStageImageView: UIImageView!
   @IBOutlet weak var UsersPostedStageTitleLabel: UILabel!
   
   var UsersPostedStageImage = UIImage()
   var UsersPostedStageTitle: String = ""
   
   @IBOutlet weak var UsersPostedStageReviewLabel: UILabel!
   @IBOutlet weak var UsersPostedStagePalyCountLabel: UILabel!
   
   var UsersPostedStageReview: String = "" // 2.23 / 5
   var UsersPostedStagePlayCount: String = "" // 245
   
   @IBOutlet weak var UsersPostedStagePlayButton: UIButton!
   @IBOutlet weak var UsersPostedStageDeleteButton: UIButton!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   @IBAction func TapUsersPostedStagePlayButton(_ sender: Any) {
   }
   
   
   @IBAction func TapUsersPostedStagePlayButton(_ sender: Any) {
   }
   
}
