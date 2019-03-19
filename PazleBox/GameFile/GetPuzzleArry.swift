//
//  GetPuzzleArry.swift
//  PazleBox
//
//  Created by jun on 2019/03/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class PArry {
   
   var p23p1: [[Contents]] = Array()
   var p23p2: [[Contents]] = Array()
   
   var p32p1: [[Contents]] = Array()
   var p32p2: [[Contents]] = Array()
   var p32p3: [[Contents]] = Array()
   
   
   init() {
      
      p23p1 = [[.In, .In],
               [.In, .In],
               [.In, .In],]
      
      p23p1 = [[.In, .In],
               [.In, .Out],
               [.In, .Out],]
      
      p23p2 = [[.In, .Out],
               [.In, .Out],
               [.In, .In],]
      
      
      p32p1 = [[.In, .Out, .Out],
               [.In, .In, .In]]
      
      p32p2 = [[.Out, .Out, .In],
               [.In, .In, .In]]
      
      p32p3 = [[.In, .In, .In],
               [.Out, .Out, .In]]
      

   }
   
   public func GerPArry(PuzzleStyle: String) -> [[Contents]] {
      
      print(PuzzleStyle)
      
      switch PuzzleStyle {
      case "23p1":
         return p23p1
      case "23p2":
         return p23p2
      case "32p1":
         return p32p1
      case "32p2":
         return p32p2
      case "32p3":
         return p32p3
      default:
         fatalError("PuzzleStyle = \(PuzzleStyle)")
      }
   }
}
