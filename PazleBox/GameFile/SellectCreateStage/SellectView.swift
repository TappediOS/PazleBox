//
//  SellectView.swift
//  PazleBox
//
//  Created by jun on 2019/11/16.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import ChameleonFramework
import TapticEngine
import Firebase

class SellectView: UIView {
   
   @IBOutlet weak var SellectImageView: UIImageView!
   @IBOutlet weak var PlayButton: FUIButton!
   @IBOutlet weak var DeleteButton: FUIButton!
   
   init(frame: CGRect, Image: UIImage) {
      super.init(frame: frame)
   
      InitView()
      InitPlayButton()
      InitDeleteButton()
      InitImageView(Image: Image)
   }
   
   private func InitView() {
      self.layer.cornerRadius = 10
      
   }
   
   private func InitPlayButton() {
      PlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PlayButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PlayButton.buttonColor = UIColor.flatLime()
      PlayButton.shadowColor = UIColor.flatLimeColorDark()
      PlayButton.shadowHeight = 3.0
      PlayButton.cornerRadius = 6.0
      PlayButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
   
   private func InitDeleteButton() {
      DeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
      DeleteButton.titleLabel?.adjustsFontForContentSizeCategory = true
      DeleteButton.buttonColor = UIColor.flatRed()
      DeleteButton.shadowColor = UIColor.flatRedColorDark()
      DeleteButton.shadowHeight = 3.0
      DeleteButton.cornerRadius = 6.0
      DeleteButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
   
   private func InitImageView(Image: UIImage) {
      self.SellectImageView.image = Image
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
