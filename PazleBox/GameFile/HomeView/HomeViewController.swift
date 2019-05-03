//
//  HomeViewController.swift
//  PazleBox
//
//  Created by jun on 2019/03/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import Lottie
import TapticEngine
import SwiftyStoreKit

class HomeViewController: UIViewController {
   
   private let GameSound = GameSounds()
   
   @IBOutlet weak var EasyButton: UIButton!
   @IBOutlet weak var NormalButton: UIButton!
   @IBOutlet weak var HardButton: UIButton!
   
   var testbutton: UIButton?
   var testbuttonRes: UIButton?
   
   private let IAP_PRO_ID = "NO_ADS"
   private let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      CheckIAPInfomation()
      
      InitButton()
      
      
      
      Inittestbutton()
   }
   
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
   
   
   func Inittestbutton() {
      testbutton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
      testbutton?.setTitle("Purchas", for: .normal)
      testbutton?.backgroundColor = .black
      testbutton?.addTarget(self, action: #selector(self.tapparchas), for: .touchDown)
      self.view.addSubview(testbutton!)
      
      testbuttonRes = UIButton(frame: CGRect(x: 140, y: 20, width: 100, height: 100))
      testbuttonRes?.setTitle("restore", for: .normal)
      testbuttonRes?.addTarget(self, action: #selector(self.restore), for: .touchDown)
      testbuttonRes?.backgroundColor = .black
      self.view.addSubview(testbuttonRes!)
   }
   
   
   func purchase(PRODUCT_ID:String){
      SwiftyStoreKit.purchaseProduct(PRODUCT_ID, quantity: 1, atomically: true) { result in
         switch result {
         case .success(_):
            //購入成功
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "BuyRemoveAd")
            print("購入成功！")
            print("購入フラグを　\(defaults.bool(forKey: "BuyRemoveAd"))　に変更しました")
            
            //購入の検証
            self.verifyPurchase(PRODUCT_ID: PRODUCT_ID)
         case .error(_):
            //購入失敗
            print("purchaseエラー")
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
   
   
   
   @objc func tapparchas(sender: UIButton) {
      purchase(PRODUCT_ID: IAP_PRO_ID)
   }
   
   @objc func restore(sender: UIButton) {
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
         }
         else {
            print("リストアするものがない")
            print("Restorボタン押したけどなんも買ってないパターン")
         }
      }
   }
   
   
   
   
   
   private func InitButton() {
      EasyButton.backgroundColor = UIColor.flatLime()
      NormalButton.backgroundColor = UIColor.flatLime()
      HardButton.backgroundColor = UIColor.flatLime()
      
      EasyButton.setTitleColor(UIColor.flatWhite(), for: .normal)
      NormalButton.setTitleColor(UIColor.flatWhite(), for: .normal)
      HardButton.setTitleColor(UIColor.flatWhite(), for: .normal)
   }
   
   
   @IBAction func NextViewWithNum(_ sender: UIButton) {
      //遷移先のインスタンス
      //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController
      
      //ViewController2のtextにtextFieldのテキストを代入

      print("ステージレベルの送信開始")
      switch sender.tag {
      case 1:
         vc2.StageLevel = .Easy
      case 2:
         vc2.StageLevel = .Normal
      case 3:
         vc2.StageLevel = .Hard
      default:
         fatalError()
      }
      print("ステージレベルの送信完了(\(vc2.StageLevel))")
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      
      
      //NavigationControllerを継承したViewControllerを遷移
      print("GameViewControllerを表示します")
      self.view.fadeOut(type: .Normal){ [weak self] in
         self?.present(vc2, animated: false, completion: nil)
         self?.view.fadeIn(type: .Normal)
      }
   }
   
 
   
   private func Play3DtouchLight() {
      TapticEngine.impact.feedback(.light)
      return
   }
   private func Play3DtouchMedium() {
      TapticEngine.impact.feedback(.medium)
      return
   }
   private func Play3DtouchHeavy() {
      TapticEngine.impact.feedback(.heavy)
      return
   }
}


