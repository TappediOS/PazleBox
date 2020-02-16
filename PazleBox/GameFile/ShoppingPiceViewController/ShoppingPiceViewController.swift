//
//  ShoppingPiceViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class ShoppingPiceViewController: UIViewController {
   var BackGroundImageView: BackGroundImageViews?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      InitBackgroundImageView()
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
}
