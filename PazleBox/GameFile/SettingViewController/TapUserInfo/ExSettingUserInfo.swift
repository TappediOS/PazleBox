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
import GameKit
import UIKit

extension SettingTableViewController {
   
   func TapUserInfo(rowNum: Int) {
      switch rowNum {
      case 0:
         showUserSettingNavigationController()
      case 1:
         showGameCenterViewController()
      default:
         print("ここはこない")
         return
      }
   }
   
   func showUserSettingNavigationController() {
      let Storybord = UIStoryboard(name: "UsersSetting", bundle: nil)
      let UserSettingNaviVC = Storybord.instantiateViewController(withIdentifier: "UsersSettingVC")
      UserSettingNaviVC.modalPresentationStyle = .fullScreen
      
      self.navigationController?.pushViewController(UserSettingNaviVC, animated: true)
      Analytics.logEvent("OpenUserSettingNC", parameters: nil)

   }
   
   func showGameCenterViewController() {
      Analytics.logEvent("ShowGameCenter", parameters: nil)
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self as GKGameCenterControllerDelegate
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      gcView.modalPresentationStyle = .fullScreen
      self.present(gcView, animated: true, completion: nil)
   }
   
   //MARK:- GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: {
         print("GameCenterVC閉じたよ")
      })
   }
}
