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
      app.launchArguments.append("--uitesting")
      app.launch()
   }

   override func tearDown() {
      super.tearDown()
   }
}
