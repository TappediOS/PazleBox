//
//  Buy650CoinsButton.swift
//  PazleBox
//
//  Created by jun on 2019/06/17.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import Firebase
import ChameleonFramework
import SwiftyStoreKit

class Buy650CoinsButton: FUIButton {
   
   let ProductID = IAPCoinID()
   let CoinsIAPMana = CoinIAPManager()
   var LockParchaseButton = false
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.titleLabel?.adjustsFontSizeToFitWidth = true
      self.titleLabel?.adjustsFontForContentSizeCategory = true
      self.buttonColor = UIColor.turquoise()
      self.shadowColor = UIColor.greenSea()
      self.shadowHeight = 3.0
      self.cornerRadius = 6.0
      self.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      self.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      self.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      self.setTitle(NSLocalizedString("650 coins", comment: ""), for: .normal)
      self.addTarget(self, action: #selector(self.TapBuy650CoinsButton), for: .touchUpInside)
      
      CoinsIAPMana.CheckIAPInfomation(ProductID: ProductID.Buy650Coins)
   }
   
   @objc func TapBuy650CoinsButton(sender: FUIButton) {
      if LockParchaseButton {
         print("現在650CoinボタンはLockされています")
         return
      }
      NotificationCenter.default.post(name: .LockBuyCoinButton, object: nil, userInfo: nil)
      CoinsIAPMana.purchase(PRODUCT_ID: ProductID.Buy650Coins, sharedSecret: ProductID.SECRET_CODE)
   }
   

   
   public func LockingParchaseButton() {
      self.LockParchaseButton = true
   }
   
   public func UnLockingParchaseButton() {
      self.LockParchaseButton = false
   }
   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError()
   }
}
