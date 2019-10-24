//
//  ExCreateStageDidLayoutSubviews.swift
//  PazleBox
//
//  Created by jun on 2019/10/21.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension CleateStageViewController {
   
   func ReSetUpOnPiceView() {
     let SafeAreaTop: CGFloat = self.view.safeAreaInsets.top
     print("safeareaのトップは　\(SafeAreaTop)")
     let CollectionviewHeight = collectionView.frame.height
     print("CollectionViewの高さは \(CollectionviewHeight)")
     let SafeAndCollectionH = SafeAreaTop + CollectionviewHeight
     self.CanUseAreaHeight = StartBackImageViewY - SafeAndCollectionH
     print("使える高さは \(self.CanUseAreaHeight)")
      
      var ViewPedding: CGFloat = 0
      
      if SafeAreaTop > 40 {
         ViewPedding = 39
      }else{
         ViewPedding = 2
      }
      
      let StartY = SafeAndCollectionH + ViewPedding
      let Height = CanUseAreaHeight - ViewPedding * 2
      
      let Flame = CGRect(x: view.frame.width / 40, y: StartY, width: view.frame.width / 40 * 38, height: Height)
      OnPiceView.frame = Flame
   }
   
   
   func InitRedFlame1_1() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 1
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      RedFlame1_1 = Flame
   }
   func InitGreenFlame1_1() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 1
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      print(Flame)
      GreenFlame1_1 = Flame
   }
   func InitBlueFlame1_1() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 1
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      //print(Flame)
      BlueFlame1_1 = Flame
   }
   
   
   
   
   
   func InitRedFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      RedFlame2_3 = Flame
   }
   func InitGreenFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      //print(Flame)
      GreenFlame2_3 = Flame
   }
   func InitBlueFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      //print(Flame)
      BlueFlame2_3 = Flame
   }
   
   
   
   
   
   func InitRedFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 6
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 2
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      ///print(Flame)
      RedFlame3_2 = Flame
   }
   func InitGreenFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 6
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 2
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      GreenFlame3_2 = Flame
   }
   func InitBlueFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 7
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 1.5
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      BlueFlame3_2 = Flame
   }
   
   
   
   
   
   func InitRedFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      RedFlame4_3 = Flame
   }
   func InitGreenFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      //print(Flame)
      GreenFlame4_3 = Flame
   }
   func InitBlueFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
     // print(Flame)
      BlueFlame4_3 = Flame
   }
   
   
   func SNPOptionButton() {
      OptionButton.snp.makeConstraints{ make in
         let Height:CGFloat = 50
         make.height.equalTo(Height)
         make.width.equalTo(Height)
         make.trailing.equalTo(self.view.snp.trailing).offset(-8)
         if #available(iOS 11, *) {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         } else {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         }
      }
   }
   
   func SNPFinishCreatePuzzleButton() {
      FinishCreatePuzzleButton!.snp.makeConstraints{ make in
         let Height:CGFloat = 55
         let Width:CGFloat = 85
         make.height.equalTo(Height)
         make.width.equalTo(Width)
         make.leading.equalTo(self.view.snp.leading).offset(10)
         if #available(iOS 11, *) {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         } else {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         }
      }
   }
   
   func SNPFinishChouseResPuzzleButton() {
      FinishChouseResPuzzleButton!.snp.makeConstraints{ make in
         let Height:CGFloat = 55
         let Width:CGFloat = 85
         make.height.equalTo(Height)
         make.width.equalTo(Width)
         make.leading.equalTo(self.view.snp.leading).offset(10)
         if #available(iOS 11, *) {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         } else {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         }
      }
   }
   
   func SNPFInfoLabel() {
      InfoLabel.snp.makeConstraints { make in
         let Height:CGFloat = 55
         let Offset:CGFloat = 11
         make.height.equalTo(Height)
         make.leading.equalTo(self.FinishChouseResPuzzleButton!.snp.trailing).offset(Offset)
         make.trailing.equalTo(self.OptionButton.snp.leading).offset(-Offset)
         if #available(iOS 11, *) {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         } else {
            make.top.equalTo(self.collectionView.snp.bottom).offset((CanUseAreaHeight - Height) / 2)
         }
      }
   }
}
