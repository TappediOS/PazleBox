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
import SCLAlertView


class UserAgreementView: UIView {
   
   
   @IBOutlet weak var AgreementLabel: UILabel!
   @IBOutlet weak var AgreementDescriptionLabel: UILabel!
   @IBOutlet weak var AgreementButton: UIButton!
   @IBOutlet weak var PlivacyPolicyButton: UIButton!
   @IBOutlet weak var DontAgreebutton: UIButton!
   @IBOutlet weak var AgreeButton: UIButton!
   
   
   
   
   let ButtonCornerRadius: CGFloat = 8
   

   override init(frame: CGRect) {
      super.init(frame: frame)
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
      
      
      LoadNib()
      InitView()
      InitAgreementLabel()
      InitAgreementDescriptionLabel()
      InitAgreementButton()
      InitPlivacyPolicyButton()
      InitDontAgreebutton()
      InitAgreeButton()
      SetUpEachButtonCornerRadiusAndAjustsFont()

   }
   
   override func awakeFromNib() {
      
   }
   

   private func LoadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "UserAgreementView", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      view.frame = self.bounds
      addSubview(view)
   }
   
   private func InitView() {
      self.layer.borderColor = UIColor.black.cgColor
      self.layer.borderWidth = 0.8
      self.layer.shadowOffset = CGSize(width: 16, height: 16)
      self.layer.shadowColor = UIColor.black.cgColor
      //1にすれば真っ黒，0にすれば透明に
      self.layer.shadowOpacity = 0.5
      self.layer.cornerRadius = 13
   }
   
   private func InitAgreementLabel() {
      let title = NSLocalizedString("UserAgreement", comment: "")
      AgreementLabel.text = title
      AgreementLabel.adjustsFontSizeToFitWidth = true
      AgreementLabel.adjustsFontForContentSizeCategory = true
   }
   
   private func InitAgreementDescriptionLabel() {
      let title = NSLocalizedString("AgreementInfo", comment: "")
      AgreementDescriptionLabel.text = title
      AgreementDescriptionLabel.adjustsFontSizeToFitWidth = true
      AgreementDescriptionLabel.adjustsFontForContentSizeCategory = true
   }
   
   private func InitPlivacyPolicyButton() {
      let title = NSLocalizedString("PrivacyPolicy", comment: "")
      PlivacyPolicyButton.setTitle(title, for: .normal)
   }
   
   private func InitAgreementButton() {
      let title = NSLocalizedString("UserAgreement", comment: "")
      AgreementButton.setTitle(title, for: .normal)
   }
   
   
    
   private func InitDontAgreebutton() {
      let title = NSLocalizedString("DontAccept", comment: "")
      DontAgreebutton.setTitle(title, for: .normal)
   }
   
   private func InitAgreeButton() {
      let title = NSLocalizedString("Accept", comment: "")
      AgreeButton.setTitle(title, for: .normal)
   }
   
   
   private func SetUpEachButtonCornerRadiusAndAjustsFont() {
      SetUpButtonCornerRadiusAndAjustsFont(AgreementButton)
      SetUpButtonCornerRadiusAndAjustsFont(PlivacyPolicyButton)
      SetUpButtonCornerRadiusAndAjustsFont(DontAgreebutton)
      SetUpButtonCornerRadiusAndAjustsFont(AgreeButton)
   }
   
   private func SetUpButtonCornerRadiusAndAjustsFont(_ button: UIButton) {
      button.titleLabel?.adjustsFontSizeToFitWidth = true
      button.titleLabel?.adjustsFontForContentSizeCategory = true
      button.layer.cornerRadius =  ButtonCornerRadius
   }
   
   @IBAction func TapAgreementButton(_ sender: Any) {
      let url = URL(string: "https://github.com/TappediOS/PazleBox/blob/sub/User%20Agreement")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenAgreement", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenAgreement", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("CantOpenAgreement", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }
   
   
   @IBAction func TapPlivacyPolicyButton(_ sender: Any) {
      let url = URL(string: "https://github.com/TappediOS/PazleBox/blob/sub/Privacy%20Policy")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenPlivacyPolicy", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenPlivacyPolicy", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("CantOpenPlivacyPolicy", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }

   
   @IBAction func TapDontAgreeButton(_ sender: Any) {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: true)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.showInfo(NSLocalizedString("UserAgreement", comment: ""), subTitle: NSLocalizedString("YouCantContinue", comment: ""))
   }
   
   @IBAction func TapAgreeButton(_ sender: Any) {
      UserDefaults.standard.set(true, forKey: "AcceptAgreement")
      self.removeFromSuperview()
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
