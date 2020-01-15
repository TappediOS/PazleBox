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
      XCUIApplication().tabBars.otherElements["tabBar_Play"].tap()
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
      app.buttons["SellectInternetStageVC_BackButton"].tap()
      snapshot("InterNetステージVCでバックボタンを押したときのテスト")
   }
   
   func localizedStr(_ key: String) -> String {
      return NSLocalizedString(key, bundle: Bundle(for: SellectInterNetStageVCTest.self), comment: "")
   }
   
   //PlayCountのセグメントをタップしたときの表示テスト
   func testSegmentPlayCount() {
      showSellectInternetCreateStageVC()
      let element = app.otherElements["SellectInternetStageVC_Segment"].children(matching: .other).element.children(matching: .other).element(boundBy: 1)
      print("PlayCountのセグメント名 = \(localizedStr("PlayCount"))")
      element.staticTexts[localizedStr("PlayCount")].tap()
      snapshot("PlayCountのセグメントをタップしたときの表示テスト")
      
   }
   
   //Ratingのセグメントをタップしたときの表示テスト
   func testSegmentRating() {
      showSellectInternetCreateStageVC()
      let element = app.otherElements["SellectInternetStageVC_Segment"].children(matching: .other).element.children(matching: .other).element(boundBy: 1)
      print("Ratingのセグメント名 = \(localizedStr("Rating"))")
      element.staticTexts[localizedStr("Rating")].tap()
      snapshot("Ratingのセグメントをタップしたときの表示テスト")
   }
   
   //InterNetで0番目のCellをタップしたときの表示テスト。
   func testTapCollectionViewCell() {
      showSellectInternetCreateStageVC()
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["SellectInternetStageVC_Segment"].cells.element(boundBy: 0).tap()
      snapshot("InterNetで0番目のCellをタップしたときの表示テスト。")
   }
   
   //InterNetでPlayButtonをタップしたときの表示テスト
   func testTapPlayButtonNet() {
      showSellectInternetCreateStageVC()
      let random = Int.random(in: 0 ... 8)
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["SellectInternetStageVC_Segment"].cells.element(boundBy: random).tap()
      app.buttons["PlayButton"].tap()
      snapshot("InterNetでPlayButtonをタップしたときの表示テスト")
   }
   
   //InterNetでCloseButtonをタップしたときの表示テスト
   func testTapCloseButtonNet() {
      showSellectInternetCreateStageVC()
      let random = Int.random(in: 0 ... 8)
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["SellectInternetStageVC_Segment"].cells.element(boundBy: random).tap()
      app.buttons["CloseButton"].tap()
      snapshot("InterNetでCloseButtonをタップしたときの表示テスト")
   }
}
