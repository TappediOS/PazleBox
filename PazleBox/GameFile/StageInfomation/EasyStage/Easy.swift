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
   
   var E1: [[Contents]] = Array()
   var E2: [[Contents]] = Array()
   var E3: [[Contents]] = Array()
   var E4: [[Contents]] = Array()
   var E5: [[Contents]] = Array()
   var E6: [[Contents]] = Array()
   var E7: [[Contents]] = Array()
   var E8: [[Contents]] = Array()
   var E9: [[Contents]] = Array()
   var E10: [[Contents]] = Array()
   var E11: [[Contents]] = Array()
   var E12: [[Contents]] = Array()
   var E13: [[Contents]] = Array()
   var E14: [[Contents]] = Array()
   var E15: [[Contents]] = Array()
   var E16: [[Contents]] = Array()
   var E17: [[Contents]] = Array()
   var E18: [[Contents]] = Array()
   var E19: [[Contents]] = Array()
   var E20: [[Contents]] = Array()
   var E21: [[Contents]] = Array()
   var E22: [[Contents]] = Array()
   var E23: [[Contents]] = Array()
   var E24: [[Contents]] = Array()
   var E25: [[Contents]] = Array()
   var E26: [[Contents]] = Array()
   var E27: [[Contents]] = Array()
   var E28: [[Contents]] = Array()
   var E29: [[Contents]] = Array()
   var E30: [[Contents]] = Array()
   var E31: [[Contents]] = Array()
   var E32: [[Contents]] = Array()
   var E33: [[Contents]] = Array()
   var E34: [[Contents]] = Array()
   var E35: [[Contents]] = Array()
   var E36: [[Contents]] = Array()
   var E37: [[Contents]] = Array()
   var E38: [[Contents]] = Array()
   var E39: [[Contents]] = Array()
   var E40: [[Contents]] = Array()
   
   init() {
     
      InitE1()
      InitE2()
      InitE3()
      InitE4()
      InitE5()
      InitE6()
      InitE7()
      InitE8()
      InitE9()
      InitE10()
      InitE11()
      InitE12()
      InitE13()
      InitE14()
      InitE15()
      InitE16()
      InitE17()
      InitE18()
      InitE19()
      InitE20()
      InitE21()
      InitE22()
      InitE23()
      InitE24()
      InitE25()
      InitE26()
      InitE27()
      InitE28()
      InitE29()
      InitE30()
      InitE31()
      InitE32()
      InitE33()
      InitE34()
      InitE35()
      InitE36()
      InitE37()
      InitE38()
      InitE39()
      InitE40()
      
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
      ReturnStage.append(contentsOf: E4)
      ReturnStage.append(contentsOf: E5)
      ReturnStage.append(contentsOf: E6)
      ReturnStage.append(contentsOf: E7)
      ReturnStage.append(contentsOf: E8)
      ReturnStage.append(contentsOf: E9)
      ReturnStage.append(contentsOf: E10)
      ReturnStage.append(contentsOf: E11)
      ReturnStage.append(contentsOf: E12)
      ReturnStage.append(contentsOf: E13)
      ReturnStage.append(contentsOf: E14)
      ReturnStage.append(contentsOf: E15)
      ReturnStage.append(contentsOf: E16)
      ReturnStage.append(contentsOf: E17)
      ReturnStage.append(contentsOf: E18)
      ReturnStage.append(contentsOf: E19)
      ReturnStage.append(contentsOf: E20)
      ReturnStage.append(contentsOf: E21)
      ReturnStage.append(contentsOf: E22)
      ReturnStage.append(contentsOf: E23)
      ReturnStage.append(contentsOf: E24)
      ReturnStage.append(contentsOf: E25)
      ReturnStage.append(contentsOf: E26)
      ReturnStage.append(contentsOf: E27)
      ReturnStage.append(contentsOf: E28)
      ReturnStage.append(contentsOf: E29)
      ReturnStage.append(contentsOf: E30)
      ReturnStage.append(contentsOf: E31)
      ReturnStage.append(contentsOf: E32)
      ReturnStage.append(contentsOf: E33)
      ReturnStage.append(contentsOf: E34)
      ReturnStage.append(contentsOf: E35)
      ReturnStage.append(contentsOf: E36)
      ReturnStage.append(contentsOf: E37)
      ReturnStage.append(contentsOf: E38)
      ReturnStage.append(contentsOf: E39)
      ReturnStage.append(contentsOf: E40)


      return ReturnStage
   }
}
