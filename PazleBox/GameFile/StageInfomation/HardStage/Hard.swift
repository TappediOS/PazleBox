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
   
   var H1: [[Contents]] = Array()
   var H2: [[Contents]] = Array()
   var H3: [[Contents]] = Array()
   var H4: [[Contents]] = Array()
   var H5: [[Contents]] = Array()
   var H6: [[Contents]] = Array()
   var H7: [[Contents]] = Array()
   var H8: [[Contents]] = Array()
   var H9: [[Contents]] = Array()
   var H10: [[Contents]] = Array()
   var H11: [[Contents]] = Array()
   var H12: [[Contents]] = Array()
   var H13: [[Contents]] = Array()
   var H14: [[Contents]] = Array()
   var H15: [[Contents]] = Array()
   var H16: [[Contents]] = Array()
   var H17: [[Contents]] = Array()
   var H18: [[Contents]] = Array()
   var H19: [[Contents]] = Array()
   var H20: [[Contents]] = Array()

   
   init() {
      
   
      InitH1()
      InitH2()
      InitH3()
      InitH4()
      InitH5()
      InitH6()
      InitH7()
      InitH8()
      InitH9()
      InitH10()
      InitH11()
      InitH12()
      InitH13()
      InitH14()
      InitH15()
      InitH16()
      InitH17()
      InitH18()
      InitH19()
      InitH20()
      
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
      ReturnStage.append(contentsOf: H4)
      ReturnStage.append(contentsOf: H5)
      ReturnStage.append(contentsOf: H6)
      ReturnStage.append(contentsOf: H7)
      ReturnStage.append(contentsOf: H8)
      ReturnStage.append(contentsOf: H9)
      ReturnStage.append(contentsOf: H10)
      ReturnStage.append(contentsOf: H11)
      ReturnStage.append(contentsOf: H12)
      ReturnStage.append(contentsOf: H13)
      ReturnStage.append(contentsOf: H14)
      ReturnStage.append(contentsOf: H15)
      ReturnStage.append(contentsOf: H16)
      ReturnStage.append(contentsOf: H17)
      ReturnStage.append(contentsOf: H18)
      ReturnStage.append(contentsOf: H19)
      ReturnStage.append(contentsOf: H20)
      
      return ReturnStage
   }
}
