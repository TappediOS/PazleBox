//
//  TabBarViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class PuzzleTabBarController: ESTabBarController {
   
   var image = UIImage()
   var selectedImage = UIImage()
   
   private var GameBGM: BGM?
   let GameSound = GameSounds()
   
   //viewWillAppearで初期化しているから，dismissしたときに複数回初期化することになるのを防ぐ.
   var firstOpenForBGM = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitNotificationCenter()
      
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
      if firstOpenForBGM {
         InitBGM()
         StartBGM()
         firstOpenForBGM = false
      }
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      //戻ってきた時についてなかったらさいせい
      if !GameBGM!.Hight_Tech.isPlaying {
         print("BGMついてないから再生します。")
         StartBGM()
      }
      
   }
    
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      
      image = getPlayImage()
      selectedImage = getPlayFillImage()
      
      var title = NSLocalizedString("Play", comment: "")
      let Storybord = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let PlayVC = Storybord.instantiateViewController(withIdentifier: "SellectCreateStageViewController")
      PlayVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                           image: image, selectedImage: selectedImage, tag: 1)
      
      PlayVC.tabBarItem.accessibilityIdentifier = "tabBar_Play"

      
      image = getCreateImage()
      selectedImage = getCreateFillImage()
      title = NSLocalizedString("Create", comment: "")
      let CreateVC = Storybord.instantiateViewController(withIdentifier: "StageMakingVC")
      CreateVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                              image: image, selectedImage: selectedImage, tag: 2)
      CreateVC.tabBarItem.accessibilityIdentifier = "tabBar_Create"
      
      
      image = getSettingImage()
      selectedImage = getSettingFillImage()
      title = NSLocalizedString("Setting", comment: "")
      //TODO: ここのVCを作ってせっていしよう
      //TODO: staticTableViewがいいかなー
      let MainStorybord = UIStoryboard(name: "Main", bundle: nil)
      let SettingVC = MainStorybord.instantiateViewController(withIdentifier: "SettingTableVC")
      SettingVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                                image: image, selectedImage: selectedImage, tag: 3)
      SettingVC.tabBarItem.accessibilityIdentifier = "tabBar_Setting"
      
      self.viewControllers = [PlayVC, CreateVC, SettingVC]
      self.selectedViewController = CreateVC
      self.selectedIndex = 1
   }
   
   //MARK: 通知の初期化
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(StopHomeBGMCatchNotification(notification:)), name: .StopHomeViewBGM, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(StartHomeBGMCatchNotification(notification:)), name: .StartHomeViewBGM, object: nil)
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
      if !GameBGM!.Hight_Tech.isPlaying {
         print("BGMついてないから再生します。")
         StartBGM()
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
}
