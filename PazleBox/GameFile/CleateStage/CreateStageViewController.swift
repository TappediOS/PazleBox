//
//  CreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import UIKit

class CleateStageViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
   }
   
   private func InitBackTileImageView() {
      let BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView)
   }
}

