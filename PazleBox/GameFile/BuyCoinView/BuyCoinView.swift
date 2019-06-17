//
//  BuyCoinView.swift
//  PazleBox
//
//  Created by jun on 2019/06/17.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit

class BuyCoinView: UIView {
   
   var Buy200CoinButton: Buy200CoinsButton?
   var Buy650CoinButton: Buy650CoinsButton?
   var Buy1400CoinButton: Buy1400CoinsButton?
   
   var ViewH: CGFloat = 0
   var ViewW: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      InitViewSize()
      InitBuy200CoinButton()
      InitBuy650CoinButton()
      InitBuy1400CoinButton()
   }
   
   private func InitViewSize() {
      ViewH = self.frame.height
      ViewW = self.frame.width
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   
   private func InitBuy200CoinButton(){
      let Frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      Buy200CoinButton = Buy200CoinsButton(frame: Frame)
      self.addSubview(Buy200CoinButton!)
   }
   
   private func InitBuy650CoinButton(){
      let Frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      Buy650CoinButton = Buy650CoinsButton(frame: Frame)
      self.addSubview(Buy650CoinButton!)
   }
   
   private func InitBuy1400CoinButton(){
      let Frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
      Buy1400CoinButton = Buy1400CoinsButton(frame: Frame)
      self.addSubview(Buy1400CoinButton!)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
