//
//  CreateHomeViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FlatUIKit
import TapticEngine
import Firebase

class CreateHomeViewController: UIViewController, GADBannerViewDelegate {
   
   @IBOutlet weak var SellectStageButton: FUIButton!
   @IBOutlet weak var StageAuthCreateButton: FUIButton!
   @IBOutlet weak var InternetUsersStageButton: FUIButton!
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var isLockButton = false
   
   let ChoseStageBannerView = GADBannerView()
   let BannerViewReqest = GADRequest()
   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/5797426826"
   let BANNER_VIEW_HIGHT: CGFloat = 50
      
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      InitViewSize()
      InitBackgroundImageView()
      InitEachButton()
      
      InitHeroID()
      InitAccessibilityIdentifires()
      
      InitAllADCheck()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         if ChoseStageBannerView.isHidden == true {
            ChoseStageBannerView.isHidden = false
         }
         return
      }
      
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true {
         if ChoseStageBannerView.isHidden == false {
            ChoseStageBannerView.isHidden = true
         }
      }
   }
   
   override func viewDidAppear(_ animated: Bool) {
      InitHeroID()
   }
   
   //safeArea取得するために必要。
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         if ChoseStageBannerView.isHidden == true {
            ChoseStageBannerView.isHidden = false
         }
         self.SNPBannerView()
      }
   }
   
   //MARK:- SNPの設定。
   func SNPBannerView() {
      ChoseStageBannerView.snp.makeConstraints{ make in
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
   
   private func  InitAccessibilityIdentifires() {
      SellectStageButton?.accessibilityIdentifier = "CreateHomeVC_SellectStageButton"
      StageAuthCreateButton?.accessibilityIdentifier = "CreateHomeVC_StageAuthCreateButton"
      InternetUsersStageButton?.accessibilityIdentifier = "CreateHomeVC_InternetUsersStageButton"
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func InitEachButton() {
      InitButton(SellectStageButton)
      InitButton(StageAuthCreateButton)
      InitButton(InternetUsersStageButton)
      SetUpButtonColor()
      SetUpButtonPosition()
      SetUpButtonTitile()
      
      StageAuthCreateButton.isHidden = true
      StageAuthCreateButton.isEnabled = false
   }
   
   private func SetUpButtonTitile() {
      StageAuthCreateButton.setTitle(NSLocalizedString("StageCreatormade", comment: ""), for: .normal)
      SellectStageButton.setTitle(NSLocalizedString("StageYouMade", comment: ""), for: .normal)
      InternetUsersStageButton.setTitle(NSLocalizedString("StageInTheWorld", comment: ""), for: .normal)
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
      SellectStageButton.buttonColor = UIColor.flatPlum()
      SellectStageButton.shadowColor = UIColor.flatPlumColorDark()
      StageAuthCreateButton.buttonColor = UIColor.flatTeal()
      StageAuthCreateButton.shadowColor = UIColor.flatTealColorDark()
      InternetUsersStageButton.buttonColor = UIColor.flatOrange()
      InternetUsersStageButton.shadowColor = UIColor.flatOrangeColorDark()
   }
   
   private func SetUpButtonPosition() {

      SellectStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      InternetUsersStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      StageAuthCreateButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
   }
   
   
   private func InitHeroID() {
      StageAuthCreateButton.hero.id = HeroID.TopPlayAndCreateCreate
      SellectStageButton.hero.id = HeroID.TopCreateAndCreateFinCreate
      SellectStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
      InternetUsersStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 6), y: 0, z: 0)]
      StageAuthCreateButton.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 2), y: 0, z: 0)]
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
           self.ChoseStageBannerView.adUnitID = BANNER_VIEW_TEST_ID
           self.BannerViewReqest.testDevices = ["9d012329e337de42666c706e842b7819"];
           print("バナー広告：テスト環境\n\n")
        #else
           print("\n\n--------INFO ADMOB--------------\n")
           print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
           self.ChoseStageBannerView.adUnitID = BANNER_VIEW_ID
           print("バナー広告：本番環境")
        #endif
        
        //GameClearBannerView.backgroundColor = .black
        ChoseStageBannerView.frame = CGRect(x: 0, y: ViewH - BANNER_VIEW_HIGHT, width: ViewW, height: BANNER_VIEW_HIGHT)
        self.view.addSubview(ChoseStageBannerView)
        self.view.bringSubviewToFront(ChoseStageBannerView)
        
        ChoseStageBannerView.rootViewController = self
        ChoseStageBannerView.load(BannerViewReqest)
        ChoseStageBannerView.delegate = self
     }
   
   //MARK:-　各ボタンをタップした時の動作
   @IBAction func TapStageAuthCreateButton(_ sender: FUIButton) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      
      GameSound.PlaySoundsTapButton()
      StageAuthCreateButton?.hero.id = HeroID.CreateCreateAndCreatingTrash
      SellectStageButton?.hero.id = HeroID.CreateFinCreateAndCreatingOption
      InternetUsersStageButton?.hero.id = HeroID.CreateInternetAndCreatingInfoLabel
      
      Analytics.logEvent("TapStageAuthCreateButton", parameters: nil)
      
      let Storybord = UIStoryboard(name: "Main", bundle: nil)
      let HomeVC = Storybord.instantiateViewController(withIdentifier: "HomeView")
      HomeVC.modalPresentationStyle = .fullScreen

      self.present(HomeVC, animated: true, completion: {
         print("Home VCにプレゼント完了")
         self.isLockButton = false
         self.ChoseStageBannerView.isHidden = true
      })
   }
   
   
   @IBAction func TapSellectStageButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      GameSound.PlaySoundsTapButton()
      SellectStageButton.hero.id = HeroID.CreateFinCreateAndSellectBack
      
      Analytics.logEvent("TapSellectStageButton", parameters: nil)
      
      let SellectCreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "SellectCreateStageVC") as! SellectCreateStageViewController
      SellectCreateStageVC.modalPresentationStyle = .fullScreen
      self.present(SellectCreateStageVC, animated: true, completion: {
         print("SellectCreateStageVCにプレゼント完了")
         self.isLockButton = false
         self.ChoseStageBannerView.isHidden = true
      })
   }
   
   @IBAction func TapInterNetButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      GameSound.PlaySoundsTapButton()
      SellectStageButton.hero.id = HeroID.CreateFinCreateAndSellectBack
      
      Analytics.logEvent("TapSellectStageButton", parameters: nil)
      
      let SellectCreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "SellectIntarnetStageVC") as! SellectInternetStageViewController
      SellectCreateStageVC.modalPresentationStyle = .fullScreen
      self.present(SellectCreateStageVC, animated: true, completion: {
         print("SellectIntarnetStageVCにプレゼント完了")
         self.isLockButton = false
         self.ChoseStageBannerView.isHidden = true
      })
   }
   

   //   //COMING SOON LABELの初期化　使ってない。けどまた使うかもしれないから残しとく。
   //   //消すべきであるとは思う。
   //   private func InitComminSoonLabel() {
   //      CominSoonLabel = UILabel(frame: CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3))
   //      CominSoonLabel.text = "Coming Soon"
   //      CominSoonLabel.alpha = 0.9
   //      CominSoonLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
   //      CominSoonLabel.adjustsFontSizeToFitWidth = true
   //      CominSoonLabel.textColor = UIColor.flatBlack()
   //      CominSoonLabel.textAlignment = .center
   //      CominSoonLabel.sizeToFit()
   //      CominSoonLabel.lineBreakMode = .byWordWrapping
   //      CominSoonLabel.center.x = InternetUsersStageButton.center.x
   //      view.addSubview(CominSoonLabel)
   //   }
   
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
