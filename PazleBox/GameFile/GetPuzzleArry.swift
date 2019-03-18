//
//  GetPuzzleArry.swift
//  PazleBox
//
//  Created by jun on 2019/03/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class PArry {
   
   var p231: [[Contents]] = Array()
   var p232: [[Contents]] = Array()
   var p233: [[Contents]] = Array()
   
   
   var p321: [[Contents]] = Array()
   
   init() {
      
      p231 = [[.In, .In],
              [.In, .Out],
              [.In, .In],]
      
      p232 = [[.Out, .In],
              [.In, .Out],
              [.In, .In],]
      
      p233 = [[.In, .In],
              [.In, .Out],
              [.In, .Out],]
      
      p321 = [[.In, .In, .In],
              [.Out, .Out, .In]]
   }
   
   public func GerPArry(TextureName: String) -> [[Contents]] {
      
      switch TextureName {
      case "P231":
         return p231
      case "P232":
         return p232
      case "P233":
         return p233
      case "P321":
         return p321
      default:
         return p231
      }
   }
}
