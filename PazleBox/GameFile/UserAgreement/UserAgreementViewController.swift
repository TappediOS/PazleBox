//
//  UserAgreementViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class UserAgreementViewController: UIViewController {
   var BackGroundImageView: BackGroundImageViews?
   var UserAgreementViewFrame = CGRect()
   var AgreeView: UserAgreementView?
   
   var SoundVolume: Float = 0.17
   
   private var BGM: AVAudioPlayer! = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.hero.isEnabled = true
      InitNotificationCenter()
      InitBGM()
      InitAgreementViewSizeSetting()
      InitBackgroundImageView()
      InitUserAgreementView()
      StartBGM()
   }
   
   private func InitNotificationCenter() {
       NotificationCenter.default.addObserver(self, selector: #selector(TapAcceptChatchNotification(notification:)), name: .AcceptUserAgreement, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(showTabBarCatchNotification(notificaton:)), name: .showTabBar, object: nil)
   }
   
   private func InitBGM() {
      let soundFilePath = Bundle.main.path(forResource: "Hight_Tech", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      do {
         BGM = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch { print("Hight_Techインスタンス作成失敗") }
      
      BGM.prepareToPlay()
      BGM.numberOfLoops = -1
      BGM.volume = SoundVolume
   }
   
   private func InitAgreementViewSizeSetting() {
      let StartX = view.frame.width / 16
      let StartY = view.frame.height / 4
      let ViewSize = view.frame.width / 16 * 14
      UserAgreementViewFrame = CGRect(x: StartX, y: StartY, width: ViewSize, height: ViewSize)
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func InitUserAgreementView() {
      AgreeView = UserAgreementView(frame: UserAgreementViewFrame)
      AgreeView?.center.y = view.center.y
      AgreeView?.center.x = view.center.x
      self.view.addSubview(AgreeView!)
      AgreeView?.fadeIn(type: .Normal, completed: nil)
   }
   
   private func StartBGM() {
      BGM.stop()
      BGM.currentTime = 0
      BGM.volume = SoundVolume
      BGM.play()
   }
   
   //MARK:- タブバーに遷移する処理
   //NOTE:- もし，チュートリアルの画面に遷移するんやったらここでいいんじゃね。
   @objc func TapAcceptChatchNotification(notification: Notification) {
      print("Tap Accept UserAgreement")
      print("\nTutorialに遷移します。")
      
      let Storybord = UIStoryboard(name: "TutorialViewController", bundle: nil)
      let TutorialVC = Storybord.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialViewController
      TutorialVC.modalPresentationStyle = .fullScreen
      TutorialVC.modalTransitionStyle = .crossDissolve
      self.AgreeView?.fadeOut(type: .Normal, completed: {
         self.AgreeView?.removeFromSuperview()
         self.present(TutorialVC, animated: true, completion: {
            print("TutorialVCにプレゼント終わった")
         })
      })
   }
   
   private func fadeOutBGM(fromVolume startVolume : Float, toVolume endVolume : Float, overTime time : TimeInterval) {
      let stepsPerSecond = 100
      // Update the volume every 1/100 of a second
      let fadeSteps = Int(time * TimeInterval(stepsPerSecond))
      // Work out how much time each step will take
      let timePerStep = TimeInterval(1.0 / Double(stepsPerSecond))

      BGM.volume = startVolume;
      
      // Schedule a number of volume changes
      for step in 0...fadeSteps {
         
         let delayInSeconds : TimeInterval = TimeInterval(step) * timePerStep
         let deadline = DispatchTime.now() + delayInSeconds
         //もしendVolumeが0だったら，最後にプレイヤーを停止する。
         //startVolumeが0の時にif文走らないようにする
         DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            let fraction = (Float(step) / Float(fadeSteps))
            self.BGM.volume = startVolume + (endVolume - startVolume) * fraction
            if self.BGM.volume == 0 && endVolume == 0 {
               print("\(String(describing: self.BGM))を止めました。")
               self.BGM.stop()
               self.BGM.currentTime = 0
            }
         })
      }
   }
   
   @objc func showTabBarCatchNotification (notificaton: Notification) {
      fadeOutBGM(fromVolume: BGM.volume, toVolume: 0, overTime: 3)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("\n-----タブバー表示する通知ゲット!!!-----\n")
        let Storybord = UIStoryboard(name: "Main", bundle: nil)
        let PuzzleTabBarC = Storybord.instantiateViewController(withIdentifier: "PuzzleTabBarC") as! PuzzleTabBarController
        PuzzleTabBarC.modalPresentationStyle = .fullScreen
        PuzzleTabBarC.modalTransitionStyle = .crossDissolve
        self.present(PuzzleTabBarC, animated: true, completion: {
           print("PuzzleTabBarCにプレゼント終わった")
        })
      }
      
   }
}
