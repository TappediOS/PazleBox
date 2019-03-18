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
   
   private var AlphaNode = SKSpriteNode()
   
   var SerchPlace: CGFloat
   
   var Tilep: TilePosi
   
   
   /// クラスの初期化
   ///
   /// - Parameters:
   ///   - PPosiX: X座標
   ///   - PPosiY: Y座標
   ///   - BallColor: ボールの番号(画像)
   ///   - ViewX: 使用しているデバイスのWideを表す。
   ///   - ViewY: 使用しているデバイスのheightを表す
   init(PX: Int, PY: Int, CustNum: Int, ViewX: Int, ViewY: Int) {
      
      
      let PFound = ViewX / 10 + (ViewX / 100)
      
      SerchPlace = CGFloat(PFound)
      self.Tilep = TilePosi(ViewX: ViewX, ViewY: ViewY)
      
      let PWide = PFound * PX
      let PHight = PFound * PY
      
      let PHalfWide = PWide / 2
      let ViewHalf = -ViewX / 2
      
      let x1 = ViewHalf + PWide + PHalfWide
      let y1 = -ViewY * 3 / 8 + PX + PHight * (PX - 1)
      
      let texture: SKTexture
      
      self.PositionX = PX
      self.PositionY = PY
      self.TouchBegan = CGPoint(x: 0, y: 0)
      
      
      switch CustNum {
      case 1:
         texture = SKTexture(imageNamed: "BaseTile.png")
         
         break
      case 2:
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
      
      self.zPosition = 2
      
      AlphaNode = SKSpriteNode(texture: texture, color: UIColor.black, size: NodeSize)
      
      AlphaNode.position = self.position
      AlphaNode.zPosition = 1
      
      AlphaNode.alpha = 0.5
      
      
      
   }
   
   func GetAlhpaNode() -> SKSpriteNode {
      return self.AlphaNode
   }
   
   func InitPazzle(PazzleX: Int, PazzleY: Int, CustomNum: Int){
      
      
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
   

   func UpdateAlphaNodePosi() {
      let Selfx = self.position.x
      let Selfy = self.position.y
      
      //print(Selfy / SerchPlace)
      self.AlphaNode.position.x = Tilep.GetAlphasXPosi(AlPosiX: Selfx / SerchPlace)
      self.AlphaNode.position.y = Tilep.GetAlphasYPosi(AlPosiY: Selfy / SerchPlace)
   }
   
   func UpdateSelfPosi(){
      self.position = AlphaNode.position
   }
   
  
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
   }
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     
      // タッチイベントを取得
      let touchEvent = touches.first!
      
      let PreviewXPoint = touchEvent.previousLocation(in: self).x
      let PreviewYPoint = touchEvent.previousLocation(in: self).y
      
      let AfterXPoint = touchEvent.location(in: self).x
      let AfterYPoint = touchEvent.location(in: self).y
      
      let Dx = AfterXPoint - PreviewXPoint
      let Dy = AfterYPoint - PreviewYPoint
      
      self.position.x += Dx
      self.position.y += Dy
      
      //print("\(self.position.x), \(self.position.y)")
      UpdateAlphaNodePosi()
      
   }
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     
      
      UpdateSelfPosi()
   }
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     
   }

}
