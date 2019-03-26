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
   var p23p7: [[Contents]] = Array()
   var p23p8: [[Contents]] = Array()
   var p23p9: [[Contents]] = Array()
   var p23p10: [[Contents]] = Array()
   var p23p11: [[Contents]] = Array()
   var p23p12: [[Contents]] = Array()
   
   var p32p1: [[Contents]] = Array()
   var p32p2: [[Contents]] = Array()
   var p32p3: [[Contents]] = Array()
   var p32p4: [[Contents]] = Array()
   var p32p5: [[Contents]] = Array()
   var p32p6: [[Contents]] = Array()
   var p32p7: [[Contents]] = Array()
   var p32p8: [[Contents]] = Array()
   var p32p9: [[Contents]] = Array()
   var p32p10: [[Contents]] = Array()
   var p32p11: [[Contents]] = Array()
   var p32p12: [[Contents]] = Array()
   
   var p33p1: [[Contents]] = Array()
   var p33p2: [[Contents]] = Array()
   var p33p3: [[Contents]] = Array()
   var p33p4: [[Contents]] = Array()
   var p33p5: [[Contents]] = Array()
   var p33p6: [[Contents]] = Array()
   var p33p7: [[Contents]] = Array()
   var p33p8: [[Contents]] = Array()
   var p33p9: [[Contents]] = Array()
   var p33p10: [[Contents]] = Array()
   var p33p11: [[Contents]] = Array()
   var p33p12: [[Contents]] = Array()
   var p33p13: [[Contents]] = Array()
   var p33p14: [[Contents]] = Array()
   var p33p15: [[Contents]] = Array()
   var p33p16: [[Contents]] = Array()
   var p33p17: [[Contents]] = Array()
   var p33p18: [[Contents]] = Array()
   var p33p19: [[Contents]] = Array()
   var p33p20: [[Contents]] = Array()
   var p33p21: [[Contents]] = Array()
   var p33p22: [[Contents]] = Array()
   
   var p42p1: [[Contents]] = Array()
   
   var p43p1: [[Contents]] = Array()
   var p43p2: [[Contents]] = Array()
   
   
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
      
      p23p7 = [[.In, .Out],
               [.In, .In],
               [.In, .In],]
      
      p23p8 = [[.Out, .In],
               [.In, .In],
               [.In, .In],]
      
      p23p9 = [[.In, .In],
               [.In, .In],
               [.In, .Out],]
      
      p23p10 = [[.In, .In],
               [.In, .In],
               [.Out, .In],]
      
      p23p11 = [[.In, .Out],
               [.In, .In],
               [.Out, .In],]
      
      p23p12 = [[.Out, .In],
               [.In, .In],
               [.In, .Out],]
      
      
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
      
      p32p7 = [[.In, .In, .In],
               [.In, .In, .Out]]
      
      p32p8 = [[.In, .In, .Out],
               [.In, .In, .In]]
      
      p32p9 = [[.In, .In, .In],
               [.Out, .In, .In]]
      
      p32p10 = [[.Out, .In, .In],
               [.In, .In, .In]]
      
      p32p11 = [[.Out, .In, .In],
               [.In, .In, .Out]]
      
      p32p12 = [[.In, .In, .Out],
               [.Out, .In, .In]]
      
      
      
      p33p1 = [[.Out, .In, .Out],
               [.In, .In, .In],
               [.Out, .In, .Out]]
      
      p33p2 = [[.In, .In, .In],
               [.Out, .In, .Out],
               [.Out, .In, .Out]]
      
      p33p3 = [[.In, .Out, .Out],
               [.In, .In, .In],
               [.In, .Out, .Out]]
      
      p33p4 = [[.Out, .In, .Out],
               [.Out, .In, .Out],
               [.In, .In, .In]]
      
      p33p5 = [[.Out, .Out, .In],
               [.In, .In, .In],
               [.Out, .Out, .In]]
      
      p33p6 = [[.In, .In, .In],
               [.In, .Out, .Out],
               [.In, .Out, .Out]]
      
      p33p7 = [[.In, .Out, .Out],
               [.In, .Out, .Out],
               [.In, .In, .In]]
      
      p33p8 = [[.Out, .Out, .In],
               [.Out, .Out, .In],
               [.In, .In, .In]]
      
      p33p9 = [[.In, .In, .In],
               [.Out, .Out, .In],
               [.Out, .Out, .In]]
      
      p33p10 = [[.In, .In, .In],
               [.In, .In, .Out],
               [.In, .Out, .Out]]
      
      p33p11 = [[.In, .Out, .Out],
               [.In, .In, .Out],
               [.In, .In, .In]]
      
      p33p12 = [[.In, .In, .In],
               [.Out, .In, .In],
               [.Out, .Out, .In]]
      
      p33p13 = [[.Out, .In, .In],
               [.Out, .In, .Out],
               [.In, .In, .Out]]
      
      p33p14 = [[.In, .In, .Out],
               [.Out, .In, .Out],
               [.Out, .In, .In]]
      
      p33p15 = [[.Out, .In, .In],
               [.Out, .In, .Out],
               [.In, .In, .Out]]
      
      p33p16 = [[.In, .Out, .Out],
               [.In, .In, .Out],
               [.Out, .In, .In]]
      
      p33p17 = [[.In, .Out, .Out],
               [.In, .In, .Out],
               [.Out, .In, .In]]
      
      p33p18 = [[.In, .Out, .In],
               [.Out, .In, .Out],
               [.In, .Out, .In]]
      
      p33p19 = [[.In, .In, .In],
               [.In, .Out, .Out],
               [.In, .In, .Out]]
      
      p33p20 = [[.In, .Out, .Out],
               [.In, .Out, .In],
               [.In, .In, .In]]
      
      p33p21 = [[.Out, .In, .In],
               [.Out, .Out, .In],
               [.In, .In, .In]]
      
      p33p22 = [[.In, .In, .In],
               [.In, .Out, .In],
               [.Out, .Out, .In]]
      
      p42p1 =  [[.In, .Out, .In, .In],
                [.In, .Out, .In, .In]]
      
      p43p1 =  [[.In, .In, .In, .In],
                [.In, .Out, .Out, .Out],
                [.In, .Out, .Out, .Out]]
      
      p43p1 =  [[.Out, .Out, .In, .Out],
                [.In, .In, .In, .In],
                [.In, .Out, .Out, .Out]]

      

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
      case "23p7":
         return p23p7
      case "23p8":
         return p23p8
      case "23p9":
         return p23p9
      case "23p10":
         return p23p10
      case "23p11":
         return p23p11
      case "23p12":
         return p23p12
         
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
      case "32p7":
         return p32p7
      case "32p8":
         return p32p8
      case "32p9":
         return p32p9
      case "32p10":
         return p32p10
      case "32p11":
         return p32p11
      case "32p12":
         return p32p12
      
         
      case "33p1":
         return p33p1
      case "33p2":
         return p33p2
      case "33p3":
         return p33p3
      case "33p4":
         return p33p4
      case "33p5":
         return p33p5
      case "33p6":
         return p33p6
      case "33p7":
         return p33p7
      case "33p8":
         return p33p8
      case "33p9":
         return p33p9
      case "33p10":
         return p33p10
      case "33p11":
         return p33p11
      case "33p12":
         return p33p12
      case "33p13":
         return p33p13
      case "33p14":
         return p33p14
      case "33p15":
         return p33p15
      case "33p16":
         return p33p16
      case "33p17":
         return p33p17
      case "33p18":
         return p33p18
      case "33p19":
         return p33p19
      case "33p20":
         return p33p20
      case "33p21":
         return p33p21
      case "33p22":
         return p33p22
         
      case "42p1":
         return p42p1
         
      case "43p1":
         return p43p1
      case "43p2":
         return p43p2
      default:
         fatalError("PuzzleStyle = \(PuzzleStyle)")
      }
   }
}
