//
//  ExSettingUserInfo.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

extension SettingTableViewController {
   func TapUserInfo() {
      guard let user = Auth.auth().currentUser else {
         print("ユーザがいない")
         return
      }
      
      if user.isAnonymous {
         showFirebaseLoginVC()
         return
      }
   
   }
   
   func showFirebaseLoginVC() {
      let Storybord = UIStoryboard(name: "FirebaseLoginSB", bundle: nil)
      let LoginVC = Storybord.instantiateViewController(withIdentifier: "FirebaseLoginVC")
      present(LoginVC, animated: true, completion: {
         print("Login画面にプレゼント完了")
      })
   }
}
