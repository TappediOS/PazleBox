//
//  H20.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class HStage38 {
   
   var Puzzle1: puzzle?
   var Puzzle2: puzzle?
   var Puzzle3: puzzle?
   var Puzzle4: puzzle?
   var Puzzle5: puzzle?
   var Puzzle6: puzzle?
   var Puzzle7: puzzle?
   var Puzzle8: puzzle?
   var Puzzle9: puzzle?
   
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
      Puzzle1 = puzzle(PX: 4, PY: 3, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p2", PuzzleColor: "Green", RespawnX: 0, RespawnY: 5)
      
      Puzzle2 = puzzle(PX: 4, PY: 3, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p50", PuzzleColor: "Blue", RespawnX: 5, RespawnY: 3)
      
      Puzzle3 = puzzle(PX: 4, PY: 3, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p28", PuzzleColor: "Green", RespawnX: 1, RespawnY: 5)
      
      Puzzle4 = puzzle(PX: 4, PY: 3, CustNum: 3, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p42", PuzzleColor: "Red", RespawnX: 3, RespawnY: 2)
      
      Puzzle5 = puzzle(PX: 3, PY: 2, CustNum: 4, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p6", PuzzleColor: "Red", RespawnX: 6, RespawnY: 1)
      
      Puzzle6 = puzzle(PX: 3, PY: 3, CustNum: 5, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "33p15", PuzzleColor: "Blue", RespawnX: 6, RespawnY: 6)
      
      Puzzle7 = puzzle(PX: 3, PY: 2, CustNum: 6, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p14", PuzzleColor: "Red", RespawnX: 0, RespawnY: 1)
      
      Puzzle8 = puzzle(PX: 4, PY: 3, CustNum: 7, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p44", PuzzleColor: "Red", RespawnX: 0, RespawnY: 3)
      
      Puzzle9 = puzzle(PX: 3, PY: 2, CustNum: 8, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p4", PuzzleColor: "Blue", RespawnX: 3, RespawnY: 3)
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
      
   }
   
   private func AddHintPuzzle() {
      HintPuzzleBox.append(Hint1!)
      HintPuzzleBox.append(Hint2!)
   }
   
   private func InitHint(SizeX: CGFloat, SizeY: CGFloat) {
      Hint1 = HintPuzzle(PX: 4, PY: 3, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p2", PuzzleColor: "Green", AnsX: 3, AnsY: 11)
      
      Hint2 = HintPuzzle(PX: 4, PY: 3, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "43p50", PuzzleColor: "Blue", AnsX: 5, AnsY: 11)
   }
   
   
   public func GetPuzzleBox() -> Array<Any> {
      return self.PuzzleBox
   }
   
   public func GetHintPuzzleBox() -> Array<Any> {
      return self.HintPuzzleBox
   }
}

