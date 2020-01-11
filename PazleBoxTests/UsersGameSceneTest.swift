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
   
   
   func testGetSeceneScalaMode() {
      GameScene.CheckLeftUp()
   }

}

