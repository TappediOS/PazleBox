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
      self.Play3DtouchSuccess()
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         print("tap")
      }
      ComleateView.showSuccess(NSLocalizedString("Passed.", comment: ""), subTitle: "Restore successful")
   }
     
   //課金が完了した時に呼ばれる関数
   private func CompleateBuyPiceSet() {
      self.Play3DtouchSuccess()
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
      let tmp = 1
      print("--------- Userの課金状況 ------------")
      print("　広告削除の購入: \(defaults.bool(forKey: "BuyRemoveAd"))")
      print("PiceSet\(String(tmp))の購入: \(defaults.bool(forKey: DefaultsKey + "1"))")
      print("PiceSet\(String(tmp+1))の購入: \(defaults.bool(forKey: DefaultsKey + "2"))")
      print("PiceSet\(String(tmp+2))の購入: \(defaults.bool(forKey: DefaultsKey + "3"))")
      print("PiceSet\(String(tmp+3))の購入: \(defaults.bool(forKey: DefaultsKey + "4"))")
      print("--------- Userの課金状況 ------------")
   }

   //MARK:- パーチャスボタンを押した時の処理
   func purchase(PRODUCT_ID:String){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(let product):
            //購入成功
            let defaults = UserDefaults.standard
            let DafaultsKey = "BuyPiceSet" + String(self.PiceShopTag)
            defaults.set(true, forKey: DafaultsKey)
            print("購入成功！")
            print("プロダクトID: \(product.productId)")
            print("トランザクション終了させるべきか: \(product.needsFinishTransaction)")
            print("\(DafaultsKey)　の購入フラグを　\(defaults.bool(forKey: DafaultsKey))　に変更しました")
            self.ShowUsersBuyPiceSet()
            self.CompleateBuyPiceSet()
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID)
         case .error(let error):
            //購入失敗
            print("purchaseエラー")
            self.LockPurchasButton = false
            self.Play3DtouchError()
            self.ShowErrorPurchasePiceSet(error: error)
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
            case .purchased(let RecieptItem):
               print("購入の検証 成功")
               print("購入しているアイテム: \(RecieptItem.productId)")
               self.LockPurchasButton = false
                 
            case .notPurchased:
               //リストアの失敗
               print("購入の検証 失敗")
               self.LockPurchasButton = false
               self.Play3DtouchError()
            }
         case .error(let error):
            //エラー
            print("verifyPurchaseエラー")
            self.LockPurchasButton = false
            self.Play3DtouchError()
            print((error as NSError).localizedDescription)
         }
      }
   }
   
   private func ShowErrorPurchasePiceSet(error: SKError) {
      switch error.code {
      case .unknown: print("Unknown error. Please contact support")
      case .clientInvalid: print("Not allowed to make the payment")
      case .paymentCancelled: break
      case .paymentInvalid: print("The purchase identifier was invalid")
      case .paymentNotAllowed: print("The device is not allowed to make the payment")
      case .storeProductNotAvailable: print("The product is not available in the current storefront")
      case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
      case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
      case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
      default: print((error as NSError).localizedDescription)
      }
   }
}
