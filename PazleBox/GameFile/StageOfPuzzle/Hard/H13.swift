//
//  H13.swift
//  PazleBox
//
//  Created by jun on 2019/03/26.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class HStage13 {
   
   var Puzzle1: puzzle?
   var Puzzle2: puzzle?
   var Puzzle3: puzzle?
   var Puzzle4: puzzle?
   
   var PuzzleBox = Array<Any>()
   
   init(ViewSizeX: CGFloat, ViewSizeY: CGFloat) {
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitPuzzlePosi()
      AddPuzzle()
   }
   
   private func InitPuzzle(SizeX: CGFloat, SizeY: CGFloat){
      Puzzle1 = puzzle(PX: 3, PY: 2, CustNum: 0, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "32p2", PuzzleColor: "Red")
      Puzzle2 = puzzle(PX: 2, PY: 3, CustNum: 1, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p1", PuzzleColor: "Green")
      Puzzle3 = puzzle(PX: 2, PY: 3, CustNum: 2, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p2", PuzzleColor: "Blue")
      Puzzle4 = puzzle(PX: 2, PY: 3, CustNum: 3, ViewX: Int(SizeX), ViewY: Int(SizeY), PuzzleStyle: "23p2", PuzzleColor: "Red")
   }
   
   private func InitPuzzlePosi() {
      Puzzle1!.InitPazzle(PositionX: 4, PositionY: 1, CustomNum: 1)
      Puzzle2!.InitPazzle(PositionX: 1, PositionY: 3, CustomNum: 1)
      Puzzle3!.InitPazzle(PositionX: 2, PositionY: 2, CustomNum: 1)
      Puzzle4!.InitPazzle(PositionX: 0, PositionY: 2, CustomNum: 1)
   }
   
   //配列に入れて行ってる
   private func AddPuzzle() {
      PuzzleBox.append(Puzzle1!)
      PuzzleBox.append(Puzzle2!)
      PuzzleBox.append(Puzzle3!)
      PuzzleBox.append(Puzzle4!)
      
   }
   
   public func GetPuzzleBox() -> Array<Any> {
      return self.PuzzleBox
   }
}
