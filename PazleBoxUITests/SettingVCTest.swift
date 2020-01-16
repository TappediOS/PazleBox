//
//  SettingVCTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class SettingVCTest: XCTestCase {
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
   
   
   func showSettingVC() {
      app.tabBars.otherElements["tabBar_Setting"].tap()
   }
   
   //UserInfoCellをタプしたときの表示テスト
   func testTapUserInfoCell() {
      showSettingVC()
      app.tables.cells.element(boundBy: 0).tap()
      snapshot("UserInfoCellをタップしたときの画面")
   }
   
   //UserInfoCellをタプしたときの表示テスト
   func testGameCenterCell() {
      showSettingVC()
      app.tables.cells.element(boundBy: 1).tap()
      snapshot("GameCenterCellをタップしたときの画面")
   }
   
   //AppReviewCellをタプしたときの表示テスト
   func testTapAppReviewCell() {
      showSettingVC()
      app.tables.cells.element(boundBy: 4).tap()
      snapshot("AppReviewCellをタップしたときの画面")
   }
   
   //ContactUsCellがタップできるかのテスト
   func testTapContactUsCell() {
      showSettingVC()
      let ContactUsCell = app.tables.cells.element(boundBy: 5)
      XCTAssertTrue(ContactUsCell.isEnabled)
   }
   
   //LicensesCellがタップできるかのテスト
   func testTapLicensesCell() {
      showSettingVC()
      let LicensesCell = app.tables.cells.element(boundBy: 6)
      XCTAssertTrue(LicensesCell.isEnabled)
      app.terminate()
   }
}
