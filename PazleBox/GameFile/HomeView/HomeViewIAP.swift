//
//  HomeViewIAP.swift
//  PazleBox
//
//  Created by jun on 2019/06/15.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SCLAlertView
import SwiftyStoreKit
import Firebase

//課金処理の関数はここに書くよ
extension HomeViewController {
   
   //リストア完了した時にViewを表示する関数
   private func CompleateRestore() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         print("tap")
         
      }
      ComleateView.showSuccess(NSLocalizedString("Passed.", comment: ""), subTitle: "Restore successful")
   }
   
   //課金が完了した時に呼ばれる関数
   private func CompleateBuyRemoveADS() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         print("tap")
         self.LockPurchasButton = false
      }
      ComleateView.showSuccess(NSLocalizedString("Passed.", comment: ""), subTitle: "Purchase complete")
   }

   //MARK:- パーチャスボタンを押した時の処理
   func purchase(PRODUCT_ID:String){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(_):
            //購入成功
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "BuyRemoveAd")
            print("購入成功！")
            print("購入フラグを　\(defaults.bool(forKey: "BuyRemoveAd"))　に変更しました")
            self.CompleateBuyRemoveADS()
            
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID)
         case .error(_):
            //購入失敗
            print("purchaseエラー")
            self.LockPurchasButton = false
         }
      }
   }
   
   //購入の検証をする関数
   func verifyPurchase(PRODUCT_ID:String){
      let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: SECRET_CODE)
      SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
         switch result {
         case .success(let receipt):
            let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: PRODUCT_ID, inReceipt: receipt)
            switch purchaseResult {
            case .purchased:
               print("購入の検証 成功")
               self.LockPurchasButton = false
               
            case .notPurchased:
               //リストアの失敗
               print("購入の検証 失敗")
               self.LockPurchasButton = false
            }
         case .error:
            //エラー
            print("verifyPurchaseエラー")
            self.LockPurchasButton = false
            
         }
      }
   }
   
   
   //購入ボタンを押した時の処理
   @objc func tapparchas(sender: UIButton) {
      
      //すでに押されてたら帰る
      if LockPurchasButton == true {
         return
      }
      LockPurchasButton = true
      GameSound.PlaySoundsTapButton()
      Analytics.logEvent("TapParchasHomeView", parameters: nil)
      purchase(PRODUCT_ID: IAP_PRO_ID)
   }
   
   //リストアボタンを押した時の処理
   @objc func restore(sender: UIButton) {
      GameSound.PlaySoundsTapButton()
      SwiftyStoreKit.restorePurchases(atomically: true) { results in
         if results.restoreFailedPurchases.count > 0 {
            //リストアに失敗
            print("リストアに失敗")
         }
         else if results.restoredPurchases.count > 0 {
            print("リストアに成功")
            //購入成功
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "BuyRemoveAd")
            print("リストアに成功しました")
            print("購入フラグを　\(defaults.bool(forKey: "BuyRemoveAd"))　に変更しました")
            self.CompleateRestore()
         }
         else {
            print("リストアするものがない")
            print("Restorボタン押したけどなんも買ってないパターン")
         }
      }
   }
   
   
   //課金する商品情報を取得する
   func  CheckIAPInfomation() {
      SwiftyStoreKit.retrieveProductsInfo([IAP_PRO_ID]) { result in
         if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            print("Product: \(product.localizedDescription), price: \(priceString)")
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
