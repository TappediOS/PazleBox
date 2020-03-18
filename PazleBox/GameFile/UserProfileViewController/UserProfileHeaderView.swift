//
//  UserProfileHeaderView.swift
//  PazleBox
//
//  Created by jun on 2020/02/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserProfileHeaderView: UIView {
   
   
   @IBOutlet weak var UsersProfileImage: UIImageView!
   @IBOutlet weak var UsersNameLabel: UILabel!
   
   
   
   @IBOutlet weak var UsersPostsLabel: UILabel!
   @IBOutlet weak var UsersFollowingLabel: UILabel!
   @IBOutlet weak var UsersFollowersLabel: UILabel!
   @IBOutlet weak var UsersPlayCountLabel: UILabel!
   
   
   @IBOutlet weak var UsersPostCountLabel: UILabel!
   @IBOutlet weak var UsersFollowingCountLabel: UILabel!
   @IBOutlet weak var UsersFollowersCountLabel: UILabel!
   @IBOutlet weak var UsersPlayCountNumLabel: UILabel!
   
   
   
   override init(frame: CGRect){
      super.init(frame: frame)
      loadNib()
      SetUpUsersNameLabel()
      SetUpUsersProfileImage()
      
      InitAllLabelsIsUserInteractionEnabled()
   }
   
   required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      loadNib()
   }
   
   func loadNib(){
      let view = Bundle.main.loadNibNamed("UserProfileHeaderView", owner: self, options: nil)?.first as! UIView
      view.frame = self.bounds
      self.addSubview(view)
   }
   
   func SetUpUsersNameLabel() {
      self.UsersNameLabel.adjustsFontSizeToFitWidth = true
      self.UsersNameLabel.minimumScaleFactor = 0.4
   }
   
   func SetUpUsersProfileImage() {
      UsersProfileImage.layer.borderWidth = 0.5
      UsersProfileImage.layer.cornerRadius = self.UsersProfileImage.frame.width / 2
      UsersProfileImage.layer.masksToBounds = true
   }
   
   func InitAllLabelsIsUserInteractionEnabled() {
      UsersNameLabel.isUserInteractionEnabled = false
      UsersPostsLabel.isUserInteractionEnabled = false
      UsersPostCountLabel.isUserInteractionEnabled = false
      
      //この4個はタップできるようにする
      UsersFollowingLabel.isUserInteractionEnabled = true
      UsersFollowingCountLabel.isUserInteractionEnabled = true
      UsersFollowersLabel.isUserInteractionEnabled = true
      UsersFollowersCountLabel.isUserInteractionEnabled = true
      
      UsersPlayCountLabel.isUserInteractionEnabled = false
      UsersPlayCountNumLabel.isUserInteractionEnabled = false
   }
}
