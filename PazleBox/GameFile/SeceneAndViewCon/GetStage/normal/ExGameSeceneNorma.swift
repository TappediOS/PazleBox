//
//  ExGameSeceneNorma.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetNormalPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
      
      switch PostedStageNum {
      case 1:
         let Stage = NStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 2:
         let Stage = NStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 3:
         let Stage = NStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 4:
         let Stage = NStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 5:
         let Stage = NStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 6:
         let Stage = NStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 7:
         let Stage = NStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 8:
         let Stage = NStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 9:
         let Stage = NStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 10:
         let Stage = NStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 11:
         let Stage = NStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 12:
         let Stage = NStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 13:
         let Stage = NStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 14:
         let Stage = NStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 15:
         let Stage = NStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 16:
         let Stage = NStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 17:
         let Stage = NStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 18:
         let Stage = NStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 19:
         let Stage = NStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 20:
         let Stage = NStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
   public func GetNormalHintPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
      
      switch PostedStageNum {
      case 1:
         let Stage = NStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 2:
         let Stage = NStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 3:
         let Stage = NStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 4:
         let Stage = NStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 5:
         let Stage = NStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 6:
         let Stage = NStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 7:
         let Stage = NStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 8:
         let Stage = NStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 9:
         let Stage = NStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 10:
         let Stage = NStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 11:
         let Stage = NStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 12:
         let Stage = NStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 13:
         let Stage = NStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 14:
         let Stage = NStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 15:
         let Stage = NStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 16:
         let Stage = NStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 17:
         let Stage = NStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 18:
         let Stage = NStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 19:
         let Stage = NStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 20:
         let Stage = NStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
}
