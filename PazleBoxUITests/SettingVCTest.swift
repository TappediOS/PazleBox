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
       // Put teardown code here. This method is called after the invocation of each test method in the class.
   }
   
   
   func showSettingVC() {
      app.tabBars.otherElements["tabBar_Setting"].tap()
   }
   
   //UserInfoCellをタプしたときの表示テスト
   func testTapUserInfoCell() {
      showSettingVC()
      app.tables.cells.element(boundBy: 0).tap()
      snapshot("UserInfoをタップしたときの画面")
   }
   
}
