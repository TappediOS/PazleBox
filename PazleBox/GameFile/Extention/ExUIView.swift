//
//  ExUIView.swift
//  PazleBox
//
//  Created by jun on 2019/03/31.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

enum FadeType: TimeInterval {
   case
   Normal = 0.85,
   Slow = 2.52
}

extension UIView {
   func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil) {
      fadeIn(duration: type.rawValue, completed: completed)
   }
   
   /** For typical purpose, use "public func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
   func fadeIn(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
      alpha = 0
      isHidden = false
      UIView.animate(withDuration: duration,
                                 animations: {
                                    self.alpha = 1
      }) { finished in
         completed?()
      }
   }
   func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil) {
      fadeOut(duration: type.rawValue, completed: completed)
   }
   /** For typical purpose, use "public func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
   func fadeOut(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
      UIView.animate(withDuration: duration
         , animations: {
            self.alpha = 0
      }) { [weak self] finished in
         self?.isHidden = true
         self?.alpha = 1
         completed?()
      }
   }
}
