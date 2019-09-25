//
//  GetPiceposition.swift
//  PazleBox
//
//  Created by jun on 2019/09/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class GetPicePosi {
   
   private var FoundX: Int = 0
   private var Intarnal: Int = 0
   private var FoundY: Int = 0
   private var HalfView: Int = 0
   private var ViewY: Int = 0
   
   private var ViewStartY: Int = 0
   
   private var X: [CGFloat] = Array()
   private var Y: [CGFloat] = Array()
   
   init(ViewX: Int, ViewY: Int){
      
      FoundX = ViewX / 10
      Intarnal = FoundX / 10
      
      let AllPiceViewHeight = 12 * (FoundX + Intarnal)
      ViewStartY = ViewY - AllPiceViewHeight
      
      SetUpX()
      SetUpY()
   }
   
   private func SetUpY(){
      for y in 1 ... 12 {
         var SetY = Intarnal * (y - 1) + FoundX * (y - 1)
         SetY -= Intarnal / 2
         Y.append(CGFloat(SetY))
         print("Y[\(y - 1)] = \(Y[y - 1])")
      }
   }
     
     private func SetUpX(){
        for x in 1 ... 9 {
           var SetX = Intarnal * x + FoundX * (x - 1)
           SetX -= Intarnal / 2
           X.append(CGFloat(SetX))
           print("X[\(x - 1)] = \(X[x - 1])")
        }
     }
   
   private func GetSmallerNum(First: Int, Secand: Int) ->Int {
      if First <= Secand {
         return First
      }
      return Secand
   }
   
   private func GetBiggerNum(First: Int, Secand: Int) ->Int {
      if First >= Secand {
         return First
      }
      return Secand
   }
   
   public func GetAlphasXPosi(AlPosiX: CGFloat, SizeWidth: Int) -> Int {
      
      let MaxX = 8 - (SizeWidth - 1)
      
      switch AlPosiX {
      case let x where x <= X[0]:
         return GetSmallerNum(First: 0, Secand: MaxX)
      case X[0] ..< X[1]:
         return GetSmallerNum(First: 1, Secand: MaxX)
      case X[1] ..< X[2]:
         return GetSmallerNum(First: 2, Secand: MaxX)
      case X[2] ..< X[3]:
         return GetSmallerNum(First: 3, Secand: MaxX)
      case X[3] ..< X[4]:
         return GetSmallerNum(First: 4, Secand: MaxX)
      case X[4] ..< X[5]:
         return GetSmallerNum(First: 5, Secand: MaxX)
      case X[5] ..< X[6]:
         return GetSmallerNum(First: 6, Secand: MaxX)
      case X[6] ..< X[7]:
         return GetSmallerNum(First: 7, Secand: MaxX)
      case let x where x >= X[7]:
         return GetSmallerNum(First: 8, Secand: MaxX)
      default:
         fatalError()
      }
   }
}
