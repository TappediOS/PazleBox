//
//  TopTabBarTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class TopTabBarUITest: XCTestCase {
   
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
   
   //起動時のVCの表示テスト
   func testLauncVC() {
      snapshot("起動時のVCの画面")
   }
   
   //tabbarでSettingを押したときの表示テスト
   func testSettingVC() {
      let setting = XCUIApplication().tabBars/*@START_MENU_TOKEN@*/.otherElements["tabBar_Setting"]/*[[".otherElements[\"Setting\"]",".otherElements[\"tabBar_Setting\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      setting.tap()
      snapshot("SettingVCの画面")
   }
   
}
