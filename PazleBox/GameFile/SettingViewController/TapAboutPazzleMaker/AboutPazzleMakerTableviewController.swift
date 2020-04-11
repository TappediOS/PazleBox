//
//  AboutPazzleMakerTableviewController.swift
//  PazleBox
//
//  Created by jun on 2020/04/05.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import Firebase

class AboutPazzleMakerTableviewController: UITableViewController {
   
   let numOfSection = 1
   let firstNumberOfRowsInSection = 3

   let GameSound = GameSounds()
   
   @IBOutlet weak var PrivacyPolicyLabel: UILabel!
   @IBOutlet weak var UserAgreementLabel: UILabel!
   @IBOutlet weak var LicenseLabel: UILabel!
   

   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationController()
      SetUpLabelText()
   }
      
   private func SetUpNavigationController() {
      self.navigationItem.title = NSLocalizedString("AboutPuzzleMaker", comment: "")
   }
   
   private func SetUpLabelText() {
      PrivacyPolicyLabel.text = NSLocalizedString("PrivacyPolicy", comment: "")
      UserAgreementLabel.text = NSLocalizedString("UserAgreement", comment: "")
      LicenseLabel.text = NSLocalizedString("Credit", comment: "")
   }
      
   
   // MARK: - Table view data source
   // セクションの数を返します
   override func numberOfSections(in tableView: UITableView) -> Int {
      return numOfSection
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      switch section {
      case 0:
         return firstNumberOfRowsInSection
      default:
         return 0
      }
   }
      
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      print("section 番号: \(indexPath.section)")
      print("index   番号: \(indexPath.row)")
         
      switch indexPath.row {
      case 0:
         TapPrivacyPolicy()
      case 1:
         TapTermsOfService()
      case 2:
         TapLicense()
      default:
         print("ここにはこない")
         return
      }
   }
   
   private func TapPrivacyPolicy() {
      let url = URL(string: "https://raw.githubusercontent.com/TappediOS/PazleBox/sub/Privacy%20Policy")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenPrivacyPolicy", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenOpenPrivacyPolicy", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         print("URL 開こうとしたらNilやった")
      }
   }
   
   private func TapTermsOfService() {
      let url = URL(string: "https://raw.githubusercontent.com/TappediOS/PazleBox/sub/User%20Agreement")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenUserAgreement", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenUserAgreement", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("CantOpenURLWithNilSetting", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }
   
   
   private func TapLicense() {
      if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
         Analytics.logEvent("OpenLicense", parameters: nil)
      }
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
   
}
