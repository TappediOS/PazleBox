//
//  GetPuzzleArry.swift
//  PazleBox
//
//  Created by jun on 2019/03/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class PArry {
   
   var p12p1: [[Contents]] = Array()
   
   var p21p1: [[Contents]] = Array()
   
   var p22p1: [[Contents]] = Array()
   var p22p2: [[Contents]] = Array()
   var p22p3: [[Contents]] = Array()
   var p22p4: [[Contents]] = Array()
   var p22p5: [[Contents]] = Array()
   
   var p23p1: [[Contents]] = Array()
   var p23p2: [[Contents]] = Array()
   var p23p3: [[Contents]] = Array()
   var p23p4: [[Contents]] = Array()
   var p23p5: [[Contents]] = Array()
   var p23p6: [[Contents]] = Array()
   
   var p32p1: [[Contents]] = Array()
   var p32p2: [[Contents]] = Array()
   var p32p3: [[Contents]] = Array()
   var p32p4: [[Contents]] = Array()
   var p32p5: [[Contents]] = Array()
   var p32p6: [[Contents]] = Array()
   
   
   init() {
      
      p12p1 = [[.In],
               [.In]]
      
      
      p21p1 = [[.In, .In]]
      
      
      
      p22p1 = [[.In, .In],
               [.In, .In]]
      
      p22p2 = [[.In, .In],
               [.In, .Out]]
      
      p22p3 = [[.In, .Out],
               [.In, .In]]
      
      p22p4 = [[.In, .In],
               [.Out, .In]]
      
      p22p5 = [[.Out, .In],
               [.In, .In]]
      
      
      
      p23p1 = [[.In, .In],
               [.In, .Out],
               [.In, .Out],]
      
      p23p2 = [[.In, .Out],
               [.In, .Out],
               [.In, .In],]
      
      p23p3 = [[.Out, .In],
               [.Out, .In],
               [.In, .In],]
      
      p23p4 = [[.In, .In],
               [.Out, .In],
               [.Out, .In],]
      
      p23p5 = [[.In, .In],
               [.In, .Out],
               [.In, .In],]
      
      p23p6 = [[.In, .In],
               [.Out, .In],
               [.In, .In],]
      
      
      p32p1 = [[.In, .In, .In],
               [.In, .Out, .Out]]
      
      p32p2 = [[.In, .Out, .Out],
               [.In, .In, .In]]
      
      p32p3 = [[.In, .In, .In],
               [.Out, .Out, .In]]
      
      p32p4 = [[.Out, .Out, .In],
               [.In, .In, .In]]
      
      p32p5 = [[.In, .In, .In],
               [.In, .Out, .In]]
      
      p32p6 = [[.In, .Out, .In],
               [.In, .In, .In]]
      

   }
   
   public func GerPArry(PuzzleStyle: String) -> [[Contents]] {
      
      print(PuzzleStyle)
      
      switch PuzzleStyle {
      case "12p1":
         return p12p1
         
      case "21p1":
         return p21p1
         
      case "22p1":
         return p22p1
      case "22p2":
         return p22p2
      case "22p3":
         return p22p3
      case "22p4":
         return p22p4
      case "22p5":
         return p22p5
         
      case "23p1":
         return p23p1
      case "23p2":
         return p23p2
      case "23p3":
         return p23p3
      case "23p4":
         return p23p4
      case "23p5":
         return p23p5
      case "23p6":
         return p23p6
         
      case "32p1":
         return p32p1
      case "32p2":
         return p32p2
      case "32p3":
         return p32p3
      case "32p4":
         return p32p4
      case "32p5":
         return p32p5
      case "32p6":
         return p32p6
      default:
         fatalError("PuzzleStyle = \(PuzzleStyle)")
      }
   }
}
