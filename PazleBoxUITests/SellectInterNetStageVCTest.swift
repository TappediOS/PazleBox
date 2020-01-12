//
//  SellectInterNetStageVCTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class SellectInterNetStageVCTest: XCTestCase {
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
   
   func showSellectInternetCreateStageVC() {
       app.buttons["CreateHomeVC_InternetUsersStageButton"].tap()
   }
   
   //存在してたらtrue
   func collectionViewCellCount() -> Int {
      return app.collectionViews["SellectInternetStageVC_StageCollectionView"].cells.count
   }
   
   //InterNetステージVCの表示テスト
   func testSellectInternetCreateStageVC() {
      showSellectInternetCreateStageVC()
      snapshot("InterNetステージ作りVCの表示テスト")
   }
   
   //InterNetステージVCでバックボタンを押したときのテスト
   func testSellectStageBackButton() {
      showSellectInternetCreateStageVC()
      app.buttons["SellectInternetStageVC_StageCollectionView"].tap()
      snapshot("InterNetステージVCでバックボタンを押したときのテスト")
   }
   
   //PlayCountのセグメントをタップしたときの表示テスト
   func testSegmentPlayCount() {
      showSellectInternetCreateStageVC()
      let segment = app.segmentedControls["SellectInternetStageVC_Segment"]
      segment.tap(withNumberOfTaps: 1, numberOfTouches: 1)
      snapshot("PlayCountのセグメントをタップしたときの表示テスト")
   }
}
