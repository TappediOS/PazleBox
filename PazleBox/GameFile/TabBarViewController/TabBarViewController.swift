//
//  TabBarViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import FlatUIKit
import TapticEngine
import ChameleonFramework
import Firebase
import Hero
import SnapKit

class PuzzleTabBarController: ESTabBarController, GADBannerViewDelegate {
   
   var image = UIImage()
   var selectedImage = UIImage()
   
   private var GameBGM: BGM?
   let GameSound = GameSounds()
   
   let PuzzleMakerTabBarBannerView = GADBannerView()
   let BannerViewReqest = GADRequest()
   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/4639498022"
   var BANNER_VIEW_HIGHT: CGFloat = 50
   
   //viewWillAppearで初期化しているから，dismissしたときに複数回初期化することになるのを防ぐ.
   var firstOpenForBGM = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitNotificationCenter()
      InitAllADCheck()
   }
   
   
   /// なんでここでBGM Initしてるか。
   /// そもそもライフサイクルが
   ///     viewDidLoad -> AppDelegade -> viewWillAppar
   /// の順になってる。
   /// んで，firebase.config()するのはAppDelegade
   /// のくせに，Configする前に，viewDidLoadでremoteConfig
   /// を初期化しようとするから，レモコンの値がnilになって落ちる。
   /// 他のViewControllerではアプリ起動直後でないからviewDidLoadに書いてOK
   /// 
   /// - Parameter animated:
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      if firstOpenForBGM == true {
         InitBGM()
         StartBGM()
         firstOpenForBGM = false
      }
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         if PuzzleMakerTabBarBannerView.isHidden == true {
            PuzzleMakerTabBarBannerView.isHidden = false
         }
         return
      }
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true {
         if PuzzleMakerTabBarBannerView.isHidden == false {
            PuzzleMakerTabBarBannerView.isHidden = true
         }
      }
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      if let bgm = GameBGM {
         if bgm.Hight_Tech.isPlaying == false {
            print("BGMついてないから再生します。")
            StartBGM()
         }
      }else{
         print("BGMにnil入っててんけど？")
      }
   }
   
   //safeArea取得するために必要。
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         self.SNPBannerView()
      }
   }
   
   //MARK:- SNPの設定。これでsafeAreaにバナーviewを合わせている。
   func SNPBannerView() {
      PuzzleMakerTabBarBannerView.snp.makeConstraints{ make in
         make.height.equalTo(BANNER_VIEW_HIGHT)
         make.width.equalTo(self.view.frame.width)
         make.leading.equalTo(self.view.snp.leading).offset(0)
         if #available(iOS 11, *) {
            print("safeArea.bottom = \(self.view.safeAreaInsets.bottom)")
            make.bottom.equalTo(self.tabBar.snp.top).offset(0)
         } else {
            make.top.equalTo(self.tabBar.snp.top).offset(0)
         }
      }
   }
    
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      
      image = getPlayImage()
      selectedImage = getPlayFillImage()
      
      //----- CollectionViewとして生成 -----//
      var title = NSLocalizedString("Play", comment: "")
      let Storybord = UIStoryboard(name: "CleateStageSB", bundle: nil)
      //こっちにしたら，自分のステージと世界のステージを選べる画面になる。
      //let PlayVC = Storybord.instantiateViewController(withIdentifier: "SellectCreateStageViewController")
      let PlayVC = Storybord.instantiateViewController(withIdentifier: "SellectIntarnetStageVC")
      PlayVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                           image: image, selectedImage: selectedImage, tag: 1)
      
      PlayVC.tabBarItem.accessibilityIdentifier = "tabBar_Play"
      //----- CollectionViewとして生成 -----//
      
      
      //----- WorldVCを生成 ----//
      let WorldVCSB = UIStoryboard(name: "WorldTableViewControllerSB", bundle: nil)
      let WorldVC = WorldVCSB.instantiateViewController(withIdentifier: "WorldTableViewNavigationVC")
      WorldVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                           image: image, selectedImage: selectedImage, tag: 1)
      
      WorldVC.tabBarItem.accessibilityIdentifier = "tabBar_Play"
      //----- WorldVCを生成 ----//
      
      //----- Tabeviewとして生成 -----//
      title = NSLocalizedString("TimeLine", comment: "")
      image = getHouseImage()
      selectedImage = getHouseFillImage()
      let InterNetStorybord = UIStoryboard(name: "InterNetTableView", bundle: nil)
      let InterNetTableVC = InterNetStorybord.instantiateViewController(withIdentifier: "InterNetNavigationVC")
      InterNetTableVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                           image: image, selectedImage: selectedImage, tag: 1)
      
      InterNetTableVC.tabBarItem.accessibilityIdentifier = "tabBar_Play"
      //----- Tabeviewとして生成 -----//
      
      image = getCreateImage()
      selectedImage = getCreateFillImage()
      title = NSLocalizedString("Create", comment: "")
      let CreateVC = Storybord.instantiateViewController(withIdentifier: "StageMakingVC")
      CreateVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                              image: image, selectedImage: selectedImage, tag: 2)
      CreateVC.tabBarItem.accessibilityIdentifier = "tabBar_Create"
      
      
      
      image = getCartImage()
      selectedImage = getCartFillImage()
      title = NSLocalizedString("PiceShop", comment: "")
      let ShoppingStorybord = UIStoryboard(name: "ShoppingPiceVC", bundle: nil)
      let ShoppingPiceVC = ShoppingStorybord.instantiateViewController(withIdentifier: "PiceShopNavigationVC")
      ShoppingPiceVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                              image: image, selectedImage: selectedImage, tag: 3)
      ShoppingPiceVC.tabBarItem.accessibilityIdentifier = "tabBar_Cart"
      
      
      
      image = getSettingImage()
      selectedImage = getSettingFillImage()
      title = NSLocalizedString("Setting", comment: "")

      //settingのVC画面
      let MainStorybord = UIStoryboard(name: "Main", bundle: nil)
      let SettingVC = MainStorybord.instantiateViewController(withIdentifier: "SettingTableVC")
      SettingVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                                image: image, selectedImage: selectedImage, tag: 4)
      SettingVC.tabBarItem.accessibilityIdentifier = "tabBar_Setting"
      
      
      title = NSLocalizedString("MyPage", comment: "")
      //---- UserProfileVC ----//
      let UserProfileSB = UIStoryboard(name: "UserProfileViewControllerSB", bundle: nil)
      let UserProfileVC = UserProfileSB.instantiateViewController(withIdentifier: "UserProfileNavigationVC")
      UserProfileVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                                image: image, selectedImage: selectedImage, tag: 4)
      UserProfileVC.tabBarItem.accessibilityIdentifier = "tabBar_Setting"
      //---- UserProfileVC ----//
      
      
      //MARK:- 配列の0番目を変更してPlayVCにすると元に戻る
      self.viewControllers = [InterNetTableVC, WorldVC, CreateVC, ShoppingPiceVC, UserProfileVC]
      self.selectedViewController = self.viewControllers?[0]
      self.selectedIndex = 0
   }
   
   //MARK: 通知の初期化
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(StopHomeBGMCatchNotification(notification:)), name: .StopHomeViewBGM, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(StartHomeBGMCatchNotification(notification:)), name: .StartHomeViewBGM, object: nil)
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
         self.PuzzleMakerTabBarBannerView.adUnitID = BANNER_VIEW_TEST_ID
         self.BannerViewReqest.testDevices = ["9d012329e337de42666c706e842b7819"];
         print("バナー広告：テスト環境\n\n")
      #else
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         self.PuzzleMakerTabBarBannerView.adUnitID = BANNER_VIEW_ID
         print("バナー広告：本番環境")
      #endif
      
      //GameClearBannerView.backgroundColor = .black
      PuzzleMakerTabBarBannerView.frame = CGRect(x: 0, y: view.frame.height - BANNER_VIEW_HIGHT, width: view.frame.width, height: BANNER_VIEW_HIGHT)
      self.view.addSubview(PuzzleMakerTabBarBannerView)
      self.view.bringSubviewToFront(PuzzleMakerTabBarBannerView)
      
      PuzzleMakerTabBarBannerView.rootViewController = self
      PuzzleMakerTabBarBannerView.delegate = self
      
      let frame = { () -> CGRect in
         return view.frame.inset( by: view.safeAreaInsets)
      }()
      let viewWidth = frame.size.width
      let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
      BANNER_VIEW_HIGHT = adSize.size.height
      PuzzleMakerTabBarBannerView.adSize = adSize
      PuzzleMakerTabBarBannerView.load(BannerViewReqest)
   }
   
   private func InitBGM() {
      self.GameBGM = BGM()
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
   
   @objc func StartHomeBGMCatchNotification(notification: Notification) -> Void {
      if let bgm = GameBGM {
         if bgm.Hight_Tech.isPlaying == false {
            print("BGMついてないから再生します。")
            StartBGM()
         }
      }else{
         print("BGMにnil入っててんけど？")
      }
   }
   
   private func getHouseImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "house")!
      }else{
         return UIImage(named: "play.png")!
      }
   }
   
   private func getHouseFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "house.fill")!
      }else{
         return UIImage(named: "play_fill.png")!
      }
   }
   
   private func getPlayImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "play.circle")!
      }else{
         return UIImage(named: "play.png")!
      }
   }
   
   private func getPlayFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "play.circle.fill")!
      }else{
         return UIImage(named: "play_fill.png")!
      }
   }
   
   
   
   
   private func getCreateImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "hammer")!
      }else{
         return UIImage(named: "hammer.png")!
      }
   }
   
   private func getCreateFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "hammer.fill")!
      }else{
         return UIImage(named: "hammer_fill.png")!
      }
   }
   
   
   
   private func getCartImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "cart")!
      }else{
         return UIImage(named: "cart.png")!
      }
   }
   
   private func getCartFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "cart.fill")!
      }else{
         return UIImage(named: "cart_fill.png")!
      }
   }
   
   
   
   private func getSettingImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "person")!
      }else{
         return UIImage(named: "person.png")!
      }
   }
   
   private func getSettingFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "person.fill")!
      }else{
         return UIImage(named: "person_fill.png")!
      }
   }
   
   //MARK:- ADMOB
   /// Tells the delegate an ad request loaded an ad.
   func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("広告(banner)のロードが完了しました。")
      self.PuzzleMakerTabBarBannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
         self.PuzzleMakerTabBarBannerView.alpha = 1
      })
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
