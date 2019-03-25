//
//  ExGameSeceneEasyP2.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetEasyMainStage() -> [[Contents]] {
      switch PostedStageNum {
      case 1:
         return AllStage.EasyStage.E1
      case 2:
         return AllStage.EasyStage.E2
      case 3:
         return AllStage.EasyStage.E3
      case 4:
         return AllStage.EasyStage.E4
      case 5:
         return AllStage.EasyStage.E5
      case 6:
         return AllStage.EasyStage.E6
      case 7:
         return AllStage.EasyStage.E7
      case 8:
         return AllStage.EasyStage.E8
      case 9:
         return AllStage.EasyStage.E9
      case 10:
         return AllStage.EasyStage.E10
      case 11:
         return AllStage.EasyStage.E11
      case 12:
         return AllStage.EasyStage.E12
      case 13:
         return AllStage.EasyStage.E13
      case 14:
         return AllStage.EasyStage.E14
      case 15:
         return AllStage.EasyStage.E15
      case 16:
         return AllStage.EasyStage.E16
      case 17:
         return AllStage.EasyStage.E17
      case 18:
         return AllStage.EasyStage.E18
      case 19:
         return AllStage.EasyStage.E19
      case 20:
         return AllStage.EasyStage.E20
   
      default:
         fatalError()
      }
         
      
   }
}
