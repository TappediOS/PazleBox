//
//  Puzzle.swift
//  PazleBox
//
//  Created by jun on 2019/03/10.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SpriteKit

class puzzle: SKSpriteNode {

   
   var pAllPosi: [[Int]] = Array()
   
   public var PositionX: Int
   public var PositionY: Int
   public var TouchBegan: CGPoint
   
   
   /// クラスの初期化
   ///
   /// - Parameters:
   ///   - PPosiX: X座標
   ///   - PPosiY: Y座標
   ///   - BallColor: ボールの番号(画像)
   ///   - ViewX: 使用しているデバイスのWideを表す。
   ///   - ViewY: 使用しているデバイスのheightを表す
   init(PPosiX: Int, PPosiY: Int, CustNum: Int, ViewX: Int, ViewY: Int) {
      
      
      
      let PWide = ViewX / 10
      let Intarnal = PWide / 10
      
      let PosiIntarnal = Intarnal + Intarnal * PPosiY
      let PositionWide = PWide * PPosiY
      let TileHalfWide = PWide / 2
      let ViewHalf = -ViewX / 2
      
      let x1 = ViewHalf + PosiIntarnal + PositionWide + TileHalfWide
      let y1 = -ViewY * 3 / 8 + Intarnal * PPosiX + PWide * (PPosiX - 1)
      
      let texture: SKTexture
      
      self.PositionX = PPosiX
      self.PositionY = PPosiY
      self.TouchBegan = CGPoint(x: 0, y: 0)
      
      
      switch CustNum {
      case 1:
         texture = SKTexture(imageNamed: "BaseTile.png")
         
         break
      case 1:
         texture = SKTexture(imageNamed: "NullTile.png")
         
         break
         
      default:
         print("BallNumber is \(CustNum)")
         fatalError("BallNumber is NOT 1...4")
         break;
      }
      
      let NodeSize = CGSize(width: CGFloat(PWide), height: CGFloat(PWide))
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = true
      //ポジションの設定。
      self.position = CGPoint(x: x1, y: y1)
      
      
   }
   
   func InitPazzle(PazzleX: Int, PazzleY: Int, CustomNum: Int){
      
      for x in 0 ... PazzleX - 1{
         for y in 0 ... PazzleY - 1 {
            pAllPosi[x][y] = 0
         }
      }
      
      self.pAllPosi = [[1, 1, 1],
                       [0, 0, 1]]
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
