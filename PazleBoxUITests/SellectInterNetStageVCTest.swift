//
//  SellectInterNetStageVCTest.swift
//  PazleBoxUITests
//
//  Created by jun on 2020/01/12.
//  Copyright © 2020 jun. All rights reserved.
//

import XCTest

class SellectInterNetStageVCTest: XCTestCase {
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
   
   func showSellectCreateStageVC() {
       app.buttons["CreateHomeVC_InternetUsersStageButton"].tap()
   }
   
   //存在してたらtrue
   func collectionViewCellCount() -> Int {
      return app.collectionViews["SellectInternetStageVC_StageCollectionView"].cells.count
   }
}
