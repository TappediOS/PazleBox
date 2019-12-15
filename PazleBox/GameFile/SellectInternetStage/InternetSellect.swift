//
//  InternetSellect.swift
//  PazleBox
//
//  Created by jun on 2019/12/14.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import Firebase
import TapticEngine

@IBDesignable
class InterNetSellect: UIView {

   var CellNum: Int = 0

   //Numがついてる方には，実際の数値を代入する。
   @IBOutlet weak var DateLabel: UILabel!
   @IBOutlet weak var StageImageView: UIImageView!
   @IBOutlet weak var RatedLabel: UILabel!
   @IBOutlet weak var RatedNumLabel: UILabel!
   @IBOutlet weak var PlayCountLabel: UILabel!
   @IBOutlet weak var PlayCountNumLabel: UILabel!
   @IBOutlet weak var PlayButton: UIButton!
   @IBOutlet weak var CloseButton: UIButton!
   
   
   let ButtonShadow = CGSize(width: 0.3, height: 1.75)
   let ButtonShadowColor = UIColor.black.cgColor
   let ButtonShadowOpacity: Float = 0.6
   let ButtonCornerRadius: CGFloat = 7
   
   var isLockedPlayButton = false
   
   init(frame: CGRect, Image: UIImage, CellNum: Int, PlayCount: Int, ReviewAve: CGFloat, addDate: String) {
      super.init(frame: frame)
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
      
      self.CellNum = CellNum
      
      LoadNib()
      InitView()
      InitRatedNumLabel(ReviewAve)
      InitPlayCountNumLabel(PlayCount)
      InitDateLabel(addDate)
      InitPlayButton()
      InitCloseButton()
      InitImageView(Image: Image)
   }
   
   override func awakeFromNib() {
      
   }
   
   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "InterNetSellect", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      view.frame = self.bounds
      addSubview(view)
   }
   
   private func InitView() {
      self.layer.shadowOffset = CGSize(width: 10, height: 10)
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOpacity = 0.7
      self.layer.cornerRadius = 12
   }
   
   private func InitRatedNumLabel(_ RatedNum: CGFloat) {
      let point2 = floor(Double(RatedNum) * 100) / 100
      self.RatedNumLabel.text = String(point2) + " / 5"
   }
   
   private func InitPlayCountNumLabel(_ PlayCount: Int) {
      self.PlayCountNumLabel.text = String(PlayCount)
   }
   
   private func InitDateLabel(_ addDate: String) {
      self.DateLabel.text = addDate + "にさくせいされました"
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
      //PlayButton.clipsToBounds = true
      
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
   }
     
   private func InitImageView(Image: UIImage) {
      StageImageView.image = Image
      StageImageView.layer.shadowOffset = ButtonShadow
      StageImageView.layer.shadowColor = ButtonShadowColor
      StageImageView.layer.shadowOpacity = ButtonShadowOpacity
      StageImageView.layer.cornerRadius = ButtonCornerRadius
   }
   
  
   @IBAction func TapPlayButton(_ sender: Any) {
      print("Tap Internet PlayButton")
      
      guard isLockedPlayButton == false else {
         Play3DtouchLight()
         print("プレイボタンはロックされています。")
         return
      }
      
      isLockedPlayButton = true
      
      let SentObject: [String : Int] = ["CellNum": CellNum]
      NotificationCenter.default.post(name: .TapPlayButton, object: nil, userInfo: SentObject)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.27) {
         self.removeFromSuperview()
      }
   }
   
   @IBAction func TapCloseButton(_ sender: Any) {
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
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      LoadNib()
   }
}
