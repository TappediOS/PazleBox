//
//  ExSettingOther.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import StoreKit

extension SettingTableViewController {
   func TapOther(rowNum: Int) {
      switch rowNum {
      case 0:
         TapAppReview()
      case 1:
         TapContactUs()
      case 2:
         TapCredit()
      default:
         print("ここはありえないよね。")
         return
      }
   }
   
   private func TapAppReview() {
      Analytics.logEvent("TapAppReview", parameters: nil)
      if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
      }
      //NOTE:　この下のは,実際にAppSt oreに飛ばす時に使う。
//      else {
//          if let url = URL(string: "itms-apps://itunes.apple.com/app/id1274048262?action=write-review") {
//              if #available(iOS 10.0, *) {
//                  UIApplication.shared.open(url, options: [:])
//              } else {
//                  UIApplication.shared.openURL(url)
//              }
//          }
//      }
   }
   
   private func TapContactUs() {
      let url = URL(string: "https://forms.gle/mSEq7WwDz3fZNcqF6")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenContactUsURLSetting", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenURSettingL", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("CantOpenURLWithNilSetting", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }
   
   private func TapCredit() {
      Analytics.logEvent("TapCredit", parameters: nil)
      if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
   }
   
}
