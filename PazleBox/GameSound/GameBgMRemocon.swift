//
//  GameBgMRemocon.swift
//  PazleBox
//
//  Created by jun on 2019/06/15.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import AVFoundation
import Firebase


extension BGM {
   
   //MARK:- Remote ConfigのInitするよ-
   //MARK: RemoteConfigのdefaultをセットする
   func SetUpRemoteConfigDefaults() {
      let defaultsValues = ["GameBGMKey" : "Yurufuwa" as NSObject]
      self.RemorteConfigs.setDefaults(defaultsValues)
   }
   
   //MARK: InitConfigする
   func InitConfig() {
      self.RemorteConfigs = RemoteConfig.remoteConfig()
      //MARK: デベロッパモード　出すときはやめろ
      #if DEBUG
      print("RemoConデバッグモードでいくとよ。")
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: true)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #else
      print("RemoConリリースモードでいくとよ。")
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: false)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #endif
   }
   
   
   func FetchConfig() {
      // ディベロッパーモードの時、expirationDurationを0にして随時更新できるようにする。
      let expirationDuration = RemorteConfigs.configSettings.isDeveloperModeEnabled ? 0 : 3600
      print("RemoteConfigのフェッチする間隔： \(expirationDuration)")
      RemorteConfigs.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { [unowned self] (status, error) -> Void in
         guard error == nil else {
            print("Firebase Config フェッチあかん買った")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
            return
         }
         
         print("クラウドからGameBGMゲットできました")
         self.RemorteConfigs.activateFetched()
         self.SetGameBGM()
      }
   }
   
   func SetGameBGM() {
      print("Fetched ゲームBGM Name is \(String(describing: RemorteConfigs["GameBGMKey"].stringValue))")
      self.FetchedPlayGameBGM = GetGameBGMFromBGMString(BGMName: RemorteConfigs["GameBGMKey"].stringValue!)
      self.FetchedPlayGameBGM.volume = self.SoundVolume
   }
   
   
   func GetGameBGMFromBGMString(BGMName: String) -> AVAudioPlayer {
      switch BGMName {
      case "Cherry":
         return self.Cherry
      case "Breakfast":
         return self.Breakfast
      case "Hight_Tech":
         return self.Hight_Tech
      case "Morning":
         return self.Morning
      case "Tokino":
         return self.Tokino
      case "Yukimasu":
         return self.Yukimasu
      case "Yurufuwa":
         return self.Yurufuwa
      default:
         print("GameBGM選ぼうとして，リモートコントロールからきた文字を調べたら，上記以外が来た。\n")
         return self.Yurufuwa
      }
   }
}
