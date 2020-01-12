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
   
   func showCreateStageVC() {
       app.buttons["StageMakingButton"].tap()
   }
   
   //ステージ作りのVCの表示テスト
   func testShowCreateStageVC() {
      showCreateStageVC()
      snapshot("ステージ作りのVCの表示テスト")
   }
   
   //ピースのセル(3番目)をタップしたときの表示テスト
   func testTapCollectionViewCell() {
      showCreateStageVC()
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 2).tap()
      snapshot("ステージ作りで3番目のcellをタップしたとき")
   }
   
   //ゴミ箱タップしたときの表示テスト
   func testTapTrashImageViewInCreateStageVC() {
      showCreateStageVC()
      app.images["CleateStageVC_TrashImageView"].tap()
      snapshot("ゴミ箱タップしたときの表示テスト")
   }
   
   //オプションボタン押したときの表示テスト
   func testTapOptionButtonInCreateStageVC() {
      showCreateStageVC()
      app.buttons["CleateStageVC_OptionButton"].tap()
      snapshot("オプションボタン押したときの表示テスト")
   }
   
   //オプションボタン押してHome押したときの表示テスト
   func testTapOptionButtonAndTapHome() {
      showCreateStageVC()
      app.buttons["CleateStageVC_OptionButton"].tap()
      app.buttons["Home"].tap()
      snapshot("オプションボタン押してHome押したときの表示テスト")
   }
   
   //ピースがおかれてないときにFinボタンタップされたときの表示テスト
   func testTapFinFinishCreatePuzzleButton_PiceIsNOTSellected() {
      showCreateStageVC()
      app.buttons["CleateStageVC_FinishCreatePuzzleButton"].tap()
      snapshot("ピースがおかれてないときにFinボタンタップされたときの表示テスト")
   }
  
   
   //ピースのセルをタップしたときの表示テスト
   func testTapPiceCell() {
      showCreateStageVC()
      let random = Int.random(in: 0 ... 3)
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      snapshot("ピースのセルをタップしたときの表示テスト")
   }
   
   //3つのピースのいずれかをタップしたときの表示テスト
   func testTap3Pice() {
      showCreateStageVC()
      let random = Int.random(in: 0 ... 3)
      let imageRandom = Int.random(in: 0 ... 2)
      let imageRandomArray = ["GreenPiceImageView", "BluePiceImageView", "RedPiceImageView"]
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      //ランダムに表示してタップ
      app.images[imageRandomArray[imageRandom]].tap()
      snapshot("3つのピースのいずれかをタップしたときの表示テスト")
   }
   
   //ピースを一個をゴミ箱に入れたときの表示テスト
   func testAPiceAndTrashPice() {
      showCreateStageVC()
      let trash = app.images["CleateStageVC_TrashImageView"]
      let imageRandom = Int.random(in: 0 ... 2)
      let imageRandomArray = ["GreenPiceImageView", "BluePiceImageView", "RedPiceImageView"]
      let random = Int.random(in: 0 ... 3)
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      //ランダムに表示してタップ
      let image = app.images[imageRandomArray[imageRandom]]
      image.tap()
      image.press(forDuration: 0.4, thenDragTo: trash)

      snapshot("ピースをゴミ箱においた後。")
   }
   
   
   
}
