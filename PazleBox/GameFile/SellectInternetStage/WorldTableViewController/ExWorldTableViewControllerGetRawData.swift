//
//  ExWorldTableViewControllerGetRawData.swift
//  PazleBox
//
//  Created by jun on 2020/03/15.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

extension WorldTableViewController {
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [PiceInfo] {
      var PiceArray: [PiceInfo] = Array()
      let MaxPiceNum = StageDic["MaxPiceNum"] as! Int
         
      for tmp in 1 ... MaxPiceNum {
         let PiceInfomation = PiceInfo()
         let PiceInfoName = "PiceInfo" + String(tmp)
         
         let PiceArrayFromDic = StageDic[PiceInfoName] as! Array<Any>

         PiceInfomation.PiceW = PiceArrayFromDic[0] as! Int
         PiceInfomation.PiceH = PiceArrayFromDic[1] as! Int
         PiceInfomation.ResX = PiceArrayFromDic[2] as! Int
         //転置してるから11から引く必要がある
         //ResPownはのYは下から数えるから
         PiceInfomation.ResY = 11 - (PiceArrayFromDic[3] as! Int)
         PiceInfomation.PiceName = PiceArrayFromDic[4] as! String
         PiceInfomation.PiceColor = PiceArrayFromDic[5] as! String
         
         PiceArray.append(PiceInfomation)
      }
      return PiceArray
   }
      
      
   func GetStageArrayFromDataBase(StageDic: [String: Any]) -> [[Contents]] {
      var StageArry: [[Contents]] = Array()
      
      //Field1 から　Field12 まで回す
      for tmp in 1 ... 12 {
         var StageXInfo: [Contents] = Array()
         let FieldName = "Field" + String(tmp)
         //FieldXの配列内容をInt型で取得
         //[0, 1, 1, 0, 1, 1, 0] みたいな
         let Field_tmp_Array = StageDic[FieldName] as! Array<Int>
         
         //それをforで回してIn Outを代入する
         for field in Field_tmp_Array {
            if field == 0 {
               StageXInfo.append(Contents.Out)
            }else{
               StageXInfo.append(Contents.In)
            }
         }
         //Contents型を配列に保存
         StageArry.append(StageXInfo)
      }
      
      return StageArry
   }
      
      
   func GetPlayStageInfoFromDataBase(StageDic: [String: Any]) -> PlayStageRefInfo {
      var stageInfo = PlayStageRefInfo()
      
      let addUser = StageDic["addUser"] as! String
      let refID = StageDic["documentID"] as! String
      let playCount = StageDic["PlayCount"] as! Int
      let reviewCount = StageDic["ReviewCount"] as! Int
      let reviewAve = StageDic["ReviewAve"] as! CGFloat
      
      stageInfo.RefID = "users/" + addUser + "/Stages/" + refID
      stageInfo.PlayCount = playCount
      stageInfo.ReviewCount = reviewCount
      stageInfo.ReviewAve = reviewAve
      
      return stageInfo
   }
      
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetRawData(document: DocumentSnapshot) -> ([String: Any]) {
      var StageData: [String: Any] =  ["documentID": document.documentID]
      var maxPiceNum: Int = 1
      var addUser = ""
      
      if let value = document["ReviewAve"] as? CGFloat {
            StageData.updateValue(value, forKey: "ReviewAve")
      }
      
      if let value = document["PlayCount"] as? Int {
         StageData.updateValue(value, forKey: "PlayCount")
      }
      
      if let value = document["ReviewCount"] as? Int {
         StageData.updateValue(value, forKey: "ReviewCount")
      }
      
      if let value = document["StageTitle"] as? String {
         StageData.updateValue(value, forKey: "StageTitle")
      } else {
         StageData.updateValue("Nothing", forKey: "StageTitle")
      }
      
      if let userName = document["addUser"] as? String {
         StageData.updateValue(userName, forKey: "addUser")
         addUser = userName
      }
      
      if let value = document["addUserName"] as? String {
         StageData.updateValue(value, forKey: "addUserName")
      }
      
      if let value = document["addUsersProfileImageURL"] as? String {
         StageData.updateValue(value, forKey: "addUsersProfileImageURL")
      }
      
      if let value = document["FcmToken"] as? String {
         StageData.updateValue(value, forKey: "FcmToken")
      }
      
      if let value = document["StageCommentUid"] as? String {
         StageData.updateValue(value, forKey: "StageCommentUid")
      }
      
      if let value = document["StageID"] as? String {
         StageData.updateValue(value, forKey: "StageID")
      }
      
      if let value = document["addDate"] as? Timestamp {
         let date: Date = value.dateValue()
         
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         StageData.updateValue((dataAsString), forKey: "addDate")
      }
         
      if let value = document["MaxPiceNum"] as? Int {
         StageData.updateValue(value, forKey: "MaxPiceNum")
         maxPiceNum = value
      }
         
      if let value = document["ImageData"] as? Data {
         StageData.updateValue(value, forKey: "ImageData")
      }
      
      for tmp in 1 ... 12 {
         let FieldName = "Field" + String(tmp)
         if let value = document[FieldName] as? Array<Int> {
            StageData.updateValue(value, forKey: FieldName)
         }
      }
      
      for tmp in 1 ... maxPiceNum {
         let PiceName = "PiceInfo" + String(tmp)
         if let value = document[PiceName] as? Array<Any> {
            StageData.updateValue(value, forKey: PiceName)
         }
      }
      
      return StageData
   }
}



