//
//  PuzzleMakerTapToPlayViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class PuzzleMakerTapToPlayViewController: UIViewController, UIGestureRecognizerDelegate {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      InitTapGesture()
   }
   
   func InitTapGesture() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TappedView(_:)))
      tapGesture.delegate = self
      self.view.addGestureRecognizer(tapGesture)
   }
   
   @objc func TappedView(_ sender: UITapGestureRecognizer) {
      if sender.state == .ended {
         print("タップされました2")
      }
   }
   
}
