//
//  UserAgreementViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserAgreementViewController: UIViewController {
   var BackGroundImageView: BackGroundImageViews?
   var UserAgreementViewFrame = CGRect()
   var AgreeView: UserAgreementView?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.hero.isEnabled = true
      InitNotificationCenter()
      InitAgreementViewSizeSetting()
      InitBackgroundImageView()
      InitUserAgreementView()
   }
   
   private func InitNotificationCenter() {
       NotificationCenter.default.addObserver(self, selector: #selector(TapAcceptChatchNotification(notification:)), name: .AcceptUserAgreement, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(showTabBarCatchNotification(notificaton:)), name: .showTabBar, object: nil)
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
   
   @objc func showTabBarCatchNotification (notificaton: Notification) {
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
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
