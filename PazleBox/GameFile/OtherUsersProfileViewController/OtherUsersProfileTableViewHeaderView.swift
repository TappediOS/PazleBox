//
//  OtherUsersProfileTableViewHeaderView.swift
//  PazleBox
//
//  Created by jun on 2020/02/27.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class OtherUsersProfileTableViewHeaderView: UIView {
   
   
   @IBOutlet weak var FollowOrUnFollowButton: UIButton!
   let ButtonCornerRadius: CGFloat = 6.5
   
   @IBOutlet weak var OtherUsersNameLabel: UILabel!
   @IBOutlet weak var OtherUsersProfileImageView: UIImageView!
   
   
   @IBOutlet weak var OtherUsersPostLabel: UILabel!
   @IBOutlet weak var OtherUsersFollowingLabel: UILabel!

   @IBOutlet weak var OtherUsersPlayCountLabel: UILabel!
   
   @IBOutlet weak var OtherUsersFollowersLabel: UILabel!
   @IBOutlet weak var OtherUsersPostsCountLabel: UILabel!
   @IBOutlet weak var OtherUsersFollowingCountLabel: UILabel!
   
   @IBOutlet weak var OtherUsersFollowersCountLabel: UILabel!
   
   @IBOutlet weak var OtherUsersPlayCountNumLabel: UILabel!
   
   override init(frame: CGRect){
      super.init(frame: frame)
      loadNib()
      InitFollowOrUnFollowButton()
      SetUpOtherUsersNameLabel()
      
      InitAllLabelsIsUserInteractionEnabled()
   }
      
   required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      loadNib()
   }
      
   func loadNib(){
      let view = Bundle.main.loadNibNamed("OtherUesrsProfileTableViewHeaderView", owner: self, options: nil)?.first as! UIView
      view.frame = self.bounds
      self.addSubview(view)
   }
   
   
   func InitFollowOrUnFollowButton() {
      self.FollowOrUnFollowButton.titleLabel?.adjustsFontSizeToFitWidth = true
      self.FollowOrUnFollowButton.titleLabel?.adjustsFontForContentSizeCategory = true
      self.FollowOrUnFollowButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 18)
      self.FollowOrUnFollowButton.layer.cornerRadius =  ButtonCornerRadius
      SetUpFollowOrUnFollowButtonAsFollowButton()
   }
   
   public func SetUpFollowOrUnFollowButtonAsFollowButton() {
      self.FollowOrUnFollowButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
      self.FollowOrUnFollowButton.backgroundColor = .systemTeal
      self.FollowOrUnFollowButton.layer.borderColor = .none
      self.FollowOrUnFollowButton.layer.borderWidth = 0
   }
   
   public func SetUpFollowOrUnFollowButtonAsUnFollowButton() {
      self.FollowOrUnFollowButton.setTitle("Following", for: .normal)
      self.FollowOrUnFollowButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
      self.FollowOrUnFollowButton.backgroundColor = .white
      self.FollowOrUnFollowButton.layer.borderColor = UIColor.black.cgColor
      self.FollowOrUnFollowButton.layer.borderWidth = 1.0
   }
   
   public func getFollowOrUnFollowButton() -> UIButton {
      return self.FollowOrUnFollowButton
   }
   
   func SetUpOtherUsersNameLabel() {
      self.OtherUsersNameLabel.adjustsFontSizeToFitWidth = true
      self.OtherUsersNameLabel.minimumScaleFactor = 0.4
   }
   
   
   @IBAction func TapFollowOrUnFollowButton(_ sender: Any) {
   }
   
   func InitAllLabelsIsUserInteractionEnabled() {
      OtherUsersNameLabel.isUserInteractionEnabled = false
      OtherUsersPostLabel.isUserInteractionEnabled = false
      OtherUsersPostsCountLabel.isUserInteractionEnabled = false
      
      //この4個はタップできるようにする
      OtherUsersFollowersLabel.isUserInteractionEnabled = true
      OtherUsersFollowingLabel.isUserInteractionEnabled = true
      OtherUsersFollowingCountLabel.isUserInteractionEnabled = true
      OtherUsersFollowersCountLabel.isUserInteractionEnabled = true
      
      OtherUsersPlayCountLabel.isUserInteractionEnabled = false
      OtherUsersPlayCountNumLabel.isUserInteractionEnabled = false
   }
}
