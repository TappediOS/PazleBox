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
      
   }
   
   private func TapContactUs() {
      let url = URL(string: "https://forms.gle/mSEq7WwDz3fZNcqF6")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("TopOpenContactUsURLSetting", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("TopCantOpenURSettingL", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("TopCantOpenURLWithNilSetting", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }
   
   private func TapCredit() {
      
   }
   
}
