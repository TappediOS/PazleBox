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
   var tutorialNum = 0
   
   init() {
      state = .advance
   }
   
   public func getState() -> TutorialState { return self.state }
   public func getTutorialNum() -> Int { return self.tutorialNum }
   
   public func advanceTutorial() {
      tutorialNum += 1
      NotificationCenter.default.post(name: .AdvanceTutorial, object: nil)
   }
   
   public func TapTutorialView() {
      if state == .advance { advanceTutorial() }
   }
}
