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
      
      let x1 = Intarnal * TilePosiX + TileWide * (TilePosiX - 1)
      let y1 = -ViewY * 3 / 8 + Intarnal * TilePosiY + TileWide * (TilePosiY - 1)
      
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
      
      
      super.init(texture: texture, color: UIColor.black, size: CGSize(width: CGFloat(ViewX / 10), height: CGFloat(ViewX / 5)))
      
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = true
      //ポジションの設定。
      self.position = CGPoint(x: x1, y: y1)
      
      
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
}
