//
//  ExSettingOther.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

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
      
   }
   
   private func TapCredit() {
      
   }
   
}
