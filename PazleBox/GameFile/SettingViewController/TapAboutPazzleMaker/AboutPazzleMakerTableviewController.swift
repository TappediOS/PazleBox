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

class AboutPazzleMakerTableviewController: UITableViewController {
   
   let numOfSection = 1
   let firstNumberOfRowsInSection = 3

   let GameSound = GameSounds()

   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationController()
      SetUpLabelText()
   }
      
   private func SetUpNavigationController() {
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("About Puzzle Maker", comment: "")
   }
   
   private func SetUpLabelText() {
      //UserInfoLabel.text = NSLocalizedString("UserInfo", comment: "")
      
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
      
   }
   
   private func TapTermsOfService() {
      
   }
   
   private func TapLicense() {
      if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
   
}
