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
   var ContentsArry: [[Contents]] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
      SetUpPutPiceImageBasedOnBeforeView()
   }
   
   private func InitBackTileImageView() {
      let BackImageView = BackTileImageViewIncludeBaseImage(frame: self.view.frame, ContentArry: ContentsArry)
      self.view.addSubview(BackImageView)
   }
   
   private func SetUpPutPiceImageBasedOnBeforeView() {
   }
}
