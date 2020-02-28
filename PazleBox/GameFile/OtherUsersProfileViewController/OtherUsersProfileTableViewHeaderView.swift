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
   
   
   override init(frame: CGRect){
      super.init(frame: frame)
      loadNib()
      InitFollowOrUnFollowButton()
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
   
   
   @IBAction func TapFollowOrUnFollowButton(_ sender: Any) {
      print("Followボタンタップされた")
   }
   
}
