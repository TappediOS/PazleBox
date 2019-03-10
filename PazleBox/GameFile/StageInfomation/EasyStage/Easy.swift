//
//  File.swift
//  PazleBox
//
//  Created by jun on 2019/03/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class Easy {
   
   var EStage: Array<Any> = Array()
   
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
      
      InitGetAllEasyStage()
   }
   
   private func InitGetAllEasyStage(){
      
      EStage = self.getEasyStage()
   }
   
   private func getEasyStage() ->Array<Any>  {
      
      var ReturnStage: Array<Any> = Array()

      ReturnStage.append(contentsOf: E1)
      ReturnStage.append(contentsOf: E2)
      ReturnStage.append(contentsOf: E3)

      return ReturnStage
   }
}
