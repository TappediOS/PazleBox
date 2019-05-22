//
//  GetTilePOSITION.swift
//  PazleBox
//
//  Created by jun on 2019/03/16.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class TilePosi {
   
   private var FoundX: Int = 0
   private var Intarnal: Int = 0
   private var FoundY: Int = 0
   private var HalfView: Int = 0
   private var ViewY: Int = 0
   
   private var X: [CGFloat] = Array()
   private var Y: [CGFloat] = Array()
   
   
   
   init(ViewX: Int, ViewY: Int){
      
      FoundX = ViewX / 10
      Intarnal = FoundX / 10
      
      FoundY = ViewY / 10
      HalfView = -ViewX / 2
      
      self.ViewY = ViewY
      
      SetUpX()
      SetUpY()
   }
   
   private func SetUpY(){
      
      for y in 1 ... 12 {
         var SetY: Int = (-self.ViewY * 3 / 8)
         SetY += Intarnal * (y - 1)
         SetY += FoundX * (y - 2)
         Y.append(CGFloat(SetY))
         //print("Y[\(y - 1)] = \(Y[y - 1])")
      }
   }
   
   private func SetUpX(){
      
      for x in 1 ... 9 {
         let SetX = FoundX * (x - 1) + Intarnal * x + HalfView + FoundX / 2
         X.append(CGFloat(SetX))
         //print("X[\(x - 1)] = \(X[x - 1])")
      }
   }
   
   public func GetAnyPostionXY(xpoint: Int, ypoint:Int) -> CGPoint {
      return CGPoint(x: X[xpoint], y: Y[ypoint])
   }
   
   //let y1 = -ViewY * 3 / 8 + Intarnal * TilePosiX + TileWide * (TilePosiX - 1)
   
   
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
      case let x where x <= -3.5:
         return GetSmallerNum(First: 0, Secand: MaxX)
      case -3.5 ..< -2.5:
         return GetSmallerNum(First: 1, Secand: MaxX)
      case -2.5 ..< -1.5:
         return GetSmallerNum(First: 2, Secand: MaxX)
      case -1.5 ..< -0.5:
         return GetSmallerNum(First: 3, Secand: MaxX)
      case -0.5 ..< 0.5:
         return GetSmallerNum(First: 4, Secand: MaxX)
      case 0.5 ..< 1.5:
         return GetSmallerNum(First: 5, Secand: MaxX)
      case 1.5 ..< 2.5:
         return GetSmallerNum(First: 6, Secand: MaxX)
      case 2.5 ..< 3.5:
         return GetSmallerNum(First: 7, Secand: MaxX)
      case let x where x >= 3.5:
         return GetSmallerNum(First: 8, Secand: MaxX)
      default:
         fatalError()
      }
   }
   
   public func GetAlphasYPosi(AlPosiY: CGFloat, SizeHight: Int) -> Int {
      
      let MinY = 0 + (SizeHight - 1)
      
      switch AlPosiY {
      case let y where y <= -6.5:
         return GetBiggerNum(First: 0, Secand: MinY)
      case -6.5 ..< -5.5:
         return GetBiggerNum(First: 1, Secand: MinY)
      case -5.5 ..< -4.5:
         return GetBiggerNum(First: 2, Secand: MinY)
      case -4.5 ..< -3.5:
         return GetBiggerNum(First: 3, Secand: MinY)
      case -3.5 ..< -2.5:
         return GetBiggerNum(First: 4, Secand: MinY)
      case -2.5 ..< -1.5:
         return GetBiggerNum(First: 5, Secand: MinY)
      case -1.5 ..< -0.5:
         return GetBiggerNum(First: 6, Secand: MinY)
      case -0.5 ..< 0.5:
         return GetBiggerNum(First: 7, Secand: MinY)
      case 0.5 ..< 1.5:
         return GetBiggerNum(First: 8, Secand: MinY)
      case 1.5 ..< 2.5:
         return GetBiggerNum(First: 9, Secand: MinY)
      case 2.5 ..< 3.5:
         return GetBiggerNum(First: 10, Secand: MinY)
      case let x where x >= 3.5:
         return GetBiggerNum(First: 11, Secand: MinY)
      default:
         fatalError()
      }
   }
}
