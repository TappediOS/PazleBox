//
//  Hard.swift
//  PazleBox
//
//  Created by jun on 2019/03/09.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class Hard {
   
   var HStage: Array<Any> = Array()
   
   var H1: [[Contents]]
   var H2: [[Contents]]
   var H3: [[Contents]]
   
   init() {
      H1 = [[]]
      H2 = [[]]
      H3 = [[]]
   
      InitH1()
      InitH2()
      InitH3()
      
      InitGetAllHardStage()
   }
   
   private func InitGetAllHardStage(){
      
      HStage = self.getHardStage()
   }
   
   private func getHardStage() ->Array<Any>  {
      
      var ReturnStage: Array<Any> = Array()
      
      ReturnStage.append(contentsOf: H1)
      ReturnStage.append(contentsOf: H2)
      ReturnStage.append(contentsOf: H3)
      
      return ReturnStage
   }
}
