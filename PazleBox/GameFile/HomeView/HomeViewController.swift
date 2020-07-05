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
import FirebaseRemoteConfig
import Firebase
import FirebaseAnalytics
import FlatUIKit
import Hero

class HomeViewController: UIViewController, GKGameCenterControllerDelegate {
   
   @IBOutlet weak var EasyButton: UIButton!
   @IBOutlet weak var NormalButton: UIButton!
   @IBOutlet weak var HardButton: UIButton!
   
   var PurchasButton = UIButton()
   var RestoreButton = UIButton()
   
   var ShowRankingViewButton = UIButton()
   var ContactusButton = UIButton()
   
   
   //StoreButton
   //var GoPiceStoreButton: FUIButton?
   //MARK: リーダボードID
   let LEADERBOARD_ID = "ClearStageNumLeaderBoard"
   
   
   let EasyStageNameKey = "Easy"
   let NormalStageNameKey = "Normal"
   let HardStageNameKey = "Hard"

   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   
   //この2つは課金で使う
   let IAP_PRO_ID = "NO_ADS"
   let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   var LockPurchasButton = false  //ロックされていたらappleのサーバに余計に請求しなくする
   var CanPresentToSegeSellectViewFromHomeView = true
   
   let GameSound = GameSounds()
   
   let HeroID = HeroIDs()
   var BackGroundImageView: BackGroundImageViews?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.hero.isEnabled = true
      
      Analytics.logEvent("showOurStageSellectVC", parameters: nil)
      
      InitViewSize()
      
      CheckIAPInfomation()
      
      InitBackgroundImageView()
      InitButton()
      Inittestbutton()
      InitContactusButton()
      InitShowRankingViewButton()
      //InitGoPiceStoreButton()
      SetUpHeroModifiersForEachSmallButton()
      InitAccessibilityIdentifires()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      //Topに対し音鳴らすように通知
      NotificationCenter.default.post(name: .StartHomeViewBGM, object: nil)
      //HeroIDを元に戻す
      SetUpStageButtonHeroID()
   }
   
   private func InitViewSize() {
      ViewW = self.view.frame.width
      ViewH = self.view.frame.height
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   

   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func  InitAccessibilityIdentifires() {
      EasyButton?.accessibilityIdentifier = "HomeVC_EasyButton"
      NormalButton?.accessibilityIdentifier = "HomeVC_NormalButton"
      HardButton?.accessibilityIdentifier = "HomeVC_HardButton"
      PurchasButton.accessibilityIdentifier = "HomeVC_PurchasButton"
      ContactusButton.accessibilityIdentifier = "HomeVC_ContactusButton"
      ShowRankingViewButton.accessibilityIdentifier = "HomeVC_ShowRankingViewButton"
      RestoreButton.accessibilityIdentifier = "HomeVC_RestoreButton"
   }

   private func SetEachButtonColor() {
      EasyButton.backgroundColor = .systemGreen
      NormalButton.backgroundColor = .systemTeal
      HardButton.backgroundColor = .systemPink
      
      PurchasButton.backgroundColor = UIColor.flatCoffee()
      RestoreButton.backgroundColor = UIColor.flatCoffee()
      ShowRankingViewButton.backgroundColor = UIColor.flatCoffee()
      ContactusButton.backgroundColor = UIColor.flatCoffee()
   }
   
   private func SetUpHomeEachSmallButton(sender: UIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
      sender.layer.cornerRadius = 8.0
      sender.titleLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 16)
      sender.contentVerticalAlignment = .fill
      sender.setTitleColor(.white, for: .normal)
   }
   
   //ボタンの初期化
   func Inittestbutton() {
      PurchasButton = FUIButton(frame: CGRect(x: FViewW * 13, y: FViewH * 22, width: FViewW * 5, height: FViewH * 3))
      PurchasButton.setTitle(NSLocalizedString("No Ads", comment: ""), for: .normal)
      PurchasButton.addTarget(self, action: #selector(self.tapparchas), for: .touchUpInside)
      PurchasButton.hero.id = HeroID.ClearHart3ToHomeView
      SetUpHomeEachSmallButton(sender: PurchasButton)
      self.view.addSubview(PurchasButton)
      
      RestoreButton = FUIButton(frame: CGRect(x: FViewW * 19, y: FViewH * 22, width: FViewW * 5, height: FViewH * 3))
      RestoreButton.setTitle(NSLocalizedString("Restore", comment: ""), for: .normal)
      RestoreButton.addTarget(self, action: #selector(self.restore), for: .touchUpInside)
      RestoreButton.hero.id = HeroID.ClearHart2ToHomeView
      SetUpHomeEachSmallButton(sender: RestoreButton)
      self.view.addSubview(RestoreButton)
   }
   
   private func InitShowRankingViewButton() {
      ShowRankingViewButton = FUIButton(frame: CGRect(x: FViewW * 1, y: FViewH * 22, width: FViewW * 5, height: FViewH * 3))
      ShowRankingViewButton.setTitle(NSLocalizedString("Ranking", comment: ""), for: .normal)
      ShowRankingViewButton.addTarget(self, action: #selector(self.ShowRankingView), for: .touchUpInside)
      ShowRankingViewButton.hero.id = HeroID.GameCenterVC
      ShowRankingViewButton.hero.id = HeroID.ClearHart4ToHomeView
      SetUpHomeEachSmallButton(sender: ShowRankingViewButton)
      self.view.addSubview(ShowRankingViewButton)
   }
   
   private func InitContactusButton() {
      ContactusButton = FUIButton(frame: CGRect(x: FViewW * 7, y: FViewH * 22, width: FViewW * 5, height: FViewH * 3))
      ContactusButton.setTitle(NSLocalizedString("Contact us", comment: ""), for: .normal)
      ContactusButton.addTarget(self, action: #selector(self.ContactUs), for: .touchUpInside)
      ContactusButton.hero.id = HeroID.ClearHart2ToHomeView
      SetUpHomeEachSmallButton(sender: ContactusButton)
      self.view.addSubview(ContactusButton)
   }
   

   //MARK:- コンタクトアスボタン押された時の処理
   @objc func ContactUs() {
      ContactusButton.hero.id = "BackButton"
      GameSound.PlaySoundsTapButton()
      let url = URL(string: "https://forms.gle/mSEq7WwDz3fZNcqF6")
      if let OpenURL = url {
         if UIApplication.shared.canOpenURL(OpenURL){
            Analytics.logEvent("OpenContactUsURL", parameters: nil)
            UIApplication.shared.open(OpenURL)
         }else{
            Analytics.logEvent("CantOpenURL", parameters: nil)
            print("URL nil ちゃうのにひらけない")
         }
      }else{
         Analytics.logEvent("CantOpenURLWithNil", parameters: nil)
         print("URL 開こうとしたらNilやった")
      }
   }
   
   //MARK:- UIButtonのセットアップ
   private func SetUpSellectStageButtons(sender: UIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
      sender.layer.cornerRadius = 8.0
      sender.titleLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 20)
      sender.contentVerticalAlignment = .fill
      sender.setTitleColor(.white, for: .normal)

   }
   
   //MARK:- ステージボタン3つを初期化
   private func InitButton() {
      SetUpSellectStageButtons(sender: EasyButton)
      SetUpSellectStageButtons(sender: NormalButton)
      SetUpSellectStageButtons(sender: HardButton)
      
      SetUpStageButtonHeroID()
      SetUpHeroModifiersForEachStageButton()
      SetUpStageButtonPosition()
      SetEachButtonColor()
   }
   
   //MARK: ステージボタンのHEROIDつける -
   private func SetUpStageButtonHeroID() {
      EasyButton.hero.id = HeroID.BackEasyStage
      NormalButton.hero.id = HeroID.BackNormalStage
      HardButton.hero.id = HeroID.BackHardStage
   }
   
   private func SetUpHeroModifiersForEachStageButton() {
      EasyButton.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 6), y: 0, z: 0)]
      NormalButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 2), y: 0, z: 0)]
      HardButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
   }
   
   private func SetUpHeroModifiersForEachSmallButton(){
      ShowRankingViewButton.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 25), z: 0)]
      ContactusButton.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 19), z: 0)]
      PurchasButton.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 8), z: 0)]
      RestoreButton.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH + FViewH * 12), z: 0)]
   }
   


   private func SetUpStageButtonPosition() {
      EasyButton.frame = CGRect(x: FViewW * 6, y: FViewH * 8, width: FViewW * 12, height: FViewH * 3)
      NormalButton.frame = CGRect(x: FViewW * 6, y: FViewH * 12, width: FViewW * 12, height: FViewH * 3)
      HardButton.frame = CGRect(x: FViewW * 6, y: FViewH * 16, width: FViewW * 12, height: FViewH * 3)
   }
   

   
   
   
   //MARK:- Main.storybordでつけたボタンのタッチイベント -
   @IBAction func NextViewWithNum(_ sender: UIButton) {
      
      if CanPresentToSegeSellectViewFromHomeView == false { return }
      CanPresentToSegeSellectViewFromHomeView = false
      //遷移先のインスタンス
      //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController

      print("ステージレベルの送信開始")
      switch sender.tag {
      case 1:
         vc2.StageLevel = .Easy
         vc2.EasySellectButtonColor = self.EasyButton.backgroundColor!
         vc2.EasySellectButtonShadowColor = self.EasyButton.backgroundColor!
      case 2:
         vc2.StageLevel = .Normal
         vc2.NormalSellectButtonColor = self.NormalButton.backgroundColor!
         vc2.NormalSellectButtonShadowColor = self.NormalButton.backgroundColor!
      case 3:
         vc2.StageLevel = .Hard
         vc2.HardllectButtonColor = self.HardButton.backgroundColor!
         vc2.HardllectButtonShadowColor = self.HardButton.backgroundColor!
      default:
         fatalError()
      }
      print("ステージレベルの送信完了(\(vc2.StageLevel))")
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      
      //これを追加して重ならないようにするiOS13以降に自動適用される。
      vc2.modalPresentationStyle = .fullScreen
      self.present(vc2, animated: true, completion: {
         print("プレゼント終わった")
         //self.ChangeHeroIDForBack()
         self.CanPresentToSegeSellectViewFromHomeView = true
      })
   }
   
   
   //MARK:- スコアボードビューの表示
   @objc func ShowRankingView() {
      GameSound.PlaySoundsTapButton()
      ShowRankingViewButton.hero.id = HeroID.GameCenterVC
      
      //GoPiceStore()
      
      Analytics.logEvent("ShowGameCenter", parameters: nil)
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      gcView.hero.isEnabled = true
      gcView.view.hero.id = HeroID.GameCenterVC
      gcView.modalPresentationStyle = .fullScreen
      self.present(gcView, animated: true, completion: nil)
   }
   
   //MARK:- ストアのViewControllerに行く関数
   @objc func GoPiceStore() {
      let PiceStoreViewCon = self.storyboard?.instantiateViewController(withIdentifier: "PiceStore")
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      
      self.present(PiceStoreViewCon!, animated: true, completion: nil)
   }
   
   //MARK:- GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: {
         self.ShowRankingViewButton.hero.id = self.HeroID.ClearHart4ToHomeView
      })
   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}


