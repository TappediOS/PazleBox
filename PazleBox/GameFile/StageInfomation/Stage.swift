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
   public var Tile: GameTile?
   
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
   }
   
   public func getAllTile(x: Int, y: Int) -> SKSpriteNode {
      return InitTile(x: x, y: y)
   }
   
   private func InitTile(x: Int, y: Int) -> SKSpriteNode{
      
      switch GStage[x][y] {
      case .In:
         return GameTile(TilePosiX: x, TilePosiY: y, TileCont: .In, ViewX: ViewX, ViewY: ViewY)
      case .Out:
         return GameTile(TilePosiX: x, TilePosiY: y, TileCont: .Out, ViewX: ViewX, ViewY: ViewY)
      case .Put:
         return GameTile(TilePosiX: x, TilePosiY: y, TileCont: .Put, ViewX: ViewX, ViewY: ViewY)
      case .NotPut:
         return GameTile(TilePosiX: x, TilePosiY: y, TileCont: .NotPut, ViewX: ViewX, ViewY: ViewY)
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
