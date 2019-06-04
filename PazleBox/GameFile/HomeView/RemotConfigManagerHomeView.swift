//
//  RemotConfigManagerHomeView.swift
//  PazleBox
//
//  Created by jun on 2019/05/30.
//  Copyright © 2019 jun. All rights reserved.
//

import Firebase
import UIKit

struct RemoteConfgName {
   
   let EasyStageButtonName = "EasyStageNameKey"
   let NormalStageButtonName = "NormalStageNameKey"
   let HardStageButtonName = "HardStageNameKey"
   
   let EasyStageButtonColor = "EasyButtonColorKey"
   let NormalStageButtonColor = "NormalButtonColorKey"
   let HardStageButtonColor = "HardButtonColorKey"
   
   let PurchasStageButtonColor = "PurchasButtonColorKey"
   let RestoreStageButtonColor = "RestoreButtonColorKey"
   let ShowRankStageButtonColor = "ShowRandButtonColorKey"
   let ContactUsButtonColor = "ContactUsButtonColorKey"
   
   let TitileLabelText = "TitileLabelTextKey"
}









//HomeViewで使ったろっておもたけどnilめんどくさいなー。
class RemoteConfigManagerHomeView {
   
   var RemorteConfigs: RemoteConfig!
   let RemoConName = RemoteConfgName()
   
   init() {
      InitConfig()
      SetUpRemoteConfigDefaults()
      FetchConfig()
   }
   
   //MARK:- Remote ConfigのInitするよ-
   //MARK: RemoteConfigのdefaultをセットする
   private func SetUpRemoteConfigDefaults() {
      let defaultsValues = [
         RemoConName.EasyStageButtonName : "Easy" as NSObject,
         RemoConName.NormalStageButtonName : "Normal" as NSObject,
         RemoConName.HardStageButtonName : "Hard" as NSObject
      ]
      
      self.RemorteConfigs.setDefaults(defaultsValues)
   }
   
   //MARK: InitConfigする
   private func InitConfig() {
      self.RemorteConfigs = RemoteConfig.remoteConfig()
      
      //MARK: デベロッパモード　出すときはやめろ
      #if DEBUG
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: true)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #else
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: false)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #endif
      
   }
   
   private func FetchConfig() {
      
      
      // ディベロッパーモードの時、expirationDurationを0にして随時更新できるようにする。
      let expirationDuration = RemorteConfigs.configSettings.isDeveloperModeEnabled ? 0 : 3600
      RemorteConfigs.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { [unowned self] (status, error) -> Void in
         guard error == nil else {
            print("Firebase Config フェッチあかん買った")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
            return
         }
         
         print("フェッチできたよ　クラウドからーー")
         self.RemorteConfigs.activateFetched()
      }
   }
   
//   public func GetEasyButtonName() -> String {
//      return RemorteConfigs[RemoConName.EasyStageButtonName].stringValue
//   }
   

}
