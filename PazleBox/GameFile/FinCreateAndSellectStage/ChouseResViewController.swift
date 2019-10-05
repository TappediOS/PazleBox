//
//  ChouseResViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/05.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import TapticEngine
import FlatUIKit

class ChouseResViewController: UIViewController {
   
   var PiceImageArray: [PiceImageView] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
   }
   
   private func InitBackTileImageView() {
      let BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView)
   }
}
