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
import Hero

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
      self.hero.isEnabled = true
      InitBackGroundColor()
      InitViewSize()
      InitBackToHomeButton()
      InitBuy200CoinButton()
      InitBuy650CoinButton()
      InitBuy1400CoinButton()
      InitNotificationCenter()
      

   }
   
   private func InitBackGroundColor() {
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
   }
   
   //MARK: 通知の初期化
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(LockAllBuyCoinButton(notification:)), name: .LockBuyCoinButton, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(UnLockAllBuyCoinButton(notification:)), name: .UnLockBuyCoinButton, object: nil)
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
      BackToHomeButton?.hero.id = "BackButton"
      self.addSubview(BackToHomeButton!)
   }
   
   @objc func TapBackToHomeButton (_ sender: FUIButton) {
      self.fadeOut(type: .Normal){ [weak self] in
         self?.removeFromSuperview()
      }
   }
   
   
   //MARK:- 通知を受け取る関数
   @objc func LockAllBuyCoinButton(notification: Notification) -> Void {
      Buy200CoinButton?.LockingParchaseButton()
      Buy650CoinButton?.LockingParchaseButton()
      Buy1400CoinButton?.LockingParchaseButton()
   }
   
   @objc func UnLockAllBuyCoinButton(notification: Notification) -> Void {
      Buy200CoinButton?.UnLockingParchaseButton()
      Buy650CoinButton?.UnLockingParchaseButton()
      Buy1400CoinButton?.UnLockingParchaseButton()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
