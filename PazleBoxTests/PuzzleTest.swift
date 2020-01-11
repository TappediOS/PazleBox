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
   

   
   //Puzzle22で生成した配列と生の配列が一致するかのテスト
   func testPuzzle22ArrayCreated() {
      let PiceW = 2
      let PiceH = 2
      let NumOfPices = 5
      let Ptype = String(PiceW) + String(PiceH)
      let PuzzleArry = PArry()

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PStyle)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         XCTAssertEqual(Puzzle.pAllPosi, PuzzlePArry)
      }
   }
   
   //Puzzle22でをタッチした部分がInかOutかを判定。
   func testTouchPointIsAlphaPuzzle22() {
      let PiceW = 2
      let PiceH = 2
      let NumOfPices = 5
      let Ptype = String(PiceW) + String(PiceH)

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         for X in 0 ... PiceW - 1 {
            for Y in 0 ... PiceH - 1 {
               let exp = Puzzle.TouchPointIsAlpha(X: X, Y: Y)
               if Puzzle.pAllPosi[Y][X] == .Out {
                  XCTAssertTrue(exp)
               }
            }
         }
      }
   }
   
   //Puzzle23で生成した配列と生の配列が一致するかのテスト
   func testPuzzle23ArrayCreated() {
      let PiceW = 2
      let PiceH = 3
      let NumOfPices = 14
      let Ptype = String(PiceW) + String(PiceH)
      let PuzzleArry = PArry()

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PStyle)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         XCTAssertEqual(Puzzle.pAllPosi, PuzzlePArry)
      }
   }
   
   //Puzzle23でをタッチした部分がInかOutかを判定。
   func testTouchPointIsAlphaPuzzle23() {
      let PiceW = 2
      let PiceH = 3
      let NumOfPices = 14
      let Ptype = String(PiceW) + String(PiceH)

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         for X in 0 ... PiceW - 1 {
            for Y in 0 ... PiceH - 1 {
               let exp = Puzzle.TouchPointIsAlpha(X: X, Y: Y)
               if Puzzle.pAllPosi[Y][X] == .Out {
                  XCTAssertTrue(exp)
               }
            }
         }
      }
   }
   
   //Puzzle32で生成した配列と生の配列が一致するかのテスト
   func testPuzzle32ArrayCreated() {
      let PiceW = 3
      let PiceH = 2
      let NumOfPices = 14
      let Ptype = String(PiceW) + String(PiceH)
      let PuzzleArry = PArry()

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PStyle)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         XCTAssertEqual(Puzzle.pAllPosi, PuzzlePArry)
      }
   }
   
   //Puzzle32でをタッチした部分がInかOutかを判定。
   func testTouchPointIsAlphaPuzzle32() {
      let PiceW = 3
      let PiceH = 2
      let NumOfPices = 14
      let Ptype = String(PiceW) + String(PiceH)

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         for X in 0 ... PiceW - 1 {
            for Y in 0 ... PiceH - 1 {
               let exp = Puzzle.TouchPointIsAlpha(X: X, Y: Y)
               if Puzzle.pAllPosi[Y][X] == .Out {
                  XCTAssertTrue(exp)
               }
            }
         }
      }
   }
   
   //Puzzle33で生成した配列と生の配列が一致するかのテスト
   func testPuzzle33ArrayCreated() {
      let PiceW = 3
      let PiceH = 3
      let NumOfPices = 44
      let Ptype = String(PiceW) + String(PiceH)
      let PuzzleArry = PArry()

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PStyle)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         XCTAssertEqual(Puzzle.pAllPosi, PuzzlePArry)
      }
   }
   
   //Puzzle33でをタッチした部分がInかOutかを判定。
   func testTouchPointIsAlphaPuzzle33() {
      let PiceW = 3
      let PiceH = 3
      let NumOfPices = 44
      let Ptype = String(PiceW) + String(PiceH)

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         for X in 0 ... PiceW - 1 {
            for Y in 0 ... PiceH - 1 {
               let exp = Puzzle.TouchPointIsAlpha(X: X, Y: Y)
               if Puzzle.pAllPosi[Y][X] == .Out {
                  XCTAssertTrue(exp)
               }
            }
         }
      }
   }
   
   //Puzzle43で生成した配列と生の配列が一致するかのテスト
   func testPuzzle43ArrayCreated() {
      let PiceW = 4
      let PiceH = 3
      let NumOfPices = 51
      let Ptype = String(PiceW) + String(PiceH)
      let PuzzleArry = PArry()

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let PuzzlePArry = PuzzleArry.GerPArry(PuzzleStyle: PStyle)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         XCTAssertEqual(Puzzle.pAllPosi, PuzzlePArry)
      }
   }
   
   //Puzzle43でをタッチした部分がInかOutかを判定。
   func testTouchPointIsAlphaPuzzle43() {
      let PiceW = 4
      let PiceH = 3
      let NumOfPices = 51
      let Ptype = String(PiceW) + String(PiceH)

      for PNum in 1 ... NumOfPices {
         let PStyle = Ptype + "p" + String(PNum)
         let Puzzle = puzzle(PX: PiceW, PY: PiceH, CustNum: 2, ViewX: 50, ViewY: 50, PuzzleStyle: PStyle, PuzzleColor: "Red", RespawnX: 3, RespawnY: 3)
         
         for X in 0 ... PiceW - 1 {
            for Y in 0 ... PiceH - 1 {
               let exp = Puzzle.TouchPointIsAlpha(X: X, Y: Y)
               if Puzzle.pAllPosi[Y][X] == .Out {
                  XCTAssertTrue(exp)
               }
            }
         }
      }
   }
}
