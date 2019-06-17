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
   
   let UsersCoin = GameCoins()
   
   func purchase(PRODUCT_ID:String, sharedSecret: String, ProductValue: Int){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(_):
            //購入成功
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID, sharedSecret: sharedSecret)
         case .error(_):
            //購入失敗
            print("購入失敗")
            NotificationCenter.default.post(name: .UnLockBuyCoinButton, object: nil, userInfo: nil)
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
               NotificationCenter.default.post(name: .UnLockBuyCoinButton, object: nil, userInfo: nil)
            case .notPurchased:
               //リストアの失敗
               print("購入の検証の失敗")
               NotificationCenter.default.post(name: .UnLockBuyCoinButton, object: nil, userInfo: nil)
            }
         case .error:
            //エラー
            print("購入の懸賞での失敗")
            NotificationCenter.default.post(name: .UnLockBuyCoinButton, object: nil, userInfo: nil)
         }
      }
   }
   
   func  CheckIAPInfomation(ProductID: String) {
      SwiftyStoreKit.retrieveProductsInfo([ProductID]) { result in
         if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            print("\n ---- Product Infomation ----")
            print("Product: \(product.localizedDescription), price: \(priceString)\n")
         }
         else if let invalidProductId = result.invalidProductIDs.first {
            print("Invalid product identifier: \(invalidProductId)")
         }
         else {
            print("Error: \(String(describing: result.error))")
         }
      }
   }
}
