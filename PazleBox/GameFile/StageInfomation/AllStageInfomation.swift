//
//  AllStageInfomation.swift
//  PazleBox
//
//  Created by jun on 2019/03/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class AllStageInfo {
   
   var EasyStage = Easy()
   var NormalStage = Normal()
   var HardStage = Hard()
   
   var Checked: [[Contents]] = Array()
   
   init() {
      SetEasyStage()
      InitCheckd()
   }
   
   private func InitCheckd() {
      Checked = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func SetEasyStage() {
      
      
      
   }
}

