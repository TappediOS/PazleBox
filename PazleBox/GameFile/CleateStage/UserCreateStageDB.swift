//
//  UserCreateStageDB.swift
//  PazleBox
//
//  Created by jun on 2019/10/06.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import RealmSwift

class PiceInfo: Object {
   @objc dynamic var PiceW = 0
   @objc dynamic var PiceH = 0
   @objc dynamic var ResX = 0
   @objc dynamic var ResY = 0
   @objc dynamic var PiceName: String = ""
   @objc dynamic var PiceColor: String = ""
}

class FieldYInfo: Object {
   @objc dynamic var X0 = 0
   @objc dynamic var X1 = 0
   @objc dynamic var X2 = 0
   @objc dynamic var X3 = 0
   @objc dynamic var X4 = 0
   @objc dynamic var X5 = 0
   @objc dynamic var X6 = 0
   @objc dynamic var X7 = 0
   @objc dynamic var X8 = 0
}

class UserCreateStageData: Object{
   //@objc dynamic var StageArray: [[Int]] = Array()
   @objc dynamic var MaxPiceNum: Int = 0
   @objc dynamic var ImageData: NSData? = nil
   
   let Pices = List<PiceInfo>()
   let FieldY = List<FieldYInfo>()
}

class UserCreateStageDataBase {
   let realm = try! Realm()
   let CleanArray = CleanCheckStage()
   
   public func AddStage(StageArrayForContents: [[Contents]], MaxPiceNum: Int, PiceArry: [PiceImageView], ImageData: NSData?) {
      var StageArray: [[Int]] = Array()
      StageArray = CleanArray.FinIntArray
      
      
      print()
      
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
      
      
      let AddData = UserCreateStageData()
      //AddData.StageArray = StageArray
      AddData.MaxPiceNum = MaxPiceNum
      AddData.ImageData = ImageData
      
      for Pice in PiceArry {
         let UsePice = PiceInfo()
         UsePice.PiceW = Pice.PiceWideNum
         UsePice.PiceH = Pice.PiceHeightNum
         UsePice.ResX = Pice.PositionX!
         UsePice.ResY = Pice.PositionY!
         print("PiceName = \(Pice.selfName.pregReplace(pattern: "(Green|Blue|Red)", with: ""))")
         print("Color    = \(Pice.selfName.pregReplace(pattern: "[0-9]+p[0-9]+", with: ""))")
         UsePice.PiceName = Pice.selfName.pregReplace(pattern: "(Green|Blue|Red)", with: "")
         UsePice.PiceColor = Pice.selfName.pregReplace(pattern: "[0-9]+p[0-9]+", with: "")
         AddData.Pices.append(UsePice)
      }
      
      for x in 0 ... 11 {
         let UseFieldInfo = FieldYInfo()
         for y in 0 ... 8 {
            if StageArrayForContents[11 - x][y] == .In {
               switch y {
               case 0:
                  UseFieldInfo.X0 = 1
               case 1:
                  UseFieldInfo.X1 = 1
               case 2:
                  UseFieldInfo.X2 = 1
               case 3:
                  UseFieldInfo.X3 = 1
               case 4:
                  UseFieldInfo.X4 = 1
               case 5:
                  UseFieldInfo.X5 = 1
               case 6:
                  UseFieldInfo.X6 = 1
               case 7:
                  UseFieldInfo.X7 = 1
               case 8:
                  UseFieldInfo.X8 = 1
               default:
                  fatalError()
               }
            }
         }
         print(UseFieldInfo)
         AddData.FieldY.append(UseFieldInfo)
      }
      

      try! realm.write {
         realm.add(AddData)
         print(AddData)
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
