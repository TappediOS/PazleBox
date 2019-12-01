//
//  ExSellectInternetVC.swift
//  PazleBox
//
//  Created by jun on 2019/12/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

//データを取得するExtention集
extension SellectInternetStageViewController {
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [PiceInfo] {
      var PiceArray: [PiceInfo] = Array()
      let MaxPiceNum = StageDic["MaxPiceNum"] as! Int
      
      
      for tmp in 1 ... MaxPiceNum {
         let PiceInfomation = PiceInfo()
         let PiceInfoName = "PiceInfo" + String(tmp)
         
         let PiceArray = StageDic[PiceInfoName] as! Array<Any>
         
         PiceInfomation.PiceW = PiceArray[0] as! Int
         PiceInfomation.PiceH = PiceArray[1] as! Int
         PiceInfomation.ResX = PiceArray[2] as! Int
         //転置してるから11から引く必要がある
         //ResPownはのYは下から数えるから
         PiceInfomation.ResY = 11 - PiceArray[3] as! Int
         PiceInfomation.PiceName = PiceArray[4] as! String
         PiceInfomation.PiceColor = PiceArray[0] as! String
         PiceArray.append(PiceInfomation)
      }
      return PiceArray
   }
   
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [[Contents]] {
      var StageArry: [[Contents]] = Array()
      var StageXInfo: [Contents] = Array()
      
      //Field1 から　Field12 まで回す
      for tmp in 1 ... 12 {
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
}

