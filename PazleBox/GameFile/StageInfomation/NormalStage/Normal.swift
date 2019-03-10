//
//  Normal.swift
//  PazleBox
//
//  Created by jun on 2019/03/09.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class Normal {
   
   var NStage: Array<Any> = Array()
   
   var N1: [[Contents]]
   var N2: [[Contents]]
   var N3: [[Contents]]
   
   init() {
      N1 = [[]]
      N2 = [[]]
      N3 = [[]]
      
      InitN1()
      InitN2()
      InitN3()
      
      InitGetAllEasyStage()
   }
   
   private func InitGetAllEasyStage(){
      
      NStage = self.getNormalStage()
   }
   
   private func getNormalStage() ->Array<Any>  {
      
      var ReturnStage: Array<Any> = Array()
      
      ReturnStage.append(contentsOf: N1)
      ReturnStage.append(contentsOf: N2)
      ReturnStage.append(contentsOf: N3)
      
      return ReturnStage
   }
}
