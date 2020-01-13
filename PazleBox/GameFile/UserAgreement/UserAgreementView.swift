//
//  UserAgreementView.swift
//  PazleBox
//
//  Created by jun on 2020/01/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import Firebase
import FirebaseFirestore
import TapticEngine

@IBDesignable
class UserAgreementView: UIView {

   init(frame: CGRect, Image: UIImage, CellNum: Int, PlayCount: Int, ReviewAve: CGFloat, addDate: String, addUserUID: String) {
      super.init(frame: frame)
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
      
      
      LoadNib()
      InitView()

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
      self.layer.borderColor = UIColor.black.cgColor
      self.layer.borderWidth = 0.45
      self.layer.shadowOffset = CGSize(width: 14.5, height: 14.5)
      self.layer.shadowColor = UIColor.black.cgColor
      //1にすれば真っ黒，0にすれば透明に
      self.layer.shadowOpacity = 0.65
      self.layer.cornerRadius = 5.8
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
