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
   
   var CellNum: Int = 0
   
   @IBOutlet weak var SellectImageView: UIImageView!
   @IBOutlet weak var PlayButton: UIButton!
   @IBOutlet weak var DeleteButton: UIButton!
   @IBOutlet weak var CloseButton: UIButton!
   
   let ButtonShadow = CGSize(width: 0.3, height: 1.75)
   let ButtonShadowColor = UIColor.black.cgColor
   let ButtonShadowOpacity: Float = 0.6
   let ButtonCornerRadius: CGFloat = 7
   
   var isLockedPlayAndCloseButton = false

   init(frame: CGRect, Image: UIImage, CellNum: Int) {
      super.init(frame: frame)
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
      
      self.CellNum = CellNum
        
      LoadNib()
      InitView()
      InitPlayButton()
      InitDeleteButton()
      InitCloseButton()
      InitAccessibilityIdentifier()
      InitImageView(Image: Image)
   }
     
   override func awakeFromNib() {
      
   }
     
   private func InitView() {
      self.layer.borderColor = UIColor.black.cgColor
      self.layer.borderWidth = 0.8
      self.layer.shadowOffset = CGSize(width: 14.5, height: 14.5)
      self.layer.shadowColor = UIColor.black.cgColor
      //1にすれば真っ黒，0にすれば透明に
      self.layer.shadowOpacity = 0.65
      self.layer.cornerRadius = 10
   }
     
   private func InitPlayButton() {
      let title = NSLocalizedString("Play", comment: "")
      PlayButton.setTitle(title, for: .normal)
      PlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PlayButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PlayButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PlayButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      PlayButton.layer.cornerRadius = ButtonCornerRadius
      
   }
     
   private func InitDeleteButton() {
      let title = NSLocalizedString("Delete", comment: "")
      DeleteButton.setTitle(title, for: .normal)
      DeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
      DeleteButton.titleLabel?.adjustsFontForContentSizeCategory = true
      DeleteButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      DeleteButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      DeleteButton.layer.cornerRadius = ButtonCornerRadius
   }
   
   private func InitCloseButton() {
      let title = NSLocalizedString("Close", comment: "")
      CloseButton.setTitle(title, for: .normal)
      CloseButton.titleLabel?.adjustsFontSizeToFitWidth = true
      CloseButton.titleLabel?.adjustsFontForContentSizeCategory = true
      CloseButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      CloseButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      CloseButton.layer.cornerRadius = ButtonCornerRadius
   }
     
   private func InitImageView(Image: UIImage) {
      self.SellectImageView.image = Image
      SellectImageView.layer.shadowOffset = ButtonShadow
      SellectImageView.layer.shadowColor = ButtonShadowColor
      SellectImageView.layer.shadowOpacity = ButtonShadowOpacity
      SellectImageView.layer.cornerRadius = ButtonCornerRadius
   }
     
   
   private func InitAccessibilityIdentifier() {
      PlayButton.accessibilityIdentifier = "PlayButton"
      DeleteButton.accessibilityIdentifier = "DeleteButton"
      CloseButton.accessibilityIdentifier = "CloseButton"
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
      print("Tap PlayButton")
      
      guard isLockedPlayAndCloseButton == false else {
         Play3DtouchLight()
         print("プレイボタンはロックされています。")
         return
      }
      
      isLockedPlayAndCloseButton = true
      
      Analytics.logEvent("TapPlayCreate", parameters: nil)
      
      let SentObject: [String : Int] = ["CellNum": CellNum]
      NotificationCenter.default.post(name: .TapPlayButton, object: nil, userInfo: SentObject)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
         self.removeFromSuperview()
      }
   }
   
   
   @IBAction func TapDeleteButton(_ sender: Any) {
      guard isLockedPlayAndCloseButton == false else {
         Play3DtouchLight()
         print("各ボタンはロックされています。")
         return
      }
      
      Analytics.logEvent("TapDeleteCreate", parameters: nil)
      print("Tap DeleteButton")
      let SentObject: [String : Int] = ["CellNum": CellNum]
      Play3DtouchHeavy()
      NotificationCenter.default.post(name: .TapDeleteButton, object: nil, userInfo: SentObject)
      self.removeFromSuperview()
   }
   
   @IBAction func TapCloseButton(_ sender: Any) {
      guard isLockedPlayAndCloseButton == false else {
         Play3DtouchLight()
         print("各ボタンはロックされています。")
         return
      }
      
      Analytics.logEvent("TapCloseCreate", parameters: nil)
      print("Tap CloseButton")
      self.removeFromSuperview()
      Play3DtouchLight()
      NotificationCenter.default.post(name: .TapCloseButton, object: nil)
     
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
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}
