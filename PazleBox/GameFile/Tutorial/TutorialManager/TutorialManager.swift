//
//  TutorialManager.swift
//  PazleBox
//
//  Created by jun on 2020/01/18.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

enum TutorialState {
   case none                      //状態なし
   case wait                      //まつ
   case advance                   //文字を進める状態
   case operationButton           //ユーザがボタン操作する状態
   case operationCollectionView   //ユーザがCollectionView操作する状態
}

class TutorialManager {
   var state = TutorialState.none
   var tutorialNum = 1
   
   init() {
      state = .advance
   }
   
   public func getState() -> TutorialState { return self.state }
   public func getTutorialNum() -> Int { return self.tutorialNum }
   
   public func advanceTutorial() {
      tutorialNum += 1
      NotificationCenter.default.post(name: .AdvanceTutorial, object: nil)
   }
   
   func TurnOnCollectionViewNotification() {
      NotificationCenter.default.post(name: .TurnOnCollectionView, object: nil)
   }
   
   func TuronOffCollectionViewNotification() {
      NotificationCenter.default.post(name: .TuronOffCollectionView, object: nil)
   }
   
   func TurnOnFinButtonNotification() {
      NotificationCenter.default.post(name: .TurnOnFinButton, object: nil)
   }
   
   func TuronOffFinButtonNotification() {
      NotificationCenter.default.post(name: .TuronOffFinButton, object: nil)
   }
   
   func TurnOnChoseResButtonNotification() {
      NotificationCenter.default.post(name: .TurnOnChoseResButton, object: nil)
   }
   
   func TuronOffChoseResButtonNotification() {
      NotificationCenter.default.post(name: .TuronOffChoseResButton, object: nil)
   }
   

   
   public func TapTutorialView() {
      print("現在のチュートリアル番号: \(self.tutorialNum)")
      switch self.tutorialNum {
      case 1:
         advanceTutorial()
      case 2:
         advanceTutorial()
      case 3:
         advanceTutorial()
      case 4:
         advanceTutorial()
      case 5:
         advanceTutorial()
      case 6:
         advanceTutorial()
      case 7:
         advanceTutorial()
      case 8:
         advanceTutorial()
      case 9:
         advanceTutorial()
      case 10:
         advanceTutorial()
      case 11:
         advanceTutorial()
      case 12:
         advanceTutorial()
      case 13:
         advanceTutorial()
      case 14:
         advanceTutorial()
      case 15:
         advanceTutorial()
      default:
         print("チュートリアル番号が間違っています。")
         return
      }
   }
}
