//
//  ExGameSecenNormalP2.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetNormalMainStage() -> [[Contents]] {
      switch PostedStageNum {
      case 1:
         return AllStage.NormalStage.N1
      case 2:
         return AllStage.NormalStage.N2
      case 3:
         return AllStage.NormalStage.N3
      case 4:
         return AllStage.NormalStage.N4
      case 5:
         return AllStage.NormalStage.N5
      case 6:
         return AllStage.NormalStage.N6
      case 7:
         return AllStage.NormalStage.N7
      case 8:
         return AllStage.NormalStage.N8
      case 9:
         return AllStage.NormalStage.N9
      case 10:
         return AllStage.NormalStage.N10
      case 11:
         return AllStage.NormalStage.N11
      case 12:
         return AllStage.NormalStage.N12
      case 13:
         return AllStage.NormalStage.N13
      case 14:
         return AllStage.NormalStage.N14
      case 15:
         return AllStage.NormalStage.N15
      case 16:
         return AllStage.NormalStage.N16
      case 17:
         return AllStage.NormalStage.N17
      case 18:
         return AllStage.NormalStage.N18
      case 19:
         return AllStage.NormalStage.N19
      case 20:
         return AllStage.NormalStage.N20
         
      default:
         fatalError()
      }
      
      
   }
}
