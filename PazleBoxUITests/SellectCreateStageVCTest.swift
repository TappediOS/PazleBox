//
//  SellectCreateStageVC.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class SellectCreateStageVC: XCTestCase {
   let app = XCUIApplication()
   
   override func setUp() {
     continueAfterFailure = false
     let app = XCUIApplication()
     setupSnapshot(app)
     app.launch()
   }

   override func tearDown() {
      super.tearDown()
   }
   
   func showSellectCreateStageVC() {
       app.buttons["CreateHomeVC_SellectStageButton"].tap()
   }
   
   //ステージ作りVCの表示テスト
   func testSellectCreateStageVC() {
      showSellectCreateStageVC()
      snapshot("自分のステージセレクトVCの表示テスト")
   }
   
   //ステージ作りVCでバックボタンを押したときのテスト
   func testSellectStageBackButton() {
      showSellectCreateStageVC()
      app.buttons["SellectCreateStageVC_BackButton"].tap()
      snapshot("ステージ作りVCでバックボタンを押したときのテスト")
   }
}
