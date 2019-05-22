//
//  SentLeaderBord.swift
//  PazleBox
//
//  Created by jun on 2019/05/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SentLearderBords {
   
   let userDefaults = UserDefaults.standard
   var UserClearStageNum: Int = 0
   var UserClearStageNumEasy: Int = 0
   var UserClearStageNumNormal: Int = 0
   var UserClearStageNumHard: Int = 0
   
   var CollectNumberOfStarsEasy: Int = 0
   var CollectNumberOfStarsNormal: Int = 0
   var CollectNumberOfStarsHard: Int = 0
   var CollectNumberOfStars: Int = 0
   
   let realm = try! Realm()
   
   
   
   init() {
     
      CollectEasy()
      CollectNormal()
      CollectHard()
      
      UserClearStageNum = UserClearStageNumEasy + UserClearStageNumNormal + UserClearStageNumHard
      CollectNumberOfStars = CollectNumberOfStarsEasy + CollectNumberOfStarsNormal + CollectNumberOfStarsHard
      
      print("ステージクリア数　：　\(UserClearStageNum)")
      print("集めた星の数　　　：　\(CollectNumberOfStars)")
   }
   
   private func CollectEasy() {
      let EasyStage = realm.objects(EasyStageClearInfomation.self)
      
      if EasyStage.isEmpty == true{
         print(EasyStage)
         fatalError("なんで空っぽやねん。フザケンナ")
      }
      
      for tmp in 0 ... EasyStage.count - 1 {
         
         if EasyStage[tmp].Clear == false {
            continue
         }
         
         UserClearStageNumEasy += 1
         
         switch EasyStage[tmp].CountOfUsedHint {
         case 0:
            CollectNumberOfStarsEasy += 3
         case 1:
            CollectNumberOfStarsEasy += 2
         case 2:
            CollectNumberOfStarsEasy += 1
         default:
            fatalError("逆に何入ってるか聞きたい。")
         }
      }
      
      print("Easy: ステージクリア数　：　\(UserClearStageNumEasy)")
      print("Easy: 集めた星の数　　　：　\(CollectNumberOfStarsEasy)\n")
   }
   
   private func CollectNormal() {
      let NormalStage = realm.objects(NormalStageClearInfomation.self)
      
      if NormalStage.isEmpty == true{
         print(NormalStage)
         fatalError("なんで空っぽやねん。フザケンナ")
      }
      
      for tmp in 0 ... NormalStage.count - 1 {
         
         if NormalStage[tmp].Clear == false {
            continue
         }
         
         UserClearStageNumNormal += 1
         
         switch NormalStage[tmp].CountOfUsedHint {
         case 0:
            CollectNumberOfStarsNormal += 3
         case 1:
            CollectNumberOfStarsNormal += 2
         case 2:
            CollectNumberOfStarsNormal += 1
         default:
            fatalError("逆に何入ってるか聞きたい。")
         }
      }
      
      print("Normal: ステージクリア数　：　\(UserClearStageNumNormal)")
      print("Normal: 集めた星の数　　　：　\(CollectNumberOfStarsNormal)\n")
   }
   
   private func CollectHard() {
      let HardStage = realm.objects(HardStageClearInfomation.self)
      
      if HardStage.isEmpty == true{
         print(HardStage)
         fatalError("なんで空っぽやねん。フザケンナ")
      }
      
      for tmp in 0 ... HardStage.count - 1 {
         
         if HardStage[tmp].Clear == false {
            continue
         }
         
         UserClearStageNumHard += 1
         
         switch HardStage[tmp].CountOfUsedHint {
         case 0:
            CollectNumberOfStarsHard += 3
         case 1:
            CollectNumberOfStarsHard += 2
         case 2:
            CollectNumberOfStarsHard += 1
         default:
            fatalError("逆に何入ってるか聞きたい。")
         }
      }
      
      print("Hard: ステージクリア数　：　\(UserClearStageNumHard)")
      print("Hard: 集めた星の数　　　：　\(CollectNumberOfStarsHard)\n")
   }
   
}
