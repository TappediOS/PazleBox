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
   
   //存在してたらtrue
   func collectionViewCellCount() -> Int {
      return app.collectionViews["SellectCreateStageVC_StageCollectionView"].cells.count
   }
   
   //ステージ作りVCの表示テスト
   func testSellectCreateStageVC() {
      showSellectCreateStageVC()
      snapshot("自分のステージセレクトVCの表示テスト")
   }
   
   //ステージセレクトVCでバックボタンを押したときのテスト
   func testSellectStageBackButton() {
      showSellectCreateStageVC()
      app.buttons["SellectCreateStageVC_BackButton"].tap()
      snapshot("ステージセレクトVCでバックボタンを押したときのテスト")
   }
   
   //0番目のCellをタップしたときの表示テスト。
   func testTapCollectionViewCell() {
      showSellectCreateStageVC()
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 0).tap()
      snapshot("0番目のCellをタップしたときの表示テスト。")
   }
   
   //PlayButtonをタップしたときの表示テスト。
   func testTapPlayButton() {
      showSellectCreateStageVC()
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 0).tap()
      app.buttons["PlayButton"].tap()
      snapshot("PlayButtonをタップしたときの表示テスト。")
   }
   
   //Deleteをタップしたときの表示テスト。
   func testTapDeleteButton() {
      showSellectCreateStageVC()
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 0).tap()
      app.buttons["DeleteButton"].tap()
      snapshot("DeleteButtonをタップしたときの表示テスト。")
   }
   
   //Closeをタップしたときの表示テスト。
   func testTapCloseButton() {
      showSellectCreateStageVC()
      let count = collectionViewCellCount()
      guard count != 0 else {
         return
      }
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 0).tap()
      app.buttons["CloseButton"].tap()
      snapshot("CloseButtonをタップしたときの表示テスト。")
   }
   
}
