//
//  Tile.swift
//  PazleBox
//
//  Created by jun on 2019/03/10.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SpriteKitEasingSwift

class GameTile: SKSpriteNode {
   
   public var PositionX: Int
   public var PositionY: Int
   public var TouchBegan: CGPoint
   
   
   
   
   /// クラスの初期化
   ///
   /// - Parameters:
   ///   - TilePosiX: X座標
   ///   - TilePosiY: Y座標
   ///   - BallColor: ボールの番号(画像)
   ///   - ViewX: 使用しているデバイスのWideを表す。
   ///   - ViewY: 使用しているデバイスのheightを表す
   init(TilePosiX: Int, TilePosiY: Int, TileCont: Contents, ViewX: Int, ViewY: Int) {
      
      
      
      
      
      let TileWide = ViewX / 10
      let Intarnal = TileWide / 10
      
      let PosiIntarnal = Intarnal + Intarnal * TilePosiY
      let PositionWide = TileWide * TilePosiY
      let TileHalfWide = TileWide / 2
      let ViewHalf = -ViewX / 2
      
      let x1 = ViewHalf + PosiIntarnal + PositionWide + TileHalfWide
      let y1 = -ViewY * 3 / 8 + Intarnal * TilePosiX + TileWide * (TilePosiX - 1)
      
      let texture: SKTexture
      
      self.PositionX = TilePosiX
      self.PositionY = TilePosiY
      self.TouchBegan = CGPoint(x: 0, y: 0)
      
      

     
      switch TileCont {
      case .In:
         texture = SKTexture(imageNamed: "BaseTile.png")
         
         break
      case .Out:
         texture = SKTexture(imageNamed: "NullTile.png")
         
         break
         
      default:
         print("BallNumber is \(TileCont)")
         fatalError("BallNumber is NOT 1...4")
         break;
      }
      
      let NodeSize = CGSize(width: CGFloat(TileWide), height: CGFloat(TileWide))
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = true
      //ポジションの設定。
      self.position = CGPoint(x: x1, y: y1)
      
      self.zPosition = 0
      
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func SelectTexture(TileCon: Contents) {
      //ここで画像を選択。
      switch TileCon {
      case .In:
         texture = SKTexture(imageNamed: "BaseTile.png")
         
         break
      case .Out:
         texture = SKTexture(imageNamed: "NullTile.png")
         
         break
      
      default:
         print("BallNumber is \(TileCon)")
         fatalError("BallNumber is NOT 1...4")
         break;
      }
   }
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      
      print("私は(\(self.PositionX), \(self.PositionY))で，POSIは(\(self.position.x), \(self.position.y))")
    
      
     // print("--- Tile info ---")
      //print("ball posi is [\(self.PositionX)][\(self.PositionY)]")
      
      
      if let TouchStartPoint = touches.first?.location(in: self) {
         self.TouchBegan = TouchStartPoint
         //print("touch Start Point = \(self.TouchBegan)")
      }else{
         print("タッチ離したとき、Nilでした。")
      }
      
      return
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
   
      
      if let TouchEndPoint = touches.first?.location(in: self) {
         var TmpPoint = TouchEndPoint
         TmpPoint.x = TmpPoint.x - self.TouchBegan.x
         TmpPoint.y = TmpPoint.y - self.TouchBegan.y
         //print("touch End Point = \(TouchEndPoint)")
//         if LengthOfTwoPoint(Start: TouchBegan, End: TouchEndPoint) == false {
//            return
//         }
         return
      }else{
         print("タッチ離したあと、Nilでした。")
         return
      }
      
      
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
   }
}
