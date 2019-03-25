//
//  E2.swift
//  PazleBox
//
//  Created by jun on 2019/03/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class EStage2 {
   
   var Puzzle1: puzzle?
   var Puzzle2: puzzle?
   var Puzzle3: puzzle?
   var Puzzle4: puzzle?
   var Puzzle5: puzzle?
   var Puzzle6: puzzle?
   var Puzzle7: puzzle?
   var Puzzle8: puzzle?
   var Puzzle9: puzzle?
   var Puzzle10: puzzle?
   var Puzzle11: puzzle?
   
   var PuzzleBox = Array<Any>()
   
   init(ViewSizeX: CGFloat, ViewSizeY: CGFloat) {
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitPuzzlePosi()
      AddPuzzle()
   }
   
   private func InitPuzzle(SizeX: CGFloat, SizeY: CGFloat){
      Puzzle1 = puzzle(PX: 2, PY: 3, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p2", PuzzleColor: "Red")
      Puzzle2 = puzzle(PX: 3, PY: 2, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p1", PuzzleColor: "Green")
      Puzzle3 = puzzle(PX: 3, PY: 2, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p1", PuzzleColor: "Blue")
      Puzzle4 = puzzle(PX: 2, PY: 2, CustNum: 3, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p3", PuzzleColor: "Green")
      Puzzle5 = puzzle(PX: 1, PY: 2, CustNum: 4, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "12p1", PuzzleColor: "Red")
      Puzzle6 = puzzle(PX: 2, PY: 1, CustNum: 5, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "21p1", PuzzleColor: "Blue")
      Puzzle7 = puzzle(PX: 2, PY: 2, CustNum: 6, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p3", PuzzleColor: "Blue")
      Puzzle8 = puzzle(PX: 2, PY: 2, CustNum: 7, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p4", PuzzleColor: "Red")
      Puzzle9 = puzzle(PX: 2, PY: 2, CustNum: 8, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p1", PuzzleColor: "Blue")
      Puzzle10 = puzzle(PX: 3, PY: 2, CustNum: 9, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p2", PuzzleColor: "Green")
      Puzzle11 = puzzle(PX: 2, PY: 2, CustNum: 10, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p5", PuzzleColor: "Blue")
      
   }
   
   private func InitPuzzlePosi() {
      Puzzle1!.InitPazzle(PositionX: 0, PositionY: 6, CustomNum: 1)
      Puzzle2!.InitPazzle(PositionX: 2, PositionY: 1, CustomNum: 1)
      Puzzle3!.InitPazzle(PositionX: 0, PositionY: 11, CustomNum: 1)
      Puzzle4!.InitPazzle(PositionX: 0, PositionY: 3, CustomNum: 1)
      Puzzle5!.InitPazzle(PositionX: 5, PositionY: 1, CustomNum: 1)
      Puzzle6!.InitPazzle(PositionX: 2, PositionY: 3, CustomNum: 1)
      Puzzle7!.InitPazzle(PositionX: 7, PositionY: 1, CustomNum: 1)
      Puzzle8!.InitPazzle(PositionX: 5, PositionY: 5, CustomNum: 1)
      Puzzle9!.InitPazzle(PositionX: 3, PositionY: 5, CustomNum: 1)
      Puzzle10!.InitPazzle(PositionX: 5, PositionY:3, CustomNum: 1)
      Puzzle11!.InitPazzle(PositionX: 7, PositionY: 6, CustomNum: 1)
   }
   
   //配列に入れて行ってる
   private func AddPuzzle() {
      PuzzleBox.append(Puzzle1!)
      PuzzleBox.append(Puzzle2!)
      PuzzleBox.append(Puzzle3!)
      PuzzleBox.append(Puzzle4!)
      PuzzleBox.append(Puzzle5!)
      PuzzleBox.append(Puzzle6!)
      PuzzleBox.append(Puzzle7!)
      PuzzleBox.append(Puzzle8!)
      PuzzleBox.append(Puzzle9!)
      PuzzleBox.append(Puzzle10!)
      PuzzleBox.append(Puzzle11!)
   }
   
   public func GetPuzzleBox() -> Array<Any> {
      return self.PuzzleBox
   }
}
