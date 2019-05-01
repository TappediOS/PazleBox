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
      case 21:
         let Stage = NStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 22:
         let Stage = NStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 23:
         let Stage = NStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 24:
         let Stage = NStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 25:
         let Stage = NStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 26:
         let Stage = NStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 27:
         let Stage = NStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 28:
         let Stage = NStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 29:
         let Stage = NStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 30:
         let Stage = NStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 31:
         let Stage = NStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 32:
         let Stage = NStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 33:
         let Stage = NStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 34:
         let Stage = NStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 35:
         let Stage = NStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 36:
         let Stage = NStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 37:
         let Stage = NStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 38:
         let Stage = NStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 39:
         let Stage = NStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 40:
         let Stage = NStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 41:
         let Stage = NStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 42:
         let Stage = NStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 43:
         let Stage = NStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 44:
         let Stage = NStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 45:
         let Stage = NStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 46:
         let Stage = NStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 47:
         let Stage = NStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 48:
         let Stage = NStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 49:
         let Stage = NStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 50:
         let Stage = NStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
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
      case 21:
         let Stage = NStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 22:
         let Stage = NStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 23:
         let Stage = NStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 24:
         let Stage = NStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 25:
         let Stage = NStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 26:
         let Stage = NStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 27:
         let Stage = NStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 28:
         let Stage = NStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 29:
         let Stage = NStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 30:
         let Stage = NStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 31:
         let Stage = NStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 32:
         let Stage = NStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 33:
         let Stage = NStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 34:
         let Stage = NStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 35:
         let Stage = NStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 36:
         let Stage = NStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 37:
         let Stage = NStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 38:
         let Stage = NStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 39:
         let Stage = NStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 40:
         let Stage = NStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 41:
         let Stage = NStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 42:
         let Stage = NStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 43:
         let Stage = NStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 44:
         let Stage = NStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 45:
         let Stage = NStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 46:
         let Stage = NStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 47:
         let Stage = NStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 48:
         let Stage = NStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 49:
         let Stage = NStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 50:
         let Stage = NStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
}
