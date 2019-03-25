//
//  ExGameSeceneEasy.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetEasyPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
   
      switch PostedStageNum {
      case 1:
         let Stage = EStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 2:
         let Stage = EStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 3:
         let Stage = EStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 4:
         let Stage = EStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 5:
         let Stage = EStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 6:
         let Stage = EStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 7:
         let Stage = EStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 8:
         let Stage = EStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 9:
         let Stage = EStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 10:
         let Stage = EStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 11:
         let Stage = EStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 12:
         let Stage = EStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 13:
         let Stage = EStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 14:
         let Stage = EStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 15:
         let Stage = EStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 16:
         let Stage = EStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 17:
         let Stage = EStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 18:
         let Stage = EStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 19:
         let Stage = EStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 20:
         let Stage = EStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      
      default:
         fatalError()
      }
   }
   
}
