//
//  GameViewController.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SAConfettiView
import Firebase

class GameViewController: UIViewController, GADRewardBasedVideoAdDelegate {
   
   var ConfettiView = SAConfettiView()
   var ClearView: GameClearView?
   
   let GameClearVeiwIntensity: Float = 0.65
   var ShowGameClearView = false
   
   var StageLevel: StageLevel = .Normal
   var SellectStageNumber = 0

   var EasySelect = SellectStageEasy()
   var ViewFrame: CGRect?
   
   let StarAnimationBetTime = 0.45
   
   
   var Reward: GADRewardBasedVideoAd!
   let REWARD_TEST_ID = "ca-app-pub-3940256099942544/1712485313"
   let REWARD_ID = "ca-app-pub-1460017825820383/8389602396"
   
   //MARK: user defaults
   var userDefaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
      
      ViewFrame = self.view.frame
      
      LoadStageLevel()
      
      InitNotificationCenter()
      InitStageSellectView()
      
      InitConfettiView()
      
      InitGameClearView()
      
      InitRewardView()
      
   }
   
   private func InitGameClearView() {
      ClearView = GameClearView(frame: ViewFrame!)
   }
   
   private func InitRewardView() {
      
      Reward = GADRewardBasedVideoAd.sharedInstance()
      Reward?.delegate = self
      #if DEBUG
      print("リワード:テスト環境")
      Reward.load(GADRequest(), withAdUnitID: REWARD_TEST_ID)
      print("ID = \(REWARD_TEST_ID)")
      #else
      print("リワード:本番環境")
      Reward.load(GADRequest(), withAdUnitID: REWARD_ID)
      print("ID = \(REWARD_ID)")
      #endif
      

   }
   
   private func InitStageSellectView() {
      //FIXME:- クラス作ったら直す
      switch StageLevel {
      case .Easy:
         EasySelect.InitView(frame: self.view.frame)
         self.view.addSubview(EasySelect)
      case .Normal:
         EasySelect.InitView(frame: self.view.frame)
         self.view.addSubview(EasySelect)
      case .Hard:
         EasySelect.InitView(frame: self.view.frame)
         self.view.addSubview(EasySelect)
      }
   }
   
   private func LoadStageNumber(Num: Int) {
      SellectStageNumber = Num
      userDefaults.set(Num, forKey: "StageNum")
   }
   
   private func LoadStageLevel() {

      print("StageLevel = \(StageLevel)")
      
      switch StageLevel {
      case .Easy:
         userDefaults.set(1, forKey: "SelectedStageLevel")
      case .Normal:
         userDefaults.set(2, forKey: "SelectedStageLevel")
      case .Hard:
         userDefaults.set(3, forKey: "SelectedStageLevel")
      }
      
      
   }

   
   private func InitGameViewAndShowView() {
      
      print("GameSene，GameViewの初期化開始")
      if let scene = GKScene(fileNamed: "GameScene") {
            
         // Get the SKScene from the loaded GKScene
         if let sceneNode = scene.rootNode as! GameScene? {
            
            sceneNode.scaleMode = GetSceneScalaMode(DeviceHeight: UIScreen.main.nativeBounds.height)
            
            
            // Present the scene
            if let view = self.view as! SKView? {
                  
               sceneNode.userData = NSMutableDictionary()
               sceneNode.userData?.setValue(StageLevel, forKey: "StageNum")

               view.ignoresSiblingOrder = true
               
               let Tran = SKTransition.fade(withDuration: 2.35)
               
               
               
               view.presentScene(sceneNode, transition: Tran)
               
               
               view.showsDrawCount = true
               view.showsQuadCount = true
                  
               view.showsFPS = true
               view.showsNodeCount = true
            }
         }
      }
      print("GameSene，GameViewの初期化完了")
   }
   
   private func GetSceneScalaMode(DeviceHeight: CGFloat) -> SKSceneScaleMode {
      
      if UIDevice.current.userInterfaceIdiom == .pad { return .fill }
      
      switch DeviceHeight {
      case 2436.0:
         return .fill
      case 1792.0:
         return .fill
      case 2688.0:
         return .fill
      default:
         return .aspectFill
      }
   }
   
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(GameClearCatchNotification(notification:)), name: .GameClear, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(SellectStageNotification(notification:)), name: .SellectStage, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(SellectBackNotification(notification:)), name: .SellectBack, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(RewardADNotification(notification:)), name: .RewardAD, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapNextNotification(notification:)), name: .TapNext, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapHomeNotification(notification:)), name: .TapHome, object: nil)
      
   }
   
   private func InitConfettiView() {
      let Rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      ConfettiView = SAConfettiView(frame: Rect)
      ConfettiView.intensity = GameClearVeiwIntensity
      ConfettiView.type! = .star
      ConfettiView.isUserInteractionEnabled = false
   }
   
   private func StartConfetti(){
      self.view?.addSubview(ConfettiView)
      ConfettiView.startConfetti()
      ShowGameClearView = true
   }
   
   private func StopConfitti() {
      ConfettiView.stopConfetti()
      ShowGameClearView = false
//      GameClearView.removeFromSuperview()
   }
   
   
   private func StartStarAnimation(CountOfUsedHint: Int) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
         self.ClearView?.StartAnimationView1()
      }
      
      if CountOfUsedHint == 2 { return }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime) {
         self.ClearView?.StartAnimationView2()
      }
      
      if CountOfUsedHint == 1 { return }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime * Double(2)) {
         self.ClearView?.StartAnimationView3()
      }
   }
   
   private func StartConfeAnimation(CountOfUsedHint: Int) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
         self.ClearView?.StartConfe1()
      }
      if CountOfUsedHint == 2 { return }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime) {
         self.ClearView?.StartConfe2()
      }
      if CountOfUsedHint == 1 { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime * Double(2)) {
         self.ClearView?.StartConfe3()
      }
   }
   
   private func ShowGameClearViewWithStar(CountOfUsedHint: Int) {
      self.StartStarAnimation(CountOfUsedHint: CountOfUsedHint)
      self.StartConfeAnimation(CountOfUsedHint: CountOfUsedHint)
   }
   
   @objc func GameClearCatchNotification(notification: Notification) -> Void {
      
      guard ShowGameClearView == false else { return }
      
      var CountOfUsedHint = 0
      
      if let userInfo = notification.userInfo {
         CountOfUsedHint = userInfo["CountOfUsedHint"] as! Int
      }else{
         print("Nil きたよ")
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
         self.StartConfetti()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
         
         self.view.addSubview(self.ClearView!)
         self.view.bringSubviewToFront(self.ConfettiView)
         self.ClearView?.AddStarView1()
         self.ClearView?.AddStarView2()
         self.ClearView?.AddStarView3()
         self.ClearView?.AddKiraView1()
         self.ClearView?.AddKiraView2()
         self.ClearView?.AddKiraView3()
         self.ClearView?.AddConfiView1()
         self.ClearView?.AddConfiView2()
         self.ClearView?.AddConfiView3()
         self.ClearView?.fadeIn(type: .Slow) { [weak self] in
            self?.ShowGameClearViewWithStar(CountOfUsedHint: CountOfUsedHint)
         }
      }
      return
   }
   
   @objc func SellectStageNotification(notification: Notification) -> Void {
      
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["StageNum"] as! Int
         print("送信者番号: \(SentNum)")
         
         LoadStageNumber(Num: SentNum)
         InitGameViewAndShowView()
         
         self.EasySelect.removeFromSuperview()
         
         
      }else{
         print("通知受け取ったけど、中身nilやった。")
      }
   }
   
   @objc func RewardADNotification(notification: Notification) -> Void {
      if Reward.isReady == true {
         Reward.present(fromRootViewController: self)
      }
   }
   
   @objc func TapNextNotification(notification: Notification) -> Void {

      ShowNextGame()
   }
   
   @objc func TapHomeNotification(notification: Notification) -> Void {
      
      self.dismiss(animated: false, completion: nil)
   }
   
   private func ShowNextGame() {
      
      
      self.ClearView?.fadeOut(type: .Slow){ [weak self] in
         self?.ClearView?.StopConfi()
         self?.ClearView?.StopStar()
         self?.ClearView?.removeFromSuperview()
      }
    
      self.SellectStageNumber += 1
      self.userDefaults.set(self.SellectStageNumber, forKey: "StageNum")
      self.StopConfitti()
      self.InitGameViewAndShowView()
      
      self.InitGameClearView()
   }
   
   
   
   
   
   
   
   
   
   
   
   
   private func PostNotificationFinAdWatch() {
      NotificationCenter.default.post(name: .FinRewardWatch, object: nil, userInfo: nil)
   }
   
   //AD
   func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
      print("報酬与えます")
      PostNotificationFinAdWatch()
   }
   
   func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
      print("広告受け取った")
      
   }
   
   func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("広告開いた")
   }
   
   func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("再生スタート")
   }
   
   func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("広告全部見終わった")
   }
   
   func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      #if DEBUG
      print("リワード再読み込み:テスト環境")
      Reward.load(GADRequest(), withAdUnitID: REWARD_TEST_ID)
      print("読み込んだID: \(REWARD_TEST_ID)")
      #else
      print("リワード再読み込み:本番環境")
      Reward.load(GADRequest(), withAdUnitID: REWARD_ID)
      #endif
   }
   
   func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("アプリ離れた")
   }
   
   func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
      print("広告ロード失敗")
   }
   
   
   
   
   
   
   @objc func SellectBackNotification(notification: Notification) -> Void {
      
      self.dismiss(animated: true, completion: nil)
   }
   


    override var shouldAutorotate: Bool {return true}

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool { return true }
}
