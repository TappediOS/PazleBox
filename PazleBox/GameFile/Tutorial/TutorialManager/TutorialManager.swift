//
//  TutorialManager.swift
//  PazleBox
//
//  Created by jun on 2020/01/18.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

enum TutorialNum {
   case tutorial1
   case tutorial2
   case tutorial3
   case tutorial4
   case tutorial5
   case tutorial6
   case tutorial7
   case tutorial8
   case tutorial9
   case tutorial10_1
   case tutorial10_2
   case tutorial11
   case tutorial12
   case tutorial13_1
   case tutorial13_2
   case tutorial14
   case tutorial15
}

enum TutorialState {
   case none
   case wait      //まつ
   case advance   //文字を進める状態
   case operaton  //ユーザが操作する状態
}

class TutorialManager {
   var state = TutorialState.none
   var tutorialNum = TutorialNum.tutorial1
   
   init() {
      state = .advance
      tutorialNum = .tutorial1
   }
   
   public func getState() -> TutorialState { return self.state }
   public func getTutorialNum() -> TutorialNum { return self.tutorialNum }
}
