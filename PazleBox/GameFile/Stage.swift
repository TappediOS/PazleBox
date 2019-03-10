//
//  Stage.swift
//  PazleBox
//
//  Created by jun on 2019/03/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class HoldStage {
   
   //Stage 9 * 12
   public var GStage: [[Contents]]
   public var Tile: [[GameTile]]?
   
   private var ViewX: Int = 0
   private var ViewY: Int = 0

   
   
   
   init(){
      GStage = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
               [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
      
      
      
      InitStage()
      InitTile()
   }
   
   private func InitTile() {
      
      for x in 0 ... 8 {
         for y in 0 ... 11 {
            
            switch GStage[x][y] {
               
            case .In:
               Tile?[x][y] = GameTile(TilePosiX: x, TilePosiY: y, TileCont: .In, ViewX: ViewX, ViewY: ViewY)
               break
            case .Out:
               Tile?[x][y] = GameTile(TilePosiX: x, TilePosiY: y, TileCont: .Out, ViewX: ViewX, ViewY: ViewY)
               break
               
            default:
               break
            }
         }
      }
   }
   
   public func SetStageSizeX(SizeX: CGFloat){
      self.ViewX = Int(SizeX)
      print("ビューの横幅：\(self.ViewX)")
      return
   }
   
   public func SetStageSizeY(SizeY: CGFloat){
      self.ViewY = Int(SizeY)
      print("ビューの縦幅：\(self.ViewY)")
      return
   }
   
   private func InitStage(){

   }

}
