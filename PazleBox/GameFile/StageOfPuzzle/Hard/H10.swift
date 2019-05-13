//
//  H10.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class HStage10 {
   
   var Puzzle1: puzzle?
   var Puzzle2: puzzle?
   var Puzzle3: puzzle?
   var Puzzle4: puzzle?
   var Puzzle5: puzzle?
   var Puzzle6: puzzle?
   var Puzzle7: puzzle?
   var Puzzle8: puzzle?
   
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
      Puzzle1 = puzzle(PX: 2, PY: 3, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p1", PuzzleColor: "Red", RespawnX: 1, RespawnY: 10)
      
      Puzzle2 = puzzle(PX: 3, PY: 2, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p5", PuzzleColor: "Red", RespawnX: 5, RespawnY: 10)
      
      Puzzle3 = puzzle(PX: 2, PY: 3, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p12", PuzzleColor: "Green", RespawnX: 2, RespawnY: 9)
      
      Puzzle4 = puzzle(PX: 3, PY: 2, CustNum: 3, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p6", PuzzleColor: "Blue", RespawnX: 1, RespawnY: 7)
      
      Puzzle5 = puzzle(PX: 3, PY: 2, CustNum: 4, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p14", PuzzleColor: "Red", RespawnX: 4, RespawnY: 7)
      
      Puzzle6 = puzzle(PX: 2, PY: 3, CustNum: 5, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p4", PuzzleColor: "Green", RespawnX: 6, RespawnY: 8)
      
      Puzzle7 = puzzle(PX: 3, PY: 3, CustNum: 6, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "33p30", PuzzleColor: "Blue", RespawnX: 4, RespawnY: 9)
      
      Puzzle8 = puzzle(PX: 3, PY: 3, CustNum: 7, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "33p38", PuzzleColor: "Green", RespawnX: 3, RespawnY: 10)
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
      
   }
   
   private func AddHintPuzzle() {
      HintPuzzleBox.append(Hint1!)
      HintPuzzleBox.append(Hint2!)
   }
   
   private func InitHint(SizeX: CGFloat, SizeY: CGFloat) {
      Hint1 = HintPuzzle(PX: 3, PY: 2, CustNum: 4, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p3", PuzzleColor: "Green", AnsX: 0, AnsY: 11)
      
      Hint2 = HintPuzzle(PX: 2, PY: 2, CustNum: 5, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "22p1", PuzzleColor: "Green", AnsX: 6, AnsY: 11)
   }
   
   
   public func GetPuzzleBox() -> Array<Any> {
      return self.PuzzleBox
   }
   
   public func GetHintPuzzleBox() -> Array<Any> {
      return self.HintPuzzleBox
   }
}
