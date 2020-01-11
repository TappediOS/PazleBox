//
//  UsersGameSceneTest.swift
//  PazleBoxTests
//
//  Created by jun on 2020/01/11.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import XCTest
@testable import PazleBox

//NOTE: SellectCreateStageVCTestのテスト
class UsersGameSceneTest: XCTestCase {
   
   let GameScene = UsersGameScene()

   
   override class func setUp() {

   }
   
   override class func tearDown() {
      
   }
   
   override func setUp() {
      
   }
   
   override func tearDown() {

   }
   
   //xが0以上大きいかつyが11以下の時はTrueである
   func testCheckLeftUp() {
      XCTContext.runActivity(named: "xが0以上大きいかつyが11以下の時はTrueである", block: { _ in
         XCTAssertTrue(GameScene.CheckLeftUp(x: 0, y: 11))
         XCTAssertTrue(GameScene.CheckLeftUp(x: 3, y: 3))
         XCTAssertTrue(GameScene.CheckLeftUp(x: 10, y: 0))
         XCTAssertTrue(GameScene.CheckLeftUp(x: 100, y: -1))
      })
      
      XCTContext.runActivity(named: "xがマイナスの時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckLeftUp(x: -1, y: 11))
         XCTAssertFalse(GameScene.CheckLeftUp(x: -4, y: 20))
         XCTAssertFalse(GameScene.CheckLeftUp(x: -10, y: -12))
      })
      
      XCTContext.runActivity(named: "yが11より大きい時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckLeftUp(x: -4, y: 13))
         XCTAssertFalse(GameScene.CheckLeftUp(x: 0, y: 456))
         XCTAssertFalse(GameScene.CheckLeftUp(x: 23, y: 56))
      })
   }
   
   //xがyが共に0以上でtrue
   func testCheckLeftDown() {
      XCTContext.runActivity(named: "xがyが共に0以上でtrue", block: { _ in
         XCTAssertTrue(GameScene.CheckLeftDown(x: 0, y: 0))
         XCTAssertTrue(GameScene.CheckLeftDown(x: 0, y: 3))
         XCTAssertTrue(GameScene.CheckLeftDown(x: 2, y: 0))
         XCTAssertTrue(GameScene.CheckLeftDown(x: 4, y: 3))
      })
      
      XCTContext.runActivity(named: "xがマイナスの時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckLeftDown(x: -1, y: 0))
         XCTAssertFalse(GameScene.CheckLeftDown(x: -4, y: 34))
         XCTAssertFalse(GameScene.CheckLeftDown(x: -10, y: -1))
      })
      
      XCTContext.runActivity(named: "yがマイナスの時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckLeftDown(x: -4, y: -3))
         XCTAssertFalse(GameScene.CheckLeftDown(x: 0, y: -34))
         XCTAssertFalse(GameScene.CheckLeftDown(x: 23, y: -87))
      })
   }
   
   //xが8以下，かつ，yが11以下の時はTrueである
   func testCheckRightUp() {
      XCTContext.runActivity(named: "xが8以下，かつ，yが11以下の時はTrueである", block: { _ in
         XCTAssertTrue(GameScene.CheckRightUp(x: 8, y: 11))
         XCTAssertTrue(GameScene.CheckRightUp(x: 3, y: 11))
         XCTAssertTrue(GameScene.CheckRightUp(x: 8, y: 0))
         XCTAssertTrue(GameScene.CheckRightUp(x: -3, y: -1))
      })
      
      XCTContext.runActivity(named: "xが8より大きいの時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckRightUp(x: 9, y: 12))
         XCTAssertFalse(GameScene.CheckRightUp(x: 11, y: 0))
         XCTAssertFalse(GameScene.CheckRightUp(x: 14, y: 3))
      })
      
      XCTContext.runActivity(named: "yが11より 大きい時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckRightUp(x: -4, y: 13))
         XCTAssertFalse(GameScene.CheckRightUp(x: 0, y: 456))
         XCTAssertFalse(GameScene.CheckRightUp(x: 23, y: 56))
      })
   }
   
   //xが8以下，かつyが0以上の時はTrueである
   func testCheckRightDown() {
      XCTContext.runActivity(named: "xが8以下，かつyが0以上の時はTrueである", block: { _ in
         XCTAssertTrue(GameScene.CheckRightDown(x: 0, y: 0))
         XCTAssertTrue(GameScene.CheckRightDown(x: 8, y: 8))
         XCTAssertTrue(GameScene.CheckRightDown(x: 8, y: 0))
         XCTAssertTrue(GameScene.CheckRightDown(x: 5, y: 4))
      })
      
      XCTContext.runActivity(named: "xが8より大きいの時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckRightDown(x: 9, y: 11))
         XCTAssertFalse(GameScene.CheckRightDown(x: 10, y: 0))
         XCTAssertFalse(GameScene.CheckRightDown(x: 12, y: -12))
      })
      
      XCTContext.runActivity(named: "yがマイナス時はFalseである。", block: { _ in
         XCTAssertFalse(GameScene.CheckRightDown(x: -4, y: -1))
         XCTAssertFalse(GameScene.CheckRightDown(x: 0, y: -3))
         XCTAssertFalse(GameScene.CheckRightDown(x: 23, y: -2))
      })
   }

}

