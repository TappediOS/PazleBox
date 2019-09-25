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
   
   public func GetAnyPosiX(xpoint: Int) -> CGFloat {
      return X[xpoint]
   }
   
   public func GetAnyPosiY(ypoint:Int) -> CGFloat {
      return Y[ypoint]
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
   
   public func GetAlphasYPosi(AlPosiY: CGFloat, SizeHight: Int) -> Int {
      
      let MinY = 0 + (SizeHight - 1)
      
      switch AlPosiY {
      case let y where y <= Y[0]:
         return GetBiggerNum(First: 0, Secand: MinY)
      case Y[0] ..< Y[1]:
         return GetBiggerNum(First: 1, Secand: MinY)
      case Y[1] ..< Y[2]:
         return GetBiggerNum(First: 2, Secand: MinY)
      case Y[2] ..< Y[3]:
         return GetBiggerNum(First: 3, Secand: MinY)
      case Y[3] ..< Y[4]:
         return GetBiggerNum(First: 4, Secand: MinY)
      case Y[4] ..< Y[5]:
         return GetBiggerNum(First: 5, Secand: MinY)
      case Y[5] ..< Y[6]:
         return GetBiggerNum(First: 6, Secand: MinY)
      case Y[6] ..< Y[7]:
         return GetBiggerNum(First: 7, Secand: MinY)
      case Y[7] ..< Y[8]:
         return GetBiggerNum(First: 8, Secand: MinY)
      case Y[8] ..< Y[9]:
         return GetBiggerNum(First: 9, Secand: MinY)
      case Y[9] ..< Y[10]:
         return GetBiggerNum(First: 10, Secand: MinY)
      case let x where x >= Y[11]:
         return GetBiggerNum(First: 11, Secand: MinY)
      default:
         fatalError()
      }
   }
}
