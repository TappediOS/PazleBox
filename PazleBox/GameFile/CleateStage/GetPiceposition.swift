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
   
   private var FoundX: CGFloat = 0
   private var Intarnal: CGFloat = 0
   private var FoundY: CGFloat = 0
   private var HalfView: Int = 0
   private var ViewY: Int = 0
   
   private var ViewStartY: CGFloat = 0
   
   private var X: [CGFloat] = Array()
   private var Y: [CGFloat] = Array()
   
   init(ViewX: CGFloat, ViewY: CGFloat){
      
      FoundX = ViewX / 10
      Intarnal = FoundX / 10
      
      let AllPiceViewHeight = 12 * (FoundX + Intarnal)
      ViewStartY = ViewY - AllPiceViewHeight - FoundX / 2
      
      
      SetUpX()
      SetUpY()
   }
   
   private func SetUpY(){
      for y in 1 ... 12 {
         var SetY = ViewStartY + Intarnal * CGFloat(y - 1)
         SetY += FoundX * CGFloat(y - 1)
         SetY -= Intarnal / 2
         Y.append(CGFloat(SetY))
         print("Y[\(y - 1)] = \(Y[y - 1])")
      }
   }
     
   private func SetUpX(){
      for x in 1 ... 9 {
         var SetX = Intarnal * CGFloat(x)
         SetX += FoundX * CGFloat(x - 1)
         SetX -= Intarnal / 2
         X.append(CGFloat(SetX))
         print("X[\(x - 1)] = \(X[x - 1])")
      }
   }
   
   public func GetAnyPosiX(xpoint: Int) -> CGFloat {
      return X[xpoint]
   }
   
   public func GetAnyPosiY(ypoint:Int) -> CGFloat {
      print("指話したときのIntは　\(ypoint)")
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
      
      let Dif = FoundX / 2 + Intarnal / 2
      
      switch AlPosiX {
      case let x where x <= X[0] + Dif:
         return GetSmallerNum(First: 0, Secand: MaxX)
      case X[0] + Dif ..< X[1] + Dif:
         return GetSmallerNum(First: 1, Secand: MaxX)
      case X[1] + Dif ..< X[2] + Dif:
         return GetSmallerNum(First: 2, Secand: MaxX)
      case X[2] + Dif ..< X[3] + Dif:
         return GetSmallerNum(First: 3, Secand: MaxX)
      case X[3] + Dif ..< X[4] + Dif:
         return GetSmallerNum(First: 4, Secand: MaxX)
      case X[4] + Dif ..< X[5] + Dif:
         return GetSmallerNum(First: 5, Secand: MaxX)
      case X[5] + Dif ..< X[6] + Dif:
         return GetSmallerNum(First: 6, Secand: MaxX)
      case X[6] + Dif ..< X[7] + Dif:
         return GetSmallerNum(First: 7, Secand: MaxX)
      case let x where x >= X[7] + Dif:
         return GetSmallerNum(First: 8, Secand: MaxX)
      default:
         fatalError()
      }
   }
   
   public func GetAlphasYPosi(AlPosiY: CGFloat, SizeHight: Int) -> Int {
      
      let MaxY = 11 - (SizeHight - 1)
      let Dif = FoundX / 2 + Intarnal / 2
      
      switch AlPosiY {
      case let y where y <= Y[0] + Dif:
         return GetSmallerNum(First: 0, Secand: MaxY)
      case Y[0] + Dif ..< Y[1] + Dif:
         return GetSmallerNum(First: 1, Secand: MaxY)
      case Y[1] + Dif ..< Y[2] + Dif:
         return GetSmallerNum(First: 2, Secand: MaxY)
      case Y[2] + Dif ..< Y[3] + Dif:
         return GetSmallerNum(First: 3, Secand: MaxY)
      case Y[3] + Dif ..< Y[4] + Dif:
         return GetSmallerNum(First: 4, Secand: MaxY)
      case Y[4] + Dif ..< Y[5] + Dif:
         return GetSmallerNum(First: 5, Secand: MaxY)
      case Y[5] + Dif ..< Y[6] + Dif:
         return GetSmallerNum(First: 6, Secand: MaxY)
      case Y[6] + Dif ..< Y[7] + Dif:
         return GetSmallerNum(First: 7, Secand: MaxY)
      case Y[7] + Dif ..< Y[8] + Dif:
         return GetSmallerNum(First: 8, Secand: MaxY)
      case Y[8] + Dif ..< Y[9] + Dif:
         return GetSmallerNum(First: 9, Secand: MaxY)
      case Y[9] + Dif ..< Y[10] + Dif:
         return GetSmallerNum(First: 10, Secand: MaxY)
      case let y where y >= Y[10] + Dif:
         return GetSmallerNum(First: 11, Secand: MaxY)
      default:
         fatalError()
      }
   }
}
