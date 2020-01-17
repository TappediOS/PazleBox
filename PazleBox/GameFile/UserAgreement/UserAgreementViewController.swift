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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitNotificationCenter()
      InitAgreementViewSizeSetting()
      InitBackgroundImageView()
      InitUserAgreementView()
   }
   
   private func InitNotificationCenter() {
       NotificationCenter.default.addObserver(self, selector: #selector(TapAcceptChatchNotification(notification:)), name: .AcceptUserAgreement, object: nil)
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
      let AgreeView = UserAgreementView(frame: UserAgreementViewFrame)
      AgreeView.center.y = view.center.y
      AgreeView.center.x = view.center.x
      self.view.addSubview(AgreeView)
   }
   
   
   //MARK:- タブバーに遷移する処理
   //NOTE:- もし，チュートリアルの画面に遷移するんやったらここでいいんじゃね。
   @objc func TapAcceptChatchNotification(notification: Notification) {
      print("Tap Accept UserAgreement")
      print("\nTutorialに遷移します。")
      
      let Storybord = UIStoryboard(name: "TutorialViewController", bundle: nil)
      let TutorialVC = Storybord.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialViewController
      TutorialVC.modalPresentationStyle = .fullScreen
      self.present(TutorialVC, animated: true, completion: {
         print("TutorialVCにプレゼント終わった")
      })
      
      //これはTabに行く処理
//      let Storybord = UIStoryboard(name: "Main", bundle: nil)
//      let PuzzleTabBarC = Storybord.instantiateViewController(withIdentifier: "PuzzleTabBarC") as! PuzzleTabBarController
//      PuzzleTabBarC.modalPresentationStyle = .fullScreen
//      self.present(PuzzleTabBarC, animated: true, completion: {
//         print("PuzzleTabBarCにプレゼント終わった")
//      })
   }
   
}
