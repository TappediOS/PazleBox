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
import SCLAlertView
import Crashlytics
import GameKit
import Firebase
import FlatUIKit


class HomeViewController: UIViewController, GKGameCenterControllerDelegate {
   
   private let GameSound = GameSounds()
   
   @IBOutlet weak var EasyButton: FUIButton!
   @IBOutlet weak var NormalButton: FUIButton!
   @IBOutlet weak var HardButton: FUIButton!
   
   var PurchasButton: FUIButton?
   var RestoreButton: FUIButton?
   
   var ShowRankingViewButton: FUIButton?
   let ButtonKey = "TEST"
   
   //この2つは課金で使う
   private let IAP_PRO_ID = "NO_ADS"
   private let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   //MARK: リーダボードID
   let LEADERBOARD_ID = "ClearStageNumLeaderBoard"
   
   var RemorteConfigs: RemoteConfig!
   
   let EasyStageNameKey = "Easy"
   let NormalStageNameKey = "Normal"
   let HardStageNameKey = "Hard"
   
   let EasyStageNameKeyss = "Easy"
   
   let RemoConName = RemoteConfgName()
   let ButtonClorMane = ButtonColorManager()
   
   
   var LockPurchasButton = false
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      CheckIAPInfomation()
      
      InitButton()
      Inittestbutton()
      
      InitShowRankingViewButton()
      
      InitConfig()
      SetUpRemoteConfigDefaults()
      SetEachStageButtonName()
      SetEachButtonColor()
      FetchConfig()
      
      
      
      
      
   }
   
   //MARK:- Remote ConfigのInitするよ-
   //MARK: RemoteConfigのdefaultをセットする
   private func SetUpRemoteConfigDefaults() {
      let defaultsValues = [
         RemoConName.EasyStageButtonName : "Easy Stage" as NSObject,
         RemoConName.NormalStageButtonName : "Normal Stage" as NSObject,
         RemoConName.HardStageButtonName : "Hard Stage" as NSObject,
         
         RemoConName.EasyStageButtonColor : "FlatMint" as NSObject,
         RemoConName.NormalStageButtonColor : "FlatPowerBlue" as NSObject,
         RemoConName.HardStageButtonColor : "FlatWatermelon" as NSObject,
         RemoConName.PurchasStageButtonColor : "FlatSand" as NSObject,
         RemoConName.RestoreStageButtonColor : "FlatSand" as NSObject,
         RemoConName.ShowRankStageButtonColor : "FlatSand" as NSObject
      ]
      
      self.RemorteConfigs.setDefaults(defaultsValues)
   }
   
   //MARK: InitConfigする
   private func InitConfig() {
      self.RemorteConfigs = RemoteConfig.remoteConfig()
      
      //MARK: デベロッパモード　出すときはやめろ
      #if DEBUG
      print("RemoConデバッグモードでいくとよ。")
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: true)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #else
      print("RemoConリリースモードでいくとよ。")
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: false)
      self.RemorteConfigs.configSettings = RemortConfigSetting
      #endif
      
   }
   
   func FetchConfig() {
      
      
      // ディベロッパーモードの時、expirationDurationを0にして随時更新できるようにする。
      let expirationDuration = RemorteConfigs.configSettings.isDeveloperModeEnabled ? 0 : 3600
      print("RemoteConfigのフェッチする間隔： \(expirationDuration)")
      RemorteConfigs.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { [unowned self] (status, error) -> Void in
         guard error == nil else {
            print("Firebase Config フェッチあかん買った")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
            return
         }
         
         print("フェッチできたよ　クラウドからーー")
         self.RemorteConfigs.activateFetched()
         self.SetEachStageButtonName()
         self.SetEachButtonColor()
      }
   }
   
   func SetEachStageButtonName() {
      print("れもこん1 \(String(describing: RemorteConfigs[RemoConName.EasyStageButtonName].stringValue))")
      print("れもこん2 \(String(describing: RemorteConfigs[RemoConName.NormalStageButtonName].stringValue))")
      print("れもこん3 \(String(describing: RemorteConfigs[RemoConName.HardStageButtonName].stringValue))")
      
      EasyButton.setTitle(RemorteConfigs[RemoConName.EasyStageButtonName].stringValue, for: .normal)
      NormalButton.setTitle(RemorteConfigs[RemoConName.NormalStageButtonName].stringValue, for: .normal)
      HardButton.setTitle(RemorteConfigs[RemoConName.HardStageButtonName].stringValue, for: .normal)
   }
   
   private func SetEachButtonColor() {
      EasyButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.EasyStageButtonColor].stringValue!)
      NormalButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.NormalStageButtonColor].stringValue!)
      HardButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.HardStageButtonColor].stringValue!)
      
      PurchasButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.PurchasStageButtonColor].stringValue!)
      RestoreButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.RestoreStageButtonColor].stringValue!)
      ShowRankingViewButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ShowRankStageButtonColor].stringValue!)
      
      EasyButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.EasyStageButtonColor].stringValue!)
      NormalButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.NormalStageButtonColor].stringValue!)
      HardButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.HardStageButtonColor].stringValue!)
      
      PurchasButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.PurchasStageButtonColor].stringValue!)
      RestoreButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.RestoreStageButtonColor].stringValue!)
      ShowRankingViewButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ShowRankStageButtonColor].stringValue!)
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
   
   private func SetUpHomeEachSmallButton(sender: FUIButton) {
      sender.buttonColor = UIColor.turquoise()
      sender.shadowColor = UIColor.greenSea()
      sender.shadowHeight = 3.0
      sender.cornerRadius = 6.0
      sender.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
   
   //ボタンの初期化
   //FIXME:- testbuttonはひどいよ
   func Inittestbutton() {
      PurchasButton = FUIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
      PurchasButton?.setTitle("Purchas", for: .normal)
      PurchasButton?.addTarget(self, action: #selector(self.tapparchas), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: PurchasButton!)
      self.view.addSubview(PurchasButton!)
      
      RestoreButton = FUIButton(frame: CGRect(x: 140, y: 20, width: 100, height: 100))
      RestoreButton?.setTitle("restore", for: .normal)
      RestoreButton?.addTarget(self, action: #selector(self.restore), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: RestoreButton!)
      self.view.addSubview(RestoreButton!)
   }
   
   private func InitShowRankingViewButton() {
      ShowRankingViewButton = FUIButton(frame: CGRect(x: 20, y: 140, width: 100, height: 100))
      ShowRankingViewButton?.setTitle("show rank", for: .normal)
      ShowRankingViewButton?.addTarget(self, action: #selector(self.ShowRankingView), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: ShowRankingViewButton!)
      self.view.addSubview(ShowRankingViewButton!)
   }
   
   
   
   private func CompleateRestore() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         print("tap")
         
      }
      ComleateView.showSuccess(NSLocalizedString("Passed.", comment: ""), subTitle: "Restore successful")
   }
   
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
   
   
   
   @objc func tapparchas(sender: UIButton) {
      
      if LockPurchasButton == true {
         return
      }
      
      LockPurchasButton = true
      Analytics.logEvent("TapParchasHomeView", parameters: nil)
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
            self.CompleateRestore()
         }
         else {
            print("リストアするものがない")
            print("Restorボタン押したけどなんも買ってないパターン")
         }
      }
   }
   
   //MARK:- FlatUIButtonをセットアップ
   private func SetUpSellectStageButton(sender: FUIButton) {
      sender.buttonColor = UIColor.turquoise()
      sender.shadowColor = UIColor.greenSea()
      sender.shadowHeight = 3.0
      sender.cornerRadius = 6.0
      sender.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
   
   //MARK:- ステージボタン3つを初期化
   private func InitButton() {
      SetUpSellectStageButton(sender: EasyButton)
      SetUpSellectStageButton(sender: NormalButton)
      SetUpSellectStageButton(sender: HardButton)
   }
   
   
   //MARK:- Main.storybordでつけたボタンのタッチイベント
   @IBAction func NextViewWithNum(_ sender: UIButton) {
      //遷移先のインスタンス
      //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController
      

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
   
   
   //MARK:- スコアボードビューの表示
   @objc func ShowRankingView() {
      Analytics.logEvent("ShowGameCenter", parameters: nil)
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      self.present(gcView, animated: true, completion: nil)
      
      //Analytics.logEvent("LoadRankingView", parameters: nil)
   }
   
   //MARK:- GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: nil)
   }
   
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}


