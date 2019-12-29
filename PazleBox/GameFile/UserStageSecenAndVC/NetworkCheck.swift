//
//  NetworkCheck.swift
//  PazleBox
//
//  Created by jun on 2019/12/16.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import Reachability

class NetworkCheck {

   func isOnline() -> Bool {
      var reachability: Reachability?
      
      do {
         reachability = try Reachability()
      } catch {
         print("エラーキャッチ")
         return false
      }
      
      if let reach = reachability {
         if reach.connection == .unavailable {
            return false
         } else {
            return true
         }
      } else {
         print("reachにnil入ってた")
         return false
      }
      
   }
}
