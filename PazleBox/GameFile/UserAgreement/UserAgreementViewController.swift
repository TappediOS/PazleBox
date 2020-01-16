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
      
      InitAgreementViewSizeSetting()
      InitBackgroundImageView()
      InitUserAgreementView()
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
}
