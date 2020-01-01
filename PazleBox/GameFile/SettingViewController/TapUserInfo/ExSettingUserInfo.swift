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
      showFirebaseLoginVC()
   }
   
   func showFirebaseLoginVC() {
      let Storybord = UIStoryboard(name: "UsersSetting", bundle: nil)
      let LoginVC = Storybord.instantiateViewController(withIdentifier: "UsersSettingVC")
      LoginVC.modalPresentationStyle = .pageSheet
      present(LoginVC, animated: true, completion: {
         print("Login画面にプレゼント完了")
      })
   }
}
