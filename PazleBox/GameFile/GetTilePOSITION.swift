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
   
   private var FoundX = 0
   private var Intarnal = 0
   private var FoundY = 0
   private var HalfView = 0
   private var ViewY = 0
   
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
         let SetY = (-self.ViewY * 3 / 8) + Intarnal * (y - 1) + FoundX * (y - 2)
         Y.append(CGFloat(SetY))
         print("Y[\(y - 1)] = \(Y[y - 1])")
      }
   }
   
   private func SetUpX(){
      
      for x in 1 ... 9 {
         let SetX = FoundX * (x - 1) + Intarnal * x + HalfView + FoundX / 2
         X.append(CGFloat(SetX))
         print("X[\(x - 1)] = \(X[x - 1])")
      }
   }
   
   //let y1 = -ViewY * 3 / 8 + Intarnal * TilePosiX + TileWide * (TilePosiX - 1)
   
   public func GetAlphasXPosi(AlPosiX: CGFloat) -> CGFloat {
      
      
      switch AlPosiX {
      case let x where x <= -3.5:
         return X[0]
      case -3.5 ..< -2.5:
         return X[1]
      case -2.5 ..< -1.5:
         return X[2]
      case -1.5 ..< -0.5:
         return X[3]
      case -0.5 ..< 0.5:
         return X[4]
      case 0.5 ..< 1.5:
         return X[5]
      case 1.5 ..< 2.5:
         return X[6]
      case 2.5 ..< 3.5:
         return X[7]
      case let x where x >= 3.5:
         return X[8]
      default:
         fatalError()
      }
   }
   
   public func GetAlphasYPosi(AlPosiY: CGFloat) -> CGFloat {
      
      
      switch AlPosiY {
      case let y where y <= -6.5:
         return Y[0]
      case -6.5 ..< -5.5:
         return Y[1]
      case -5.5 ..< -4.5:
         return Y[2]
      case -4.5 ..< -3.5:
         return Y[3]
      case -3.5 ..< -2.5:
         return Y[4]
      case -2.5 ..< -1.5:
         return Y[5]
      case -1.5 ..< -0.5:
         return Y[6]
      case -0.5 ..< 0.5:
         return Y[7]
      case 0.5 ..< 1.5:
         return Y[8]
      case 1.5 ..< 2.5:
         return Y[9]
      case 2.5 ..< 3.5:
         return Y[10]
      case let x where x >= 3.5:
         return Y[11]
      default:
         fatalError()
      }
   }
}
