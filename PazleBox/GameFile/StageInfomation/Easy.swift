//
//  File.swift
//  PazleBox
//
//  Created by jun on 2019/03/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class Easy {
   
   var E1: [[Contents]]
   var E2: [[Contents]]
   var E3: [[Contents]]
   
   init() {
      E1 = [[]]
      E2 = [[]]
      E3 = [[]]
      
      InitE1()
      InitE2()
      InitE3()
   }
   
   public func getEasyStage() -> [Contents] {
      
      var ReturnStage:Contents = []
      
      ReturnStage.append(contentsOf: E1)
      ReturnStage.append(contentsOf: E2)
      ReturnStage.append(contentsOf: E3)
      
      return ReturnStage
   }
}
