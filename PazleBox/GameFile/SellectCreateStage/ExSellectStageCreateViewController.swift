//
//  ExSellectStageCreateViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/13.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension SellectCreateStageViewController {
   func GetPiceArrayFromPiceList(PiceList: List<PiceInfo>) -> [PiceInfo] {
      var PiceArray: [PiceInfo] = Array()
      for Pice in PiceList {
         let PiceInfomation = PiceInfo()
         PiceInfomation.PiceW = Pice.PiceW
         PiceInfomation.PiceH = Pice.PiceH
         PiceInfomation.ResX = Pice.ResX
         //転置してるから11から引く必要がある
         //ResPownはのYは下から数えるから
         PiceInfomation.ResY = 11 - Pice.ResY
         PiceInfomation.PiceName = Pice.PiceName
         PiceInfomation.PiceColor = Pice.PiceColor
         PiceArray.append(PiceInfomation)
      }
      return PiceArray
   }
   
   func GetPiceArrayFromPiceList(FieldYList: List<FieldYInfo>) -> [[Contents]] {
      var StageArry: [[Contents]] = Array()
      for FieldY in FieldYList {
         var StageXInfo: [Contents] = Array()
         
         if FieldY.X0 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X1 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X2 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X3 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X4 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X5 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X6 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X7 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X8 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         
         StageArry.append(StageXInfo)
      }
      return StageArry
   }
}
