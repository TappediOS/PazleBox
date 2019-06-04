//
//  NoAdsButton.swift
//  PazleBox
//
//  Created by jun on 2019/06/02.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import FlatUIKit
import SwiftyStoreKit
import SCLAlertView
import Firebase

class NoAdsButton: FUIButton {
   
   //この2つは課金で使う
   private let IAP_PRO_ID = "NO_ADS"
   private let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   var LockPurchasButton = false
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      CheckIAPInfomation()
      
      InitSelf()
      
      
      
   }
   
   private func InitSelf() {
      self.setTitle(NSLocalizedString("No Ads", comment: ""), for: UIControl.State.normal)
      self.buttonColor = UIColor.turquoise()
      self.shadowColor = UIColor.greenSea()
      self.shadowHeight = 3.0
      self.cornerRadius = 6.0
      self.titleLabel?.font = UIFont.boldFlatFont(ofSize: 50)
      self.titleLabel?.adjustsFontSizeToFitWidth = true
      self.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      self.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      self.addTarget(self, action: #selector(self.TapNoAdsButton(_:)), for: UIControl.Event.touchUpInside)
   }
   
   private func CompleateBuyRemoveADS() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         print("tap")
         
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
            self.LockPurchasButton = true
            
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID)
         case .error(_):
            //購入失敗
            print("purchaseエラー")
            self.LockPurchasButton = true
         }
      }
   }
   
   func verifyPurchase(PRODUCT_ID:String){
      let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: SECRET_CODE)
      SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
         switch result {
         case .success(let receipt):
            let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: PRODUCT_ID, inReceipt: receipt)
            switch purchaseResult {
            case .purchased:
               //               let defaults = UserDefaults.standard
               //               defaults.set(true, forKey: "BuyRemoveAd")
               //               print("購入成功！")
               //
               //               print("購入フラグを　\(defaults.bool(forKey: "BuyRemoveAd"))　に変更しました")
               print("購入の検証 成功")
               
            case .notPurchased:
               //リストアの失敗
               print("購入の検証 失敗")
            }
         case .error:
            //エラー
            print("verifyPurchaseエラー")
            
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
   
   
   @objc func TapNoAdsButton(_ sender: FUIButton) {
      
      if LockPurchasButton == true { return }
      
      self.LockPurchasButton = true
      
       Analytics.logEvent("TapNoAdsInClearView", parameters: nil)
       purchase(PRODUCT_ID: IAP_PRO_ID)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
