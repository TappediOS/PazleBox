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
   @IBOutlet weak var CloseButton: UIButton!
   
   let ButtonShadow = CGSize(width: 0.1, height: 0.2)
   let ButtonShadowColor = UIColor.black.cgColor
   let ButtonShadowOpacity: Float = 0.6
   let ButtonCornerRadius: CGFloat = 7

   init(frame: CGRect, Image: UIImage) {
      super.init(frame: frame)
        
      LoadNib()
      InitView()
      InitPlayButton()
      InitDeleteButton()
      InitCloseButton()
      InitImageView(Image: Image)
   }
     
   override func awakeFromNib() {
      
   }
     
   private func InitView() {
      self.layer.shadowOffset = CGSize(width: 10, height: 10)
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 0.74
      self.layer.cornerRadius = 8
   }
     
   private func InitPlayButton() {
      PlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PlayButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PlayButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      PlayButton.layer.shadowOffset = ButtonShadow
      PlayButton.layer.shadowColor = ButtonShadowColor
      PlayButton.layer.shadowOpacity = ButtonShadowOpacity
      PlayButton.layer.cornerRadius = ButtonCornerRadius
      PlayButton.clipsToBounds = true
      
   }
     
   private func InitDeleteButton() {
      DeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
      DeleteButton.titleLabel?.adjustsFontForContentSizeCategory = true
      DeleteButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      PlayButton.layer.shadowOffset = ButtonShadow
      PlayButton.layer.shadowColor = ButtonShadowColor
      PlayButton.layer.shadowOpacity = ButtonShadowOpacity
      PlayButton.layer.cornerRadius = ButtonCornerRadius
      DeleteButton.clipsToBounds = true
   }
   
   private func InitCloseButton() {
      CloseButton.titleLabel?.adjustsFontSizeToFitWidth = true
      CloseButton.titleLabel?.adjustsFontForContentSizeCategory = true
      CloseButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      CloseButton.layer.shadowOffset = ButtonShadow
      CloseButton.layer.shadowColor = ButtonShadowColor
      CloseButton.layer.shadowOpacity = ButtonShadowOpacity
      CloseButton.layer.cornerRadius = ButtonCornerRadius
      CloseButton.clipsToBounds = true
   }
     
   private func InitImageView(Image: UIImage) {
      self.SellectImageView.image = Image
      SellectImageView.layer.shadowOffset = ButtonShadow
      SellectImageView.layer.shadowColor = ButtonShadowColor
      SellectImageView.layer.shadowOpacity = ButtonShadowOpacity
      SellectImageView.layer.cornerRadius = ButtonCornerRadius
      SellectImageView.clipsToBounds = true
   }
     
     
   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "SellectView", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      view.frame = self.bounds
      addSubview(view)
   }
     
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      LoadNib()
   }

   
   @IBAction func TapPlayButton(_ sender: Any) {
   }
   
   
   
   
   @IBAction func TapDeleteButton(_ sender: Any) {
   }
   
   @IBAction func TapCloseButton(_ sender: Any) {
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
