//
//  RootViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/23.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import TapticEngine
import SwiftyStoreKit
import SCLAlertView
import Crashlytics
import GameKit

import Firebase
import FlatUIKit
import Hero

class RootViewController: UIViewController, GKGameCenterControllerDelegate {
   
   @IBOutlet weak var PlayButton: FUIButton!
   @IBOutlet weak var CreateButton: FUIButton!
   
   var PurchasButton: FUIButton?
   var RestoreButton: FUIButton?
   
   var ShowRankingViewButton: FUIButton?
   var ContactusButton: FUIButton?
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var TitleLabel: UILabel?
   
   private var GameBGM: BGM?
   let GameSound = GameSounds()
   
   let HeroID = HeroIDs()
   var BackGroundImageView: BackGroundImageViews?
   
   //この2つは課金で使う
   let IAP_PRO_ID = "NO_ADS"
   let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   var LockPurchasButton = false  //ロックされていたらappleのサーバに余計に請求しなくする
   var CanPresentToSegeSellectViewFromHomeView = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.hero.isEnabled = true
      
      InitViewSize()
      
      
      CheckIAPInfomation()
      InitButton()
      InitEachIAPButton()
      InitContactusButton()
      InitShowRankingViewButton()
      
      InitBackgroundImageView()
      InitBGM()
      StartBGM()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      //戻ってきた時についてなかったらさいせい
      if !GameBGM!.Hight_Tech.isPlaying {
         print("BGMついてないから再生します。")
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
   func InitEachIAPButton() {
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
      SetUpSellectStageButton(sender: PlayButton)
      SetUpSellectStageButton(sender: CreateButton)
      
      SetUpStageButtonHeroID()
      SetUpHeroModifiersForEachStageButton()
      SetUpStageButtonPosition()
   }
   
   //MARK: ステージボタンのHEROIDつける -
   private func SetUpStageButtonHeroID() {
      PlayButton.hero.id = HeroID.BackEasyStage
      CreateButton.hero.id = HeroID.BackNormalStage
   }
   
   private func SetUpHeroModifiersForEachStageButton() {
      PlayButton.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 6), y: 0, z: 0)]
      CreateButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 2), y: 0, z: 0)]
   
   }
   
   private func SetUpHeroModifiersForEachSmallButton(){
      ShowRankingViewButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 25), z: 0)]
      ContactusButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 19), z: 0)]
      PurchasButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH - FViewH * 8), z: 0)]
      RestoreButton!.hero.modifiers = [.arc(), .translate(x: 0, y: +(ViewH + FViewH * 12), z: 0)]
   }
   
   private func SetUpHeroModifiersForTitleLabel() {
      TitleLabel!.hero.modifiers = [.arc(), .translate(x: 0, y: -(ViewH - FViewH * 10), z: 0)]
   }

   private func SetUpStageButtonPosition() {
      PlayButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      CreateButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
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
   
   //MARK:- スコアボードビューの表示
   @objc func ShowRankingView() {
      GameSound.PlaySoundsTapButton()
      ShowRankingViewButton?.hero.id = HeroID.GameCenterVC
      
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
   
   //MARK:- コンタクトアスボタン押された時の処理
   @objc func ContactUs() {
      ContactusButton?.hero.id = "BackButton"
      GameSound.PlaySoundsTapButton()
      
      //FIXME:- 終わったら削除
      let Storybord = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let VC = Storybord.instantiateViewController(withIdentifier: "SellectCreateStageViewController")
      VC.modalPresentationStyle = .fullScreen
      self.present(VC, animated: true, completion: nil)
      return
      //TODO:- 終わったら削除
      
      
      
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
   
   //MARK:- GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: {
         self.ShowRankingViewButton?.hero.id = self.HeroID.ClearHart4ToHomeView
      })
   }
   
   
   @IBAction func TapPlayButton(_ sender: Any) {
      print("Tap PlayButton")
   }
   
   
   @IBAction func TapCreateButton(_ sender: Any) {
      print("Tap CreateButton")
      
   }
}
