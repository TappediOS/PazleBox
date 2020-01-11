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

}

