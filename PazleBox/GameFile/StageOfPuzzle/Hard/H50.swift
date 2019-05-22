//
//  H20.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class HStage50 {
   
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
   
   var Hint1: HintPuzzle?
   var Hint2: HintPuzzle?
   
   var PuzzleBox = Array<Any>()
   var HintPuzzleBox = Array<Any>()
   
   init(ViewSizeX: CGFloat, ViewSizeY: CGFloat) {
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      AddPuzzle()
      
      InitHint(SizeX: ViewSizeX, SizeY: ViewSizeY)
      AddHintPuzzle()
   }
   
   private func InitPuzzle(SizeX: CGFloat, SizeY: CGFloat){
      Puzzle1 = puzzle(PX: 1, PY: 2, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "12p1", PuzzleColor: "Green", RespawnX: 0, RespawnY: 11)
      
      Puzzle2 = puzzle(PX: 2, PY: 2, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p1", PuzzleColor: "Red", RespawnX: 1, RespawnY: 11)
      
      Puzzle3 = puzzle(PX: 4, PY: 3, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p45", PuzzleColor: "Red", RespawnX: 0, RespawnY: 11)
      
      Puzzle4 = puzzle(PX: 3, PY: 3, CustNum: 3, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "33p19", PuzzleColor: "Green", RespawnX: 4, RespawnY: 11)
      
      Puzzle5 = puzzle(PX: 2, PY: 3, CustNum: 4, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p1", PuzzleColor: "Red", RespawnX: 7, RespawnY: 11)
      
      Puzzle6 = puzzle(PX: 3, PY: 3, CustNum: 5, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "33p21", PuzzleColor: "Blue", RespawnX: 4, RespawnY: 10)
      
      Puzzle7 = puzzle(PX: 2, PY: 2, CustNum: 6, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p1", PuzzleColor: "Green", RespawnX: 1, RespawnY: 9)
      
      Puzzle8 = puzzle(PX: 4, PY: 3, CustNum: 7, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p24", PuzzleColor: "Blue", RespawnX: 0, RespawnY: 8)
      
      Puzzle9 = puzzle(PX: 4, PY: 3, CustNum: 8, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p25", PuzzleColor: "Red", RespawnX: 0, RespawnY: 8)
      
      Puzzle10 = puzzle(PX: 2, PY: 2, CustNum: 9, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p1", PuzzleColor: "Blue", RespawnX: 1, RespawnY: 7)
      
      Puzzle11 = puzzle(PX: 2, PY: 3, CustNum: 10, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p3", PuzzleColor: "Green", RespawnX: 7, RespawnY: 10)
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
   
   private func AddHintPuzzle() {
      HintPuzzleBox.append(Hint1!)
      HintPuzzleBox.append(Hint2!)
   }
   
   private func InitHint(SizeX: CGFloat, SizeY: CGFloat) {
      Hint1 = HintPuzzle(PX: 2, PY: 1, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "21p1", PuzzleColor: "Blue", AnsX: 6, AnsY: 11)
      
      Hint2 = HintPuzzle(PX: 2, PY: 2, CustNum: 9, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p5", PuzzleColor: "Red", AnsX: 7, AnsY: 7)
   }
   
   
   public func GetPuzzleBox() -> Array<Any> {
      return self.PuzzleBox
   }
   
   public func GetHintPuzzleBox() -> Array<Any> {
      return self.HintPuzzleBox
   }
}
