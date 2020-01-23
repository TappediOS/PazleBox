//
//  UserAgreementVCTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/23.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import XCTest

class UserAgreementVCTest: XCTestCase {
   let app = XCUIApplication()

   override func setUp() {
      continueAfterFailure = false
      let app = XCUIApplication()
      setupSnapshot(app)
      app.launchArguments.append("--uitestingUserAgreement")
      app.launch()
   }

   override func tearDown() {
      super.tearDown()
   }
   
   //利用規約VCの表示テスト
   func testShowUserAgreementVC() {
      snapshot("利用規約VCの表示テスト")
   }
   
   //利用規約ボタンを押した時の表示テスト
   func testTapUserAgreementButton() {
      let button = app.buttons["AgreementButton"]
      XCTAssertTrue(button.isEnabled)
      XCUIDevice.shared.press(.home)
      app.activate()
   }
   
   //利用規約ボタンを押した時の表示テスト
   func testTapPrivacyPolicyButton() {
      let button = app.buttons["PlivacyPolicyButton"]
      XCTAssertTrue(button.isEnabled)
      XCUIDevice.shared.press(.home)
      app.activate()
   }
   
   
   //Acceptを押した時の表示テスト
   func testTapAgreeButton() {
      let button = app.buttons["AgreeButton"]
      XCTAssertTrue(button.isEnabled)
      button.tap()
      snapshot("Acceptを押した時の表示テスト")
   }
   
   //DontAcceptを押した時の表示テスト
   func testTapDontAgreeButton() {
      let button = app.buttons["DontAgreebutton"]
      XCTAssertTrue(button.isEnabled)
      button.tap()
      snapshot("DontAcceptを押した時の表示テスト")
   }
   
   //DontAcceptを押してDoneを押した時の表示テスト
   func testTapDontAgreeAndDoneButton() {
      let AcceptButton = app.buttons["AgreeButton"]
      let DontAcceptButton = app.buttons["DontAgreebutton"]
      XCTAssertTrue(AcceptButton.isEnabled)
      XCTAssertTrue(DontAcceptButton.isEnabled)
      DontAcceptButton.tap()
      let doneButton = app.buttons["Done"]
      XCTAssertTrue(doneButton.isEnabled)
      doneButton.tap()
      snapshot("DontAcceptを押してDoneを押した時の表示テスト")
      XCTAssertTrue(AcceptButton.isEnabled)
      XCTAssertTrue(DontAcceptButton.isEnabled)
   }
}
