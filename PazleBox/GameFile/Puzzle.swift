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

   
   var pAllPosi: [[Contents]] = Array()
   var SerchpAllPosi = PArry()
   
   public var PuzzleWide = 0
   public var PuzzleHight = 0
   
   public var CenterX: Int
   public var CenterY: Int
   public var OneTimeBackPosiX: Int = 0
   public var OneTimeBackPosiY: Int = 0
   public var TouchBegan: CGPoint
   
   private var AlphaNode = SKSpriteNode()
   
   //割って場所を特定する
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
   init(PX: Int, PY: Int, CustNum: Int, ViewX: Int, ViewY: Int, TextureName: String) {
      
      print("node \(PX) * \(PY)")
      self.PuzzleWide = PX
      self.PuzzleHight = PY
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      
      
      SerchPlace = CGFloat(PazzleSizeFound)
      self.Tilep = TilePosi(ViewX: ViewX, ViewY: ViewY)
      
      let PazzleWideSize = PazzleSizeFound * PX
      let PazzleHightSize = PazzleSizeFound * PY
      
      
      
      self.CenterX = PX - 1
      self.CenterY = PY - 1
      
      let PHalfWide = PazzleWideSize / 2
      let ViewHalf = -ViewX / 2
      
      let x1 = ViewHalf + PazzleWideSize + PHalfWide
      let y1 = -ViewY * 3 / 8 + PX + PazzleHightSize * (PX - 1)
      
      let texture: SKTexture
      

      self.TouchBegan = CGPoint(x: 0, y: 0)
      
      
      switch CustNum {
      case 1:
         texture = SKTexture(imageNamed: TextureName)
         texture.filteringMode = .nearest
         
         break
      case 2:
         texture = SKTexture(imageNamed: "NullTile.png")
         
         break
         
      default:
         print("BallNumber is \(CustNum)")
         fatalError("BallNumber is NOT 1...4")
         break;
      }
      
      let NodeSize = CGSize(width: CGFloat(PazzleWideSize), height: CGFloat(PazzleHightSize))
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      
      //print("anchor: \(CGPoint(x: 1 / (PX * 2), y: 1 - ( 1 / (PY * 2) )))")
      
      let Anchor = CGPoint(x: 1 / CGFloat(PX * 2), y: 1 - 1 / CGFloat(PY * 2) )
      self.anchorPoint = Anchor
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = true
      //ポジションの設定。
      //self.position = CGPoint(x: x1, y: y1)
      self.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      
      self.zPosition = 2
      
      AlphaNode = SKSpriteNode(texture: texture, color: UIColor.black, size: NodeSize)
      
      AlphaNode.anchorPoint = Anchor
      AlphaNode.position = self.position
      AlphaNode.zPosition = 1
      
      AlphaNode.alpha = 0.5
      
      
      
   }
   
   //MARK:- 初期化
   func InitPazzle(PazzleX: Int, PazzleY: Int, CustomNum: Int){

      self.pAllPosi = SerchpAllPosi.GerPArry(TextureName: self.texture!.name) 
   }
   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK:- 取得
   func GetAlhpaNode() -> SKSpriteNode {
      return self.AlphaNode
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
   
   //MARK:- 通知を送信
   private func FinishMoveTilePOSTMotification() {
      
      let SentObject: [String : Any] = ["PX": self.CenterX as Int,
                                        "PY": self.CenterY as Int,
                                        "PArry": self.pAllPosi as Array]
      
      print("")
      NotificationCenter.default.post(name: .TileMoved, object: nil, userInfo: SentObject)
   }
   
   public func GetOfInfomation() -> [String : Any] {
      
      let AllInfomation: [String : Any] = ["StartPointX": self.CenterX as Int,
                                           "StartPointY": self.CenterY as Int,
                                           "PuzzleWide": self.PuzzleWide as Int,
                                           "PuzzleHight": self.PuzzleHight as Int,
                                           "PArry": self.pAllPosi as Array]
      
      return AllInfomation
      
   }
   
   //MARK:- ノードの場所を更新する
   func UpdateAlphaNodePosi() {
      let Selfx = self.position.x
      let Selfy = self.position.y
      
      let BeforeCenterX = self.CenterX
      let BeforeCenterY = self.CenterY
      
      //print(Selfy / SerchPlace)
      self.CenterX = Tilep.GetAlphasXPosi(AlPosiX: Selfx / SerchPlace)
      self.CenterY = Tilep.GetAlphasYPosi(AlPosiY: Selfy / SerchPlace)
      self.AlphaNode.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      
      
      if self.CenterX != BeforeCenterX || self.CenterY != BeforeCenterY {
         OneTimeBackPosiX = BeforeCenterX
         OneTimeBackPosiY = BeforeCenterY
      }
      
      //print("selfX = \(CenterX) selfY = \(CenterY)")
   }
   
   func UpdateSelfPosi(){
      self.position = AlphaNode.position
   }
   
  
   
   //MARK:- タッチイベント
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     self.zPosition += 1
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
     
      self.zPosition -= 1
      UpdateSelfPosi()
      FinishMoveTilePOSTMotification()
   }
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     
   }

}
