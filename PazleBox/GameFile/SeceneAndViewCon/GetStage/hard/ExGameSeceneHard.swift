//
//  ExGameSeceneHard.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension GameScene {
   
   public func GetHardPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
      
      switch PostedStageNum {
      case 1:
         let Stage = HStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 2:
         let Stage = HStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 3:
         let Stage = HStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 4:
         let Stage = HStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 5:
         let Stage = HStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 6:
         let Stage = HStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 7:
         let Stage = HStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 8:
         let Stage = HStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 9:
         let Stage = HStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 10:
         let Stage = HStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 11:
         let Stage = HStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 12:
         let Stage = HStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 13:
         let Stage = HStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 14:
         let Stage = HStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 15:
         let Stage = HStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 16:
         let Stage = HStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 17:
         let Stage = HStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 18:
         let Stage = HStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 19:
         let Stage = HStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 20:
         let Stage = HStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 21:
         let Stage = HStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 22:
         let Stage = HStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 23:
         let Stage = HStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 24:
         let Stage = HStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 25:
         let Stage = HStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 26:
         let Stage = HStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 27:
         let Stage = HStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 28:
         let Stage = HStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 29:
         let Stage = HStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 30:
         let Stage = HStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 31:
         let Stage = HStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 32:
         let Stage = HStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 33:
         let Stage = HStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 34:
         let Stage = HStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 35:
         let Stage = HStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 36:
         let Stage = HStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 37:
         let Stage = HStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 38:
         let Stage = HStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 39:
         let Stage = HStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 40:
         let Stage = HStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 41:
         let Stage = HStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 42:
         let Stage = HStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 43:
         let Stage = HStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 44:
         let Stage = HStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 45:
         let Stage = HStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 46:
         let Stage = HStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 47:
         let Stage = HStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 48:
         let Stage = HStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 49:
         let Stage = HStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
      case 50:
         let Stage = HStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
   public func GetHardHintPuzzleBox(ViewSizeX: CGFloat?, ViewSizeY: CGFloat?) -> Array<Any> {
      
      switch PostedStageNum {
      case 1:
         let Stage = HStage1(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 2:
         let Stage = HStage2(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 3:
         let Stage = HStage3(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 4:
         let Stage = HStage4(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 5:
         let Stage = HStage5(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 6:
         let Stage = HStage6(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 7:
         let Stage = HStage7(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 8:
         let Stage = HStage8(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 9:
         let Stage = HStage9(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 10:
         let Stage = HStage10(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 11:
         let Stage = HStage11(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 12:
         let Stage = HStage12(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 13:
         let Stage = HStage13(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 14:
         let Stage = HStage14(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 15:
         let Stage = HStage15(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 16:
         let Stage = HStage16(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 17:
         let Stage = HStage17(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 18:
         let Stage = HStage18(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 19:
         let Stage = HStage19(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 20:
         let Stage = HStage20(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 21:
         let Stage = HStage21(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 22:
         let Stage = HStage22(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 23:
         let Stage = HStage23(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 24:
         let Stage = HStage24(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 25:
         let Stage = HStage25(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 26:
         let Stage = HStage26(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 27:
         let Stage = HStage27(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 28:
         let Stage = HStage28(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 29:
         let Stage = HStage29(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 30:
         let Stage = HStage30(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 31:
         let Stage = HStage31(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 32:
         let Stage = HStage32(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 33:
         let Stage = HStage33(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 34:
         let Stage = HStage34(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 35:
         let Stage = HStage35(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 36:
         let Stage = HStage36(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 37:
         let Stage = HStage37(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 38:
         let Stage = HStage38(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 39:
         let Stage = HStage39(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 40:
         let Stage = HStage40(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 41:
         let Stage = HStage41(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 42:
         let Stage = HStage42(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 43:
         let Stage = HStage43(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 44:
         let Stage = HStage44(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 45:
         let Stage = HStage45(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 46:
         let Stage = HStage46(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 47:
         let Stage = HStage47(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 48:
         let Stage = HStage48(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 49:
         let Stage = HStage49(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
      case 50:
         let Stage = HStage50(ViewSizeX: ViewSizeX!, ViewSizeY: ViewSizeY!)
         return Stage.GetHintPuzzleBox()
         
      default:
         fatalError()
      }
   }
   
}
