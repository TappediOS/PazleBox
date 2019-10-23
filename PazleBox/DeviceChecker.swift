//
//  DeviceChecker.swift
//  PazleBox
//
//  Created by jun on 2019/06/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class DviceChecker {
   
   public func isIphoneXsOrIphoneXsMax() -> Bool {
      switch UIScreen.main.nativeBounds.height {
      case 1136:
         print("iPhone 5 or 5S or 5C")
         return false
      case 1334:
         print("iPhone 6/6S/7/8")
         return false
      case 1920, 2208:
         print("iPhone 6+/6S+/7+/8+")
         return false
      case 2436:
         print("iPhone X, XS, 11")
         return true
      case 2688:
         print("iPhone XS/11 Max")
         return true
      case 1792:
         print("iPhone XR / 11")
         return true
      default:
         print("Unknown")
         return false
      }
   }
}
