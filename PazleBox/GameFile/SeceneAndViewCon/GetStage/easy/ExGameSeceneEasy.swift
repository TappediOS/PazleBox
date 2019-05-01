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
      case 21:
         let Stage = EStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 22:
         let Stage = EStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 23:
         let Stage = EStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 24:
         let Stage = EStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 25:
         let Stage = EStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 26:
         let Stage = EStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 27:
         let Stage = EStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 28:
         let Stage = EStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 29:
         let Stage = EStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 30:
         let Stage = EStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 31:
         let Stage = EStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 32:
         let Stage = EStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 33:
         let Stage = EStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 34:
         let Stage = EStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 35:
         let Stage = EStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 36:
         let Stage = EStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 37:
         let Stage = EStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 38:
         let Stage = EStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 39:
         let Stage = EStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 40:
         let Stage = EStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 41:
         let Stage = EStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 42:
         let Stage = EStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 43:
         let Stage = EStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 44:
         let Stage = EStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 45:
         let Stage = EStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 46:
         let Stage = EStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 47:
         let Stage = EStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 48:
         let Stage = EStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 49:
         let Stage = EStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 50:
         let Stage = EStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      
      default:
         fatalError()
      }
   }
   
   
   
   
   
   public func GetEasyHintPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
      
      switch PostedStageNum {
      case 1:
         let Stage = EStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 2:
         let Stage = EStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 3:
         let Stage = EStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 4:
         let Stage = EStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 5:
         let Stage = EStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 6:
         let Stage = EStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 7:
         let Stage = EStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 8:
         let Stage = EStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 9:
         let Stage = EStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 10:
         let Stage = EStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 11:
         let Stage = EStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 12:
         let Stage = EStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 13:
         let Stage = EStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 14:
         let Stage = EStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 15:
         let Stage = EStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 16:
         let Stage = EStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 17:
         let Stage = EStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 18:
         let Stage = EStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 19:
         let Stage = EStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 20:
         let Stage = EStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 21:
         let Stage = EStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 22:
         let Stage = EStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 23:
         let Stage = EStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 24:
         let Stage = EStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 25:
         let Stage = EStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 26:
         let Stage = EStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 27:
         let Stage = EStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 28:
         let Stage = EStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 29:
         let Stage = EStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 30:
         let Stage = EStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 31:
         let Stage = EStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 32:
         let Stage = EStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 33:
         let Stage = EStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 34:
         let Stage = EStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 35:
         let Stage = EStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 36:
         let Stage = EStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 37:
         let Stage = EStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 38:
         let Stage = EStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 39:
         let Stage = EStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 40:
         let Stage = EStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 41:
         let Stage = EStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 42:
         let Stage = EStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 43:
         let Stage = EStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 44:
         let Stage = EStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 45:
         let Stage = EStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 46:
         let Stage = EStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 47:
         let Stage = EStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 48:
         let Stage = EStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 49:
         let Stage = EStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 50:
         let Stage = EStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
}
