//
//  ExCreateStage.swift
//  PazleBox
//
//  Created by jun on 2019/10/21.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension CleateStageViewController {
   func InitRedFlame1_1() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 1
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
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
      print(Flame)
      BlueFlame1_1 = Flame
   }
   
   
   
   
   
   func InitRedFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      RedFlame2_3 = Flame
   }
   func InitGreenFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      print(Flame)
      GreenFlame2_3 = Flame
   }
   func InitBlueFlame2_3() {
      let PiceH = OnPiceView.frame.height / 10 * 8
      let PiceW = PiceH * 2 / 3
      let PiceY = OnPiceView.frame.height / 10 * 1
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      print(Flame)
      BlueFlame2_3 = Flame
   }
   
   
   
   
   
   func InitRedFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 6
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 2
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      RedFlame3_2 = Flame
   }
   func InitGreenFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 6
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 2
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      GreenFlame3_2 = Flame
   }
   func InitBlueFlame3_2() {
      let PiceH = OnPiceView.frame.height / 10 * 7
      let PiceW = PiceH * 3 / 2
      let PiceY = OnPiceView.frame.height / 10 * 1.5
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      BlueFlame3_2 = Flame
   }
   
   
   
   
   
   func InitRedFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 1 + PiceW * 0

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      RedFlame4_3 = Flame
   }
   func InitGreenFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 2 + PiceW * 1

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      GreenFlame4_3 = Flame
   }
   func InitBlueFlame4_3() {
      let PiceH = OnPiceView.frame.height / 14 * 8
      let PiceW = PiceH * 4 / 3
      let PiceY = OnPiceView.frame.height / 14 * 3
      let PicePedding = (OnPiceView.frame.width - PiceW * 3) / 4
      let PiceX = PicePedding * 3 + PiceW * 2

      let Flame = CGRect(x: OnPiceView.frame.minX + PiceX, y: OnPiceView.frame.minY + PiceY, width: PiceW, height: PiceH)
      
      print(Flame)
      BlueFlame4_3 = Flame
   }
}
