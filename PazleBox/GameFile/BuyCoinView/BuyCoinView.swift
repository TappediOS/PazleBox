//
//  BuyCoinView.swift
//  PazleBox
//
//  Created by jun on 2019/06/17.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import FlatUIKit
import ChameleonFramework

class BuyCoinView: UIView {
   
   var Buy200CoinButton: Buy200CoinsButton?
   var Buy650CoinButton: Buy650CoinsButton?
   var Buy1400CoinButton: Buy1400CoinsButton?
   var BackToHomeButton: FUIButton?
   
   var ViewH: CGFloat = 0
   var ViewW: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   var BackButtonSize: CGFloat = 0
   var BackButtonInternal: CGFloat = 0
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      InitBackGroundColor()
      InitViewSize()
      InitBackToHomeButton()
      InitBuy200CoinButton()
      InitBuy650CoinButton()
      InitBuy1400CoinButton()
   }
   
   private func InitBackGroundColor() {
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
   }
   
   private func InitViewSize() {
      ViewH = self.frame.height
      ViewW = self.frame.width
      FViewW = ViewW / 25
      FViewH = ViewH / 32
      BackButtonSize = ViewW / 5
      BackButtonInternal = BackButtonSize / 5
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
   
   private func InitBackToHomeButton() {
      let FirstX = BackButtonInternal
      let FirstY = BackButtonInternal
      let Frame = CGRect(x: FirstX, y: FirstY, width: BackButtonSize, height: BackButtonSize / 2)
      BackToHomeButton = FUIButton(frame: Frame)
      BackToHomeButton?.setTitle("←", for: UIControl.State.normal)
      BackToHomeButton?.buttonColor = UIColor.greenSea()
      BackToHomeButton?.shadowColor = UIColor.greenSea()
      BackToHomeButton?.shadowHeight = 3.0
      BackToHomeButton?.cornerRadius = 6.0
      BackToHomeButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      BackToHomeButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      BackToHomeButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      BackToHomeButton?.addTarget(self, action: #selector(self.TapBackToHomeButton(_:)), for: UIControl.Event.touchUpInside)
      self.addSubview(BackToHomeButton!)
   }
   
   @objc func TapBackToHomeButton (_ sender: FUIButton) {
      self.fadeOut(type: .Normal){ [weak self] in
         self?.removeFromSuperview()
      }
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
