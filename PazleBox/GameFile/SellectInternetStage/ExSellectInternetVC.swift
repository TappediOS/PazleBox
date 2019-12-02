//
//  ExSellectInternetVC.swift
//  PazleBox
//
//  Created by jun on 2019/12/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

//データを取得するExtention集
extension SellectInternetStageViewController {
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
   
   
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [[Contents]] {
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
      
      let refID = StageDic["documentID"] as! String
      let playCount = StageDic["PlayCount"] as! Int
      let reviewAve = StageDic["ReviewAve"] as! CGFloat
      
      stageInfo.RefID = refID
      stageInfo.PlayCount = playCount
      stageInfo.ReviewAve = reviewAve
      
      print("\nstageInfo = {")
      print("  RefId = \(stageInfo.RefID)")
      print("  PlayCount = \(stageInfo.PlayCount)")
      print("  ReviewAve = \(stageInfo.ReviewAve)")
      print("}\n")
      
      return stageInfo
   }
}

