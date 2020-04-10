//
//  OtherUsersProfileTableViewHeaderView.swift
//  PazleBox
//
//  Created by jun on 2020/02/27.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class OtherUsersProfileTableViewHeaderView: UIView {
   
   //FollowするためかUnFollowするためかBlockしている状態かを表すボタン
   @IBOutlet weak var FollowOrFollowingOrBlockedButton: UIButton!
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
      InitFollowOrFollowingOrBlockedButton()
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
   
   
   func InitFollowOrFollowingOrBlockedButton() {
      self.FollowOrFollowingOrBlockedButton.titleLabel?.adjustsFontSizeToFitWidth = true
      self.FollowOrFollowingOrBlockedButton.titleLabel?.adjustsFontForContentSizeCategory = true
      self.FollowOrFollowingOrBlockedButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 18)
      self.FollowOrFollowingOrBlockedButton.layer.cornerRadius =  ButtonCornerRadius
      //self.FollowOrFollowingOrBlockedButton.isEnabled = false
      //self.FollowOrFollowingOrBlockedButton.isHidden = true
   }
   
   public func SetUpFollowOrFollowingOrBlockedButtonAsFollowButton() {
      let Follow = NSLocalizedString("Follow", comment: "")
      self.FollowOrFollowingOrBlockedButton.setTitle(Follow, for: .normal)
      self.FollowOrFollowingOrBlockedButton.setTitleColor(UIColor.white, for: .normal)
      self.FollowOrFollowingOrBlockedButton.backgroundColor = .systemTeal
      self.FollowOrFollowingOrBlockedButton.layer.borderColor = .none
      self.FollowOrFollowingOrBlockedButton.layer.borderWidth = 0
      self.FollowOrFollowingOrBlockedButton.isEnabled = true
      self.FollowOrFollowingOrBlockedButton.isHidden = false
   }
   
   public func SetUpFollowOrFollowingOrBlockedButtonAsUnFollowButton() {
      let Following = NSLocalizedString("Following", comment: "")
      self.FollowOrFollowingOrBlockedButton.setTitle(Following, for: .normal)
      self.FollowOrFollowingOrBlockedButton.setTitleColor(UIColor.black, for: .normal)
      self.FollowOrFollowingOrBlockedButton.backgroundColor = .white
      self.FollowOrFollowingOrBlockedButton.layer.borderColor = UIColor.black.cgColor
      self.FollowOrFollowingOrBlockedButton.layer.borderWidth = 1.0
      self.FollowOrFollowingOrBlockedButton.isEnabled = true
      self.FollowOrFollowingOrBlockedButton.isHidden = false
   }
   
   public func SetUpFollowOrFollowingOrBlockedButtonAsBlockedButton() {
      let Block = NSLocalizedString("Block", comment: "")
      self.FollowOrFollowingOrBlockedButton.setTitle(Block, for: .normal)
      self.FollowOrFollowingOrBlockedButton.setTitleColor(UIColor.white, for: .normal)
      self.FollowOrFollowingOrBlockedButton.backgroundColor = .systemRed
      self.FollowOrFollowingOrBlockedButton.layer.borderColor = .none
      self.FollowOrFollowingOrBlockedButton.layer.borderWidth = 0
      self.FollowOrFollowingOrBlockedButton.isEnabled = true
      self.FollowOrFollowingOrBlockedButton.isHidden = false
   }
   
   public func SetUpFollowOrFollowingOrBlockedButtonAsCantWorkButtonBecauseUserBlockedUserThatShowOtherUsersVC() {
      self.FollowOrFollowingOrBlockedButton.setTitle("", for: .normal)
      self.FollowOrFollowingOrBlockedButton.setTitleColor(.none, for: .normal)
      self.FollowOrFollowingOrBlockedButton.backgroundColor = .none
      self.FollowOrFollowingOrBlockedButton.layer.borderColor = .none
      self.FollowOrFollowingOrBlockedButton.layer.borderWidth = 0
      self.FollowOrFollowingOrBlockedButton.isEnabled = false
      self.FollowOrFollowingOrBlockedButton.isHidden = true
   }
   
   public func getFollowOrUnFollowButton() -> UIButton {
      return self.FollowOrFollowingOrBlockedButton
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
