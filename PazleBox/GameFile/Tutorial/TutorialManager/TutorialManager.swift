//
//  TutorialManager.swift
//  PazleBox
//
//  Created by jun on 2020/01/18.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

enum TutorialState {
   case none
   case wait      //まつ
   case advance   //文字を進める状態
   case operaton  //ユーザが操作する状態
}

class TutorialManager {
   var state = TutorialState.none
   
   init() {
      state = .advance
   }
   
}
