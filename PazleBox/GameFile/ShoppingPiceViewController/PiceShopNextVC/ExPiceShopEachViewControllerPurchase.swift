//
//  ExPiceShopEachViewControllerPurchase.swift
//  PazleBox
//
//  Created by jun on 2020/03/12.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStoreKit
import SCLAlertView
import TapticEngine
import Firebase

extension PiceShopEachViewController {
   //リストア完了した時にViewを表示する関数
   func CompleateRestore() {
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
   
   private func ShowUsersBuyPiceSet() {
      let defaults = UserDefaults.standard
      let DefaultsKey = "BuyPiceSet"
      print("--------- Userの課金状況 ------------")
      print("　広告削除の購入  \(defaults.bool(forKey: "BuyRemoveAd"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "1"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "2"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "3"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "4"))")
      print("--------- Userの課金状況 ------------")
   }

   //MARK:- パーチャスボタンを押した時の処理
   func purchase(PRODUCT_ID:String){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(_):
            //購入成功
            let defaults = UserDefaults.standard
            let DafaultsKey = "BuyPiceSet" + String(self.PiceShptTag)
            defaults.set(true, forKey: DafaultsKey)
            print("購入成功！")
            print("\(DafaultsKey)　の購入フラグを　\(defaults.bool(forKey: DafaultsKey))　に変更しました")
            self.ShowUsersBuyPiceSet()
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
}
