//
//  SellectCreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class SellectCreateStageViewController: UIViewController {
   
   let SavedStageDataBase = UserCreateStageDataBase()
   var MaxDataNumInDB: Int = 0
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitSavedStageDataFromDB()
   }
   
   private func InitSavedStageDataFromDB() {
      MaxDataNumInDB = SavedStageDataBase.GetMAXDataNumOfDataBaseDataCount()
   }
}
