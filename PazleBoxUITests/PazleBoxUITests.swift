//
//  PazleBoxUITests.swift
//  PazleBoxUITests
//
//  Created by jun on 2019/09/29.
//  Copyright © 2019 jun. All rights reserved.
//

import XCTest

class PazleBoxUITests: XCTestCase {

    override func setUp() {
      continueAfterFailure = false
      let app = XCUIApplication()
      setupSnapshot(app)
      app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
   //TopVCの表示テスト
   func testTopVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      snapshot("TopVC")
   }
   
   //contact us button　押したときにちゃんと表示されるかのテスト
   func testTapContactUsButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_ContactusButton"].tap()
      snapshot("TapContactUsButton")
   }
   
   //ShowRankingButton押したときのテスト
   func testTapShowRankingViewButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_ShowRankingViewButton"].tap()
      snapshot("TapShowRankingButton")
   }
   
   //CreateHomeVCの表示テスト
   func testCreateHomeVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      snapshot("HomeVC")
   }
   
   //CreateStageVCの表示テスト
   func testCreateStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_CreateStageButton"].tap()
      snapshot("CreateStageVC")
   }
   
   //CreateStageVCでCollectionViewの表示テスト
   func testShowInternetViewController() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_InternetUsersStageButton"].tap()
      snapshot("show Internet vc")
   }
   
   //CreateStageVCでCollectionView cell をタップしたときの表示テスト
   func testTapInternetViewControllerCell() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_InternetUsersStageButton"].tap()
      let cell = app.collectionViews["SellectInternetStageVC_StageCollectionView"].cells.element(boundBy: 2)
      cell.tap()
      snapshot("tap cell internet vc")
   }
   
   
   
   //CreateStageVCでCollectionView cell をタップしたときの表示テスト
   func testTapCollectionViewCell_2_InCreateStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_CreateStageButton"].tap()
      let cell = app.collectionViews["CleateStageVC_collectionView"].cells.element(boundBy: 2)
      cell.tap()
      snapshot("TapCellInCreateStageVC")
   }
   
   //ゴミ箱タップしたときの表示テスト
   func testTapTrashImageViewInCreateStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_CreateStageButton"].tap()
      app.images["CleateStageVC_TrashImageView"].tap()
      snapshot("TapTrashImageView")
   }
   
   //オプションボタン押したときの表示テスト
   func testTapOptionButtonInCreateStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_CreateStageButton"].tap()
      app.buttons["CleateStageVC_OptionButton"].tap()
      snapshot("TapOptionButton")
   }

   //ピースがおかれてないときにFinボタンタップされたときの表示テスト
   func testTapFinFinishCreatePuzzleButton_PiceIsNOTSellected_InCreateStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_CreateStageButton"].tap()
      app.buttons["CleateStageVC_FinishCreatePuzzleButton"].tap()
      snapshot("TapFinFinishCreatePuzzleButton")
   }
   
   //SellectStageVCの表示テスト
   func testSellectStageVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_SellectStageButton"].tap()
      snapshot("SellectStageVC")
   }
   
   //sellectVCでcell をタップしたときの表示テスト
   func testTapSellectViewControllerCell() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_SellectStageButton"].tap()
      let cell = app.collectionViews["SellectCreateStageVC_StageCollectionView"].cells.element(boundBy: 2)
      cell.tap()
      snapshot("tap cell internet vc")
   }
   
   //BackHomeButton押したときにちゃんと戻れるかのテスト
   func testCreateHomeVCToTopVCFromBackButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_CreateButton"].tap()
      app.buttons["CreateHomeVC_SellectStageButton"].tap()
      snapshot("CreateHomeVCから戻る前")
      app.buttons["SellectCreateStageVC_BackButton"].tap()
      snapshot("CreateHomeVCから戻った後")
   }
   
   //HomeVCの表示テスト
   func testHomeVC() {
      let app = XCUIApplication()
      app.buttons["TopVC_PlayButton"].tap()
      snapshot("HomeVC")
   }
   
   //EasyButton押された時の表示テスト
   func testTapEasyButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_PlayButton"].tap()
      app.buttons["HomeVC_EasyButton"].tap()
      snapshot("EasyButton")
   }
   
   //NormalButton押された時の表示テスト
   func testTapNormalButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_PlayButton"].tap()
      app.buttons["HomeVC_NormalButton"].tap()
      snapshot("NormalButton")
   }
   
   //HardButton押された時の表示テスト
   func testTapHardButton() {
      let app = XCUIApplication()
      app.buttons["TopVC_PlayButton"].tap()
      app.buttons["HomeVC_HardButton"].tap()
      snapshot("HardButton")
   }

   
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
