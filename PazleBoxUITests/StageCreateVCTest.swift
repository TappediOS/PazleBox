//
//  StageCreateVCTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class StageCreateVCTest: XCTestCase {
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
   
   //ピースのセル(3番目)をタップしたときの表示テスト
   func testTapCollectionViewCell_2_InCreateStageVC() {
      app.buttons["StageMakingButton"].tap()
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 2).tap()
      snapshot("ステージ作りで3番目のcellをタップしたとき")
   }
   
  
}
