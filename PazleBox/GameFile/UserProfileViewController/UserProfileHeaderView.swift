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
   
   
   override init(frame: CGRect){
      super.init(frame: frame)
      loadNib()
      SetUpUsersNameLabel()
      SetUpUsersProfileImage()
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
}
