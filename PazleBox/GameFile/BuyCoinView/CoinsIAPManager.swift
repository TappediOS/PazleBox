//
//  CoinsIAPManager.swift
//  PazleBox
//
//  Created by jun on 2019/06/17.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStoreKit

class CoinIAPManager {
   
   func purchase(PRODUCT_ID:String, sharedSecret: String){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(_):
            //購入成功
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID, sharedSecret: sharedSecret)
         case .error(_):
            //購入失敗
            print("購入失敗")
         }
      }
   }
   
   func verifyPurchase(PRODUCT_ID:String, sharedSecret: String){
      let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
      SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
         switch result {
         case .success(let receipt):
            let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: PRODUCT_ID, inReceipt: receipt)
            switch purchaseResult {
            case .purchased:
               //リストアの成功
               print("購入の検証の成功")
               
            case .notPurchased:
               //リストアの失敗
               print("購入の検証の失敗")
            }
         case .error:
            //エラー
            print("購入の懸賞での失敗")
            
         }
      }
   }
}
