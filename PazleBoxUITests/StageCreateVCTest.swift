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
   
   //作ってみるとき
   func testCreateStage_2_InCreateStageVC() {
      showCreateStageVC()
      let random = Int.random(in: 0 ... 3)
      let imageRandom = Int.random(in: 0 ... 2)
      let imageRandomArray = ["GreenPiceImageView", "BluePiceImageView", "RedPiceImageView"]
      let finButton = app.buttons["CleateStageVC_FinishChouseResPuzzleButton"]
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      

      
      let imageView = app.images["GreenPiceImageView"]
      
      imageView.tap()
      
      app.buttons["CleateStageVC_FinishCreatePuzzleButton"].tap()
      snapshot("１回ボタン押したとき")
      
      let finButton = app.buttons["CleateStageVC_FinishChouseResPuzzleButton"]
      
      
      imageView.press(forDuration: 0.5, thenDragTo: BackTile)
      
      snapshot("初期位置に移動したとき")
      
     
      
   }
}
