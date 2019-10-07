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
      
      let ImageData = SavedStageDataBase.GetImageDataFromDataNumberASNSData(DataNum: 0)
      
      
      
      let ImageView = UIImageView(frame: CGRect(x: 30, y: 200, width: 300, height: 450))
      
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         ImageView.image = Image
         
         view.addSubview(ImageView)
      }
      
   }
}
