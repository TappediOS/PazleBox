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
   func testCreateStage_2_InCreateStageVC() {
      showCreateStageVC()
      snapshot("ステージ作りのVCの表示テスト")
   }
   
   //ピースのセル(3番目)をタップしたときの表示テスト
   func testTapCollectionViewCell_2_InCreateStageVC() {
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
  
}
