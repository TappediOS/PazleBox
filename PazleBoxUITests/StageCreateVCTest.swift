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
   
   //ピース2個置いて，一個をゴミ箱に入れたときの表示テスト
   func testPut2PiceAndTrash1Pice() {
      showCreateStageVC()
      let trash = app.images["CleateStageVC_TrashImageView"]
      let option = app.buttons["CleateStageVC_OptionButton"]
      let finbutton = app.buttons["CleateStageVC_FinishChouseResPuzzleButton"]
      var imageRandom = Int.random(in: 0 ... 2)
      let imageRandomArray = ["GreenPiceImageView", "BluePiceImageView", "RedPiceImageView"]
      var random = Int.random(in: 0 ... 3)
      
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      //ランダムに表示してタップ
      let firstImage = app.images[imageRandomArray[imageRandom]]
      firstImage.tap()
      firstImage.press(forDuration: 1, thenDragTo: finbutton)
      
      random = Int.random(in: 0 ... 3)
      imageRandom = Int.random(in: 0 ... 2)
      app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: random).tap()
      
      let secondImage = app.images[imageRandomArray[imageRandom]]
      secondImage.tap()
      secondImage.press(forDuration: 1, thenDragTo: option)
      
      snapshot("2つのピースを配置したとき")
   }
   

}
