//
//  TutorialBalloon.swift
//  PazleBox
//
//  Created by jun on 2020/01/17.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import Firebase
import FirebaseFirestore
import TapticEngine
import SCLAlertView
import Hero

class TutorialBalloon: UIView {
   
   @IBOutlet weak var CommentLabel: UILabel!
      
   override init(frame: CGRect) {
      super.init(frame: frame)
      if #available(iOS 13.0, *) { self.overrideUserInterfaceStyle = .light }
      
      LoadNib()
      InitView()
      InitCommentLabel()
   }

   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "TutorialBalloon", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      view.frame = self.bounds
      addSubview(view)
   }
   
   private func InitView() {
      self.layer.borderColor = UIColor.black.cgColor
      self.layer.borderWidth = 1
      self.layer.shadowOffset = CGSize(width: 15, height: 15)
      self.layer.shadowColor = UIColor.black.cgColor
      //1にすれば真っ黒，0にすれば透明に
      self.layer.shadowOpacity = 0.45
      self.layer.cornerRadius = 20
      
      self.hero.isEnabled = true
   }
   

   private func InitCommentLabel() {
      CommentLabel.adjustsFontSizeToFitWidth = true
      CommentLabel.adjustsFontForContentSizeCategory = true
      CommentLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
      CommentLabel.text = "I heard that the weather is fine today, but the chance of rain tomorrow is very high. What will happen?\nI dont know..."
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
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
      
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      LoadNib()
   }
   
   override func awakeFromNib() {
        
     }
}
