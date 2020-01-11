//
//  PuzzleTest.swift
//  PazleBoxTests
//
//  Created by jun on 2020/01/11.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import XCTest
@testable import PazleBox

//NOTE: Puzzleのテスト
class PuzzleTest: XCTestCase {
   
   
   override class func setUp() {

   }
   
   override class func tearDown() {
      
   }
   
   override func setUp() {
      
   }
   
   override func tearDown() {

   }

   //Puzzleの情報が正しいかどうかのテスト。
   func testGetOfInfomation() {
      let StartPointX = 3
      let StartPointY =  5
      let PuzzleWide = 4
      let PuzzleHight = 3
      let PuzzleStyle = "43p9"
      
      let PuzzleArry = PArry()
      let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PuzzleStyle)
      
      let Puzzle = puzzle(PX: PuzzleWide, PY: PuzzleHight, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: "43p9", PuzzleColor: "Red", RespawnX: StartPointX, RespawnY: StartPointY)
      
      let exp = Puzzle.GetOfInfomation()
      
      XCTContext.runActivity(named: "ゲットしたピースの情報が正しいこと", block: { _ in
         XCTAssertEqual(exp["StartPointX"] as! Int, StartPointX)
         XCTAssertEqual(exp["StartPointY"] as! Int, StartPointY)
         XCTAssertEqual(exp["PuzzleWide"] as! Int, PuzzleWide)
         XCTAssertEqual(exp["PuzzleHight"] as! Int, PuzzleHight)
         XCTAssertEqual(exp["PArry"] as! Array, PuzzlePArry)
      })
   }
   
   
   //Puzzleの初期化番号が正しいこと。
   func testBirthDayNum() {
      let randBirthDayNum = Int.random(in: 0 ... 10)
      let Puzzle = puzzle(PX: 4, PY: 3, CustNum: randBirthDayNum, ViewX: 50, ViewY: 50, PuzzleStyle: "43p9", PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
      
      XCTAssertEqual(Puzzle.GetBirthDayNum(), randBirthDayNum)
   }
}
