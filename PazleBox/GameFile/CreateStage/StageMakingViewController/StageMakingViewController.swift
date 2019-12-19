//
//  StageMakingViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import TapticEngine
import ChameleonFramework
import Firebase
import Hero
import SnapKit

class StageMakingViewController: UIViewController, GADBannerViewDelegate{
   
   
   @IBOutlet weak var BackButton: FUIButton!
   @IBOutlet weak var StageMakingButton: FUIButton!
   
   @IBOutlet weak var InfoLabel: UILabel!
   @IBOutlet weak var RemainingLabel: UILabel!
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   
   
   let userDefaults = UserDefaults.standard
   
   let MaxRegiStageCount = 18
   var UsersRegiStageCount = 18
   
   var isLockButton = false
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   let StageMakingBannerView = GADBannerView()
   let BannerViewReqest = GADRequest()
   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/2813553721"
   let BANNER_VIEW_HIGHT: CGFloat = 50
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      InitViewSize()
      InitBackgroundImageView()
      
      InitUsersRegiStageCount()
      InitAccessibilityIdentifires()
      
      InitEachButton()
      InitInfoLabel()
      InitRemainingLabel()
      
      SNPStageMakingButton()
      SNPInfoLabel()
      SNPRemainingLabel()
      
      InitHeroID()
      
      //NOTE:- ここでボタンがタップできるかどうかを判断
      SetUpStageMakingButton()
      
      InitAllADCheck()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      
   }
   
   //safeArea取得するために必要。
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      SNPBannerView()
   }
   
   //MARK:- SNPの設定。
   func SNPBannerView() {
      StageMakingBannerView.snp.makeConstraints{ make in
         make.height.equalTo(BANNER_VIEW_HIGHT)
         make.width.equalTo(self.view.frame.width)
         make.leading.equalTo(self.view.snp.leading).offset(0)
         if #available(iOS 11, *) {
            print("safeArea.bottom = \(self.view.safeAreaInsets.bottom)")
            make.bottom.equalTo(self.view.snp.bottom).offset(-self.view.safeAreaInsets.bottom)
         } else {
            //iOS11以下は，X系が存在していない。
            make.top.equalTo(self.view.snp.top).offset(0)
         }
      }
   }
   
   //MARK:- 初期化
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
   
   private func InitUsersRegiStageCount() {
      UsersRegiStageCount = userDefaults.integer(forKey: "CreateStageNum")
   }
   
   private func  InitAccessibilityIdentifires() {
     
   }
   
   
   
   private func InitEachButton() {
      InitButton(StageMakingButton)
      InitButton(BackButton)
      SetUpButtonColor()
      SetUpButtonPosition()
      SetUpButtonTitile()
   }
   
   private func SetUpButtonPosition() {
      StageMakingButton.frame = CGRect(x: FViewW * 6, y: FViewH * 13.5, width: FViewW * 12, height: FViewH * 3)
      BackButton.frame = CGRect(x: FViewW * 1, y: FViewH * 2.5, width: FViewW * 5, height: FViewH * 3 / 2)
   }
   
   private func SetUpButtonTitile() {
      StageMakingButton.setTitle(NSLocalizedString("StageCreate", comment: ""), for: .normal)
   }
   
   private func InitButton(_ sender: FUIButton) {
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
   
   private func SetUpButtonColor() {
      StageMakingButton.buttonColor = UIColor.flatTeal()
      StageMakingButton.shadowColor = UIColor.flatTealColorDark()
      BackButton.buttonColor = UIColor.flatMaroonColorDark()
      BackButton.shadowColor = UIColor.flatMaroonColorDark()
   }
   
   
   private func InitInfoLabel() {
      let first = NSLocalizedString("CreateUpToFirst", comment: "")
      let Num = MaxRegiStageCount
      let NumStr = String(Num)
      let last = NSLocalizedString("CreateUpToLast", comment: "")
      let title = first + " " + NumStr + " " + last
      InfoLabel.text = title
      InfoLabel.alpha = 0.9
      InfoLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
      InfoLabel.adjustsFontSizeToFitWidth = true
      InfoLabel.textColor = UIColor.flatBlack()
      InfoLabel.textAlignment = .center
      InfoLabel.sizeToFit()
      InfoLabel.lineBreakMode = .byWordWrapping
      InfoLabel.center.x = StageMakingButton.center.x
   }
   
   private func InitRemainingLabel() {
      let first = NSLocalizedString("RemaingFirst", comment: "")
      let Num = MaxRegiStageCount - UsersRegiStageCount
      let NumStr = String(Num)
      let last = NSLocalizedString("RemaingLast", comment: "")
      let title = first + " " + NumStr + " " + last
      RemainingLabel.text = title
      RemainingLabel.alpha = 0.9
      RemainingLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
      RemainingLabel.adjustsFontSizeToFitWidth = true
      RemainingLabel.textColor = UIColor.flatBlack()
      RemainingLabel.textAlignment = .center
      RemainingLabel.sizeToFit()
      RemainingLabel.lineBreakMode = .byWordWrapping
      RemainingLabel.center.x = StageMakingButton.center.x
   }
   
   private func SNPStageMakingButton() {
      StageMakingButton!.snp.makeConstraints{ make in
         make.width.equalTo(FViewW * 12)
         make.height.equalTo(FViewH * 3)
         make.leading.equalTo(self.view.snp.leading).offset(FViewW * 6)
         make.top.equalTo(self.view.snp.top).offset(FViewH * 13.5)
      }
   }
   
   private func SNPInfoLabel() {
      InfoLabel!.snp.makeConstraints{ make in
         make.top.equalTo(StageMakingButton!.snp.bottom).offset(20)
         make.leading.equalTo(self.view.snp.leading).offset(20)
         make.trailing.equalTo(self.view.snp.trailing).offset(-20)
         make.height.equalTo(23)
      }
   }
   
   private func SNPRemainingLabel() {
      RemainingLabel!.snp.makeConstraints{ make in
         make.top.equalTo(InfoLabel!.snp.bottom).offset(5)
         make.leading.equalTo(self.view.snp.leading).offset(20)
         make.trailing.equalTo(self.view.snp.trailing).offset(-20)
         make.height.equalTo(23)
      }
   }
   
   //MARK:- 広告のチェックと初期化
   private func InitAllADCheck() {
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         self.InitBannerView()
      }else{
         print("課金をしているので広告の初期化は行いません")
      }
   }
   
   private func InitBannerView() {
      #if DEBUG
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         self.StageMakingBannerView.adUnitID = BANNER_VIEW_TEST_ID
         self.BannerViewReqest.testDevices = ["9d012329e337de42666c706e842b7819"];
         print("バナー広告：テスト環境\n\n")
      #else
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         self.StageMakingBannerView.adUnitID = BANNER_VIEW_ID
         print("バナー広告：本番環境")
      #endif
      
      //GameClearBannerView.backgroundColor = .black
      StageMakingBannerView.frame = CGRect(x: 0, y: ViewH - BANNER_VIEW_HIGHT, width: ViewW, height: BANNER_VIEW_HIGHT)
      self.view.addSubview(StageMakingBannerView)
      self.view.bringSubviewToFront(StageMakingBannerView)
      
      StageMakingBannerView.rootViewController = self
      StageMakingBannerView.load(BannerViewReqest)
      StageMakingBannerView.delegate = self
   }
   
   
   
   private func SetUpStageMakingButton() {
      guard UsersRegiStageCount == MaxRegiStageCount else {
         print("まだ作れます。")
         return
      }
      
      print("これ以上ステージ増やせない。")
      print("ボタンのタップを無効にします。")
      self.StageMakingButton.isEnabled = false
   }
   
   private func InitHeroID() {
      BackButton.hero.id = HeroID.TopLable_Back
      StageMakingButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
      InfoLabel.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 6), y: 0, z: 0)]
      RemainingLabel.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 2), y: 0, z: 0)]
   }
   
   //MARK:- ボタンタップ
   @IBAction func TapBackButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      
      InitHeroID()
      
      GameSound.PlaySoundsTapButton()
      dismiss(animated: true, completion: nil)
   }
   
   //NOTE:- タップしたら同一SB上の
   @IBAction func TapStageMakingButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      
      GameSound.PlaySoundsTapButton()
      
      BackButton.hero.id = HeroID.TopLable_Back
      StageMakingButton.hero.id = HeroID.MakingButton_Trash
      InfoLabel.hero.id = HeroID.InfoLabel_Option
      RemainingLabel.hero.id = HeroID.RemainingLabel_Label
      
      Analytics.logEvent("TapMakingStageButton", parameters: nil)
      
      let CreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateStageVC") as! CleateStageViewController
      CreateStageVC.modalPresentationStyle = .fullScreen
      self.present(CreateStageVC, animated: true, completion: {
         print("CreateStageVCにプレゼント完了")
         self.isLockButton = false
      })
   }
   
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   private func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   
   
   //MARK:- ADMOB
   /// Tells the delegate an ad request loaded an ad.
   func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("広告(banner)のロードが完了しました。")
   }
   
   /// Tells the delegate an ad request failed.
   func adView(_ bannerView: GADBannerView,
               didFailToReceiveAdWithError error: GADRequestError) {
      print("広告(banner)のロードに失敗しました。: \(error.localizedDescription)")
   }
   
   /// Tells the delegate that a full-screen view will be presented in response
   /// to the user clicking on an ad.
   func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
   }
   
   /// Tells the delegate that the full-screen view will be dismissed.
   func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
   }
   
   /// Tells the delegate that the full-screen view has been dismissed.
   func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
   }
   
   /// Tells the delegate that a user click will open another app (such as
   /// the App Store), backgrounding the current app.
   func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
   }
}
