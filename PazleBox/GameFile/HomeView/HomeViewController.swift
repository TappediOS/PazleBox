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
import Hero

class HomeViewController: UIViewController, GKGameCenterControllerDelegate {
   
   @IBOutlet weak var EasyButton: FUIButton!
   @IBOutlet weak var NormalButton: FUIButton!
   @IBOutlet weak var HardButton: FUIButton!
   
   var PurchasButton: FUIButton?
   var RestoreButton: FUIButton?
   
   var ShowRankingViewButton: FUIButton?
   var ContactusButton: FUIButton?
   
   var GoPiceStoreButton: FUIButton?
   //MARK: リーダボードID
   let LEADERBOARD_ID = "ClearStageNumLeaderBoard"
   
   //リモートコンフィグろとるやつ
   var RemorteConfigs: RemoteConfig!
   
   let EasyStageNameKey = "Easy"
   let NormalStageNameKey = "Normal"
   let HardStageNameKey = "Hard"

   let RemoConName = RemoteConfgName()
   let ButtonClorMane = ButtonColorManager()
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var TitleLabel: UILabel?
   
   //この2つは課金で使う
   let IAP_PRO_ID = "NO_ADS"
   let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   var LockPurchasButton = false  //ロックされていたらappleのサーバに余計に請求しなくする
   var CanSegeSellectView = true
   
   private var GameBGM: BGM?
   let GameSound = GameSounds()
   
   let HeroID = HeroIDs()
   var BackGroundImageView: BackGroundImageViews?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.hero.isEnabled = true
      
      InitViewSize()
      
      CheckIAPInfomation()
      InitNotificationCenter()
      InitBackgroundImageView()
      InitTitleLabel()
      InitButton()
      Inittestbutton()
      InitContactusButton()
      InitShowRankingViewButton()
      InitGoPiceStoreButton()
      SetUpHeroModifiersForEachSmallButton()
      InitBGM()
      
      InitConfig()
      SetUpRemoteConfigDefaults()
      SetEachStageButtonName()
      SetEachButtonColor()
      SetTitileLabelText()
      FetchConfig()
      StartBGM()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      //戻ってきた時についてなかったらさいせい
      if !GameBGM!.Hight_Tech.isPlaying {
         StartBGM()
      }
      //HeroIDを元に戻す
      SetUpStageButtonHeroID()
   }
   
   private func InitViewSize() {
      ViewW = self.view.frame.width
      ViewH = self.view.frame.height
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   
   private func InitBGM() {
      self.GameBGM = BGM()
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   //MARK: 通知の初期化
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(StopHomeBGMCatchNotification(notification:)), name: .StopHomeViewBGM, object: nil)
   }
   
   private func InitTitleLabel() {
      TitleLabel = UILabel(frame: CGRect(x: FViewW * 6, y: FViewH * 3, width: FViewW * 13, height: FViewH * 3))
      TitleLabel!.text = "Relaxing puzzle"
      TitleLabel!.font = UIFont(name: "HiraMaruProN-W4", size: 50)
      TitleLabel!.adjustsFontSizeToFitWidth = true
      TitleLabel!.adjustsFontForContentSizeCategory = true
      TitleLabel!.minimumScaleFactor = 0.3
      TitleLabel!.textAlignment = NSTextAlignment.center
      
      self.view.addSubview(TitleLabel!)
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
         RemoConName.PurchasStageButtonColor : "FlatCoffee" as NSObject,
         RemoConName.RestoreStageButtonColor : "FlatCoffee" as NSObject,
         RemoConName.ShowRankStageButtonColor : "FlatCoffee" as NSObject,
         RemoConName.ContactUsButtonColor : "FlatCoffee" as NSObject,
         
         RemoConName.TitileLabelText: "Relaxing puzzle" as NSObject
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
   
   //ステージボタンのtextsを変更する
   func SetEachStageButtonName() {
      print("れもこん1 \(String(describing: RemorteConfigs[RemoConName.EasyStageButtonName].stringValue))")
      print("れもこん2 \(String(describing: RemorteConfigs[RemoConName.NormalStageButtonName].stringValue))")
      print("れもこん3 \(String(describing: RemorteConfigs[RemoConName.HardStageButtonName].stringValue))")
      
      EasyButton.setTitle(RemorteConfigs[RemoConName.EasyStageButtonName].stringValue, for: .normal)
      NormalButton.setTitle(RemorteConfigs[RemoConName.NormalStageButtonName].stringValue, for: .normal)
      HardButton.setTitle(RemorteConfigs[RemoConName.HardStageButtonName].stringValue, for: .normal)
   }
   
   //した4個のボタンの色を変更するん
   private func SetEachButtonColor() {
      EasyButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.EasyStageButtonColor].stringValue!)
      NormalButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.NormalStageButtonColor].stringValue!)
      HardButton.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.HardStageButtonColor].stringValue!)
      
      PurchasButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.PurchasStageButtonColor].stringValue!)
      RestoreButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.RestoreStageButtonColor].stringValue!)
      ShowRankingViewButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ShowRankStageButtonColor].stringValue!)
      ContactusButton!.buttonColor = ButtonClorMane.GetButtonFlatColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ContactUsButtonColor].stringValue!)
      
      EasyButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.EasyStageButtonColor].stringValue!)
      NormalButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.NormalStageButtonColor].stringValue!)
      HardButton.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.HardStageButtonColor].stringValue!)
      
      PurchasButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.PurchasStageButtonColor].stringValue!)
      RestoreButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.RestoreStageButtonColor].stringValue!)
      ShowRankingViewButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ShowRankStageButtonColor].stringValue!)
      ContactusButton!.shadowColor = ButtonClorMane.GetButtonFlatShadowColor(RemoConButtonColorValue: RemorteConfigs[RemoConName.ContactUsButtonColor].stringValue!)
   }
   
   private func SetTitileLabelText() {
      TitleLabel!.text = RemorteConfigs[RemoConName.TitileLabelText].stringValue!
   }
   
   private func SetUpHomeEachSmallButton(sender: FUIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
      sender.buttonColor = UIColor.turquoise()
      sender.shadowColor = UIColor.greenSea()
      sender.shadowHeight = 3.0
      sender.cornerRadius = 6.0
      sender.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      //sender.hero.modifiers = [.translate(y:200)]
   }
   
   //ボタンの初期化
   func Inittestbutton() {
      PurchasButton = FUIButton(frame: CGRect(x: FViewW * 13, y: FViewH * 25, width: FViewW * 5, height: FViewH * 3))
      PurchasButton?.setTitle(NSLocalizedString("No Ads", comment: ""), for: .normal)
      PurchasButton?.addTarget(self, action: #selector(self.tapparchas), for: .touchUpInside)
      PurchasButton?.hero.id = HeroID.ClearHart3ToHomeView
      SetUpHomeEachSmallButton(sender: PurchasButton!)
      self.view.addSubview(PurchasButton!)
      
      RestoreButton = FUIButton(frame: CGRect(x: FViewW * 19, y: FViewH * 25, width: FViewW * 5, height: FViewH * 3))
      RestoreButton?.setTitle(NSLocalizedString("Restore", comment: ""), for: .normal)
      RestoreButton?.addTarget(self, action: #selector(self.restore), for: .touchUpInside)
      RestoreButton?.hero.id = HeroID.ClearHart2ToHomeView
      SetUpHomeEachSmallButton(sender: RestoreButton!)
      self.view.addSubview(RestoreButton!)
   }
   
   private func InitShowRankingViewButton() {
      ShowRankingViewButton = FUIButton(frame: CGRect(x: FViewW * 1, y: FViewH * 25, width: FViewW * 5, height: FViewH * 3))
      ShowRankingViewButton?.setTitle(NSLocalizedString("Ranking", comment: ""), for: .normal)
      ShowRankingViewButton?.addTarget(self, action: #selector(self.ShowRankingView), for: .touchUpInside)
      ShowRankingViewButton?.hero.id = HeroID.GameCenterVC
      ShowRankingViewButton?.hero.id = HeroID.ClearHart4ToHomeView
      SetUpHomeEachSmallButton(sender: ShowRankingViewButton!)
      self.view.addSubview(ShowRankingViewButton!)
   }
   
   private func InitContactusButton() {
      ContactusButton = FUIButton(frame: CGRect(x: FViewW * 7, y: FViewH * 25, width: FViewW * 5, height: FViewH * 3))
      ContactusButton?.setTitle(NSLocalizedString("Contact us", comment: ""), for: .normal)
      ContactusButton?.addTarget(self, action: #selector(self.ContactUs), for: .touchUpInside)
      ContactusButton?.hero.id = HeroID.ClearHart2ToHomeView
      SetUpHomeEachSmallButton(sender: ContactusButton!)
      self.view.addSubview(ContactusButton!)
   }
   
   private func InitGoPiceStoreButton() {
      GoPiceStoreButton = FUIButton(frame: CGRect(x: FViewW * 1, y: FViewH * 25 - FViewH * 3 - 10, width: FViewW * 5, height: FViewH * 3))
      GoPiceStoreButton?.setTitle(NSLocalizedString("Store", comment: ""), for: .normal)
      GoPiceStoreButton?.addTarget(self, action: #selector(self.GoPiceStore), for: .touchUpInside)
      SetUpHomeEachSmallButton(sender: GoPiceStoreButton!)
      self.view.addSubview(GoPiceStoreButton!)
   }
   
   //MARK:- コンタクトアスボタン押された時の処理
   //FIXME:- とりあえず，CoinView出すから終わったら消せ
   @objc func ContactUs() {

      ContactusButton?.hero.id = "BackButton"
      let CoinView = BuyCoinView(frame: self.view.frame)
      self.view.addSubview(CoinView)
      
      return
      
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
   
   //MARK:- FlatUIButtonをセットアップ
   private func SetUpSellectStageButton(sender: FUIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
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
      
      SetUpStageButtonHeroID()
      SetUpHeroModifiersForEachStageButton()
      SetUpStageButtonPosition()
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
      ShowRankingViewButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 25), z: 0)]
      ContactusButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 19), z: 0)]
      PurchasButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 8), z: 0)]
      RestoreButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH + FViewH * 12), z: 0)]
   }

   private func SetUpStageButtonPosition() {
      EasyButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      NormalButton.frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      HardButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
   }
   
   private func StartBGM() {
      if let bgm = GameBGM {
         if !bgm.isPlayingHomeBGM() {
            bgm.fade(player: bgm.Hight_Tech, fromVolume: 0, toVolume: bgm.SoundVolume, overTime: 3.25)
         }
      }else{
         print("BGM初期化できてないよ-")
      }
   }
   
   //MARK:- BGM止めるようにしろってに通知きたよ
   @objc func StopHomeBGMCatchNotification(notification: Notification) -> Void {
      if let bgm = GameBGM {
         if !bgm.isPlayingHomeBGM() {
            bgm.fade(player: bgm.Hight_Tech, fromVolume: bgm.Hight_Tech.volume, toVolume: 0, overTime: 0.45)
         }
      }else{
         print("BGM初期化できてないよ-")
      }
   }
   
   //MARK:- Main.storybordでつけたボタンのタッチイベント -
   @IBAction func NextViewWithNum(_ sender: UIButton) {
      
      if CanSegeSellectView == false { return }
      CanSegeSellectView = false
      //遷移先のインスタンス
      //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController

      print("ステージレベルの送信開始")
      switch sender.tag {
      case 1:
         vc2.StageLevel = .Easy
         vc2.EasySellectButtonColor = self.EasyButton.buttonColor
         vc2.EasySellectButtonShadowColor = self.EasyButton.shadowColor
      case 2:
         vc2.StageLevel = .Normal
         vc2.NormalSellectButtonColor = self.NormalButton.buttonColor
         vc2.NormalSellectButtonShadowColor = self.NormalButton.shadowColor
      case 3:
         vc2.StageLevel = .Hard
         vc2.HardllectButtonColor = self.HardButton.buttonColor
         vc2.HardllectButtonShadowColor = self.HardButton.shadowColor
      default:
         fatalError()
      }
      print("ステージレベルの送信完了(\(vc2.StageLevel))")
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      
      //FIXME:- hero使わんねんやったらreturnとろ
      self.present(vc2, animated: true, completion: {
         print("プレゼント終わった")
         //self.ChangeHeroIDForBack()
         self.CanSegeSellectView = true
      })
   }
   
   
   
   //MARK:- スコアボードビューの表示
   @objc func ShowRankingView() {
      GameSound.PlaySoundsTapButton()
      Analytics.logEvent("ShowGameCenter", parameters: nil)
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      gcView.hero.isEnabled = true
      gcView.view.hero.id = HeroID.GameCenterVC
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
      gameCenterViewController.dismiss(animated: true, completion: nil)
   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}


