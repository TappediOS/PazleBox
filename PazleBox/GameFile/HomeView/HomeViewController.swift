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
   
   var testbutton: FUIButton?
   var testbuttonRes: FUIButton?
   
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
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      CheckIAPInfomation()
      
      InitButton()
      
      
      InitConfig()
      SetUpRemoteConfigDefaults()
      setDisplayLabel()
      FetchConfig()
      
      
      
      
      Inittestbutton()
      
      InitShowRankingViewButton()
   }
   
   private func SetUpRemoteConfigDefaults() {
      let defaultsValues = [
         "EasyStageNameKey" : "Easy" as NSObject,
         "NormalStageNameKey" : "Normal" as NSObject,
         "HardStageNameKey" : "Hard" as NSObject,
         
         "EasyStageNameKeyss" : "Easy" as NSObject
      ]
      
      self.RemorteConfigs.setDefaults(defaultsValues)
   }
   
   private func InitConfig() {
      self.RemorteConfigs = RemoteConfig.remoteConfig()
      
      //FIXME:- デベロッパモード　出すときはやめろ
      
      let RemortConfigSetting = RemoteConfigSettings(developerModeEnabled: true)
      
      self.RemorteConfigs.configSettings = RemortConfigSetting
      
      
   }
   
   func FetchConfig() {
      // フェッチが終わる前まで表示されるメッセージ
      
      
      // ディベロッパーモードの時、expirationDurationを0にして随時更新できるようにする。
      //let expirationDuration = RemorteConfigs.configSettings.isDeveloperModeEnabled ? 0 : 3600
      RemorteConfigs.fetch(withExpirationDuration: TimeInterval(0)) { [unowned self] (status, error) -> Void in
         guard error == nil else {
            print("Firebase Config フェッチあかん買った")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
            return
         }
         
         print("フェッチできたよ　クラウドからーー")
         self.RemorteConfigs.activateFetched()
         self.setDisplayLabel()
      }
   }
   
   func setDisplayLabel() {
      print("れもこん1 \(String(describing: RemorteConfigs["EasyStageNameKeyss"].stringValue))")
      print("れもこん2 \(String(describing: RemorteConfigs["NormalStageNameKey"].stringValue))")
      print("れもこん3 \(String(describing: RemorteConfigs["HardStageNameKey"].stringValue))")
      
      EasyButton.setTitle(RemorteConfigs["EasyStageNameKeyss"].stringValue, for: .normal)
      NormalButton.setTitle(RemorteConfigs["NormalStageNameKey"].stringValue, for: .normal)
      HardButton.setTitle(RemorteConfigs["HardStageNameKey"].stringValue, for: .normal)
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
      testbutton = FUIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
      testbutton?.setTitle("Purchas", for: .normal)
      testbutton?.addTarget(self, action: #selector(self.tapparchas), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: testbutton!)
      self.view.addSubview(testbutton!)
      
      testbuttonRes = FUIButton(frame: CGRect(x: 140, y: 20, width: 100, height: 100))
      testbuttonRes?.setTitle("restore", for: .normal)
      testbuttonRes?.addTarget(self, action: #selector(self.restore), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: testbuttonRes!)
      self.view.addSubview(testbuttonRes!)
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


