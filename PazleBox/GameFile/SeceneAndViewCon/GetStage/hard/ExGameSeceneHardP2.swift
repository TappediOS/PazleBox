//
//  ExGameSeceneHardP2.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetHardMainStage() -> [[Contents]] {
      switch PostedStageNum {
      case 1:
         return AllStage.HardStage.H1
      case 2:
         return AllStage.HardStage.H2
      case 3:
         return AllStage.HardStage.H3
      case 4:
         return AllStage.HardStage.H4
      case 5:
         return AllStage.HardStage.H5
      case 6:
         return AllStage.HardStage.H6
      case 7:
         return AllStage.HardStage.H7
      case 8:
         return AllStage.HardStage.H8
      case 9:
         return AllStage.HardStage.H9
      case 10:
         return AllStage.HardStage.H10
      case 11:
         return AllStage.HardStage.H11
      case 12:
         return AllStage.HardStage.H12
      case 13:
         return AllStage.HardStage.H13
      case 14:
         return AllStage.HardStage.H14
      case 15:
         return AllStage.HardStage.H15
      case 16:
         return AllStage.HardStage.H16
      case 17:
         return AllStage.HardStage.H17
      case 18:
         return AllStage.HardStage.H18
      case 19:
         return AllStage.HardStage.H19
      case 20:
         return AllStage.HardStage.H20
         
      default:
         fatalError()
      }
      
      
   }
}
