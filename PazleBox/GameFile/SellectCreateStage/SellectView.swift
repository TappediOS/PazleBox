//
//  SellectView.swift
//  PazleBox
//
//  Created by jun on 2019/11/16.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import Firebase
import TapticEngine

@IBDesignable
class SellectView: UIView {
   
   
   @IBOutlet weak var SellectImageView: UIImageView!
   @IBOutlet weak var PlayButton: UIButton!
   @IBOutlet weak var DeleteButton: UIButton!
   

   init(frame: CGRect, Image: UIImage) {
      super.init(frame: frame)
        
      LoadNib()
      InitView()
      InitPlayButton()
      InitDeleteButton()
      InitImageView(Image: Image)
   }
     
     
   private func InitView() {
      self.layer.cornerRadius = 20
      self.layer.masksToBounds = true
   }
     
   private func InitPlayButton() {
      PlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PlayButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PlayButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      PlayButton.layer.cornerRadius = 5
      PlayButton.clipsToBounds = true
   }
     
   private func InitDeleteButton() {
      DeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
      DeleteButton.titleLabel?.adjustsFontForContentSizeCategory = true
      DeleteButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      DeleteButton.layer.cornerRadius = 5
      DeleteButton.clipsToBounds = true
   }
     
   private func InitImageView(Image: UIImage) {
      self.SellectImageView.image = Image
      SellectImageView.layer.cornerRadius = SellectImageView.frame.size.width * 0.1
      SellectImageView.clipsToBounds = true
   }
     
     
   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "SellectView", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      addSubview(view)
   }
     
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      LoadNib()
   }

   
   
   // viewの枠線の色
   @IBInspectable var borderColor: UIColor = UIColor.clear {
       didSet {
         self.layer.borderColor = borderColor.cgColor
       }
   }

   // viewの枠線の太さ
   @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
           self.layer.borderWidth = borderWidth
       }
   }
   
   // viewの角丸
   @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           self.layer.cornerRadius = cornerRadius
           self.layer.masksToBounds = true
       }
   }
   

}
