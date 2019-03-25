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
   
   var N1: [[Contents]] = Array()
   var N2: [[Contents]] = Array()
   var N3: [[Contents]] = Array()
   var N4: [[Contents]] = Array()
   var N5: [[Contents]] = Array()
   var N6: [[Contents]] = Array()
   var N7: [[Contents]] = Array()
   var N8: [[Contents]] = Array()
   var N9: [[Contents]] = Array()
   var N10: [[Contents]] = Array()
   var N11: [[Contents]] = Array()
   var N12: [[Contents]] = Array()
   var N13: [[Contents]] = Array()
   var N14: [[Contents]] = Array()
   var N15: [[Contents]] = Array()
   var N16: [[Contents]] = Array()
   var N17: [[Contents]] = Array()
   var N18: [[Contents]] = Array()
   var N19: [[Contents]] = Array()
   var N20: [[Contents]] = Array()
   
   init() {
     
      
      InitN1()
      InitN2()
      InitN3()
      InitN4()
      InitN5()
      InitN6()
      InitN7()
      InitN8()
      InitN9()
      InitN10()
      InitN11()
      InitN12()
      InitN13()
      InitN14()
      InitN15()
      InitN16()
      InitN17()
      InitN18()
      InitN19()
      InitN20()
      
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
      ReturnStage.append(contentsOf: N4)
      ReturnStage.append(contentsOf: N5)
      ReturnStage.append(contentsOf: N6)
      ReturnStage.append(contentsOf: N7)
      ReturnStage.append(contentsOf: N8)
      ReturnStage.append(contentsOf: N9)
      ReturnStage.append(contentsOf: N10)
      ReturnStage.append(contentsOf: N11)
      ReturnStage.append(contentsOf: N12)
      ReturnStage.append(contentsOf: N13)
      ReturnStage.append(contentsOf: N14)
      ReturnStage.append(contentsOf: N15)
      ReturnStage.append(contentsOf: N16)
      ReturnStage.append(contentsOf: N17)
      ReturnStage.append(contentsOf: N18)
      ReturnStage.append(contentsOf: N19)
      ReturnStage.append(contentsOf: N20)
      
      return ReturnStage
   }
}
