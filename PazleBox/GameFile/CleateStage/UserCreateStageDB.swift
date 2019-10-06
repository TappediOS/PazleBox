//
//  UserCreateStageDB.swift
//  PazleBox
//
//  Created by jun on 2019/10/06.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import RealmSwift

struct PiceInfo {
   var PiceW = 0
   var PiceH = 0
   var ResX = 0
   var ResY = 0
   var PiceName: String = ""
   var PiceColor: String = ""
   
}

class UserCreateStageData: Object{
   
   @objc dynamic var StageArray: [[Int]] = Array()
   @objc dynamic var MaxPiceNum: Int = 0
         dynamic var PiceSet: [PiceInfo] = Array()
   @objc dynamic var ImageData: NSData? = nil
}

class UserCreateStageDataBase {
   let realm = try! Realm()
   let CleanArray = CleanCheckStage()
   
   public func AddStage(StageArrayForContents: [[Contents]], MaxPiceNum: Int, PiceArry: [PiceImageView], ImageData: NSData?) {
      var StageArray: [[Int]] = Array()
      StageArray = CleanArray.FinIntArray
      
      for x in 0 ... 11 {
         print()
         for y in 0 ... 8 {
            if StageArrayForContents[11 - x][y] == .Out {
               StageArray[11 - x][y] = 0
               print("\(StageArray[11 - x][y]) ", terminator: "")
            }else{
               StageArray[11 - x][y] = 1
               print("\(StageArray[11 - x][y])  ", terminator: "")
            }
         }
      }
      
      var AllPice: [PiceInfo] = Array()
      
      for Pice in PiceArry {
         var UsePice = PiceInfo()
         UsePice.PiceW = Pice.PiceWideNum
         UsePice.PiceH = Pice.PiceHeightNum
         UsePice.ResX = Pice.PositionX!
         UsePice.ResY = Pice.PositionY!
         print("PiceName = \(Pice.selfName.pregReplace(pattern: "(Green|Blue|Red)", with: ""))")
         print("Color    = \(Pice.selfName.pregReplace(pattern: "[0-9]+p[0-9]+", with: ""))")
         UsePice.PiceName = Pice.selfName.pregReplace(pattern: "(Green|Blue|Red)", with: "")
         UsePice.PiceColor = Pice.selfName.pregReplace(pattern: "[0-9]+p[0-9]+", with: "")
         AllPice.append(UsePice)
      }
      
      
      let AddData = UserCreateStageData()
      AddData.StageArray = StageArray
      AddData.MaxPiceNum = MaxPiceNum
      AddData.PiceSet = AllPice
      AddData.ImageData = ImageData
      
      try! realm.write {
         realm.add(AddData)
      }
   }
   
   public func DeleteCanDoCellInfomation(at index: Int) {
      let result = realm.objects(UserCreateStageData.self)[index]
      print("\(result.MaxPiceNum)の削除を開始します")
      try! realm.write {
         realm.delete(result)
      }
   }

}
