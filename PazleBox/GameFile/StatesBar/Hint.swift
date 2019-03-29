//
//  Hint.swift
//  PazleBox
//
//  Created by jun on 2019/03/28.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class HintNode : SKSpriteNode {
   
   var Circ1 = SKSpriteNode()
   var Circ2 = SKSpriteNode()
   
   private var TouchBegan = CGPoint(x: 0, y: 0)
   private var AreYouLarge: Bool = false
   
   var CountOfHint = 2
   
   init(ViewX: Int, ViewY: Int) {
      
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      let x1 = -PazzleSizeFound * 1
      
      let yposi = PazzleSizeFound * 12
      let y1 = -ViewY * 3 / 8 + yposi
      
      //MARK: 画像の初期化
      let texture: SKTexture
      texture = SKTexture(imageNamed: "Hint.png")
      
      
      let NodeSize = CGSize(width: CGFloat(PazzleSizeFound), height: CGFloat(PazzleSizeFound))
      
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      self.position = CGPoint(x: x1, y: y1)
      
      self.isUserInteractionEnabled = true
      
      let LikeSize = CGSize(width: CGFloat(PazzleSizeFound / 2), height: CGFloat(PazzleSizeFound / 2))
      Circ1 = SKSpriteNode(texture: SKTexture(imageNamed: "Like.png"), size: LikeSize)
      Circ2 = SKSpriteNode(texture: SKTexture(imageNamed: "Like.png"), size: LikeSize)
      
      
      let x2 = 0
      Circ1.position = CGPoint(x: x2, y: y1)
      
      let x3 = PazzleSizeFound * 1
      Circ2.position = CGPoint(x: x3, y: y1)
      
   }
   
   public func GetCirc1() -> SKSpriteNode {
      return self.Circ1
   }
   public func GetCirc2() -> SKSpriteNode {
      return self.Circ2
   }
   
   private func PostNotificationHint() {
      NotificationCenter.default.post(name: .Hint, object: nil, userInfo: nil)
   }
   
   private func NotificationSentOrNot() {
      
      if CountOfHint == 0 {
         return
      }
      
      CountOfHint -= 1
      PostNotificationHint()
      
      if CountOfHint == 0 {
         ChangeImageOfHint()
      }
   }
   
   private func ChangeImageOfHint() {
      self.texture = SKTexture(imageNamed: "NoHint.png")
   }
   
   //MARK:- タッチイベント
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      if let TouchStartPoint = touches.first?.location(in: self) {
         self.TouchBegan = TouchStartPoint
         LargeAnimation()
      }else{
         print("タッチ離したとき、Nilでした。")
      }
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      
      
   }
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      if let TouchEndPoint = touches.first?.location(in: self) {
         var TmpPoint = TouchEndPoint
         TmpPoint.x = TmpPoint.x - self.TouchBegan.x
         TmpPoint.y = TmpPoint.y - self.TouchBegan.y
         
         SmallAnimateion()
         if LengthOfTwoPoint(Start: TouchBegan, End: TouchEndPoint) == false {
            return
         }
         NotificationSentOrNot()
         return
      }else{
         print("タッチ離したあと、Nilでした。")
         return
      }
   }
   
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      
   }
   
   /// ノードを大きくする関数
   private func LargeAnimation() {
      
      //Large状態でなければ大きくする。
      if self.AreYouLarge == false {
         let Large: SKAction = SKAction.scale(by: 1.2, duration: 0.2)
         self.run(Large)
         self.AreYouLarge = true
         return
      }
   }
   
   /// ノードを小さくする関数
   private func SmallAnimateion() {
      
      //Large状態であれば小さくする
      if self.AreYouLarge == true {
         let Small: SKAction = SKAction.scale(by: 1 / 1.2, duration: 0.2)
         self.run(Small)
         self.AreYouLarge = false
         return
      }
   }
   
   /// 2点間の距離を求め、距離が十分であるかどうか調べる
   ///
   /// - Parameters:
   ///   - Start: 始点
   ///   - End: 終点
   /// - Returns: 一定以上ならばtrueを返す。
   private func LengthOfTwoPoint(Start: CGPoint, End: CGPoint) -> Bool {
      
      let xDistance = Start.x - End.x
      let yDistance = Start.y - End.y
      let distance = sqrtf(Float(xDistance*xDistance + yDistance*yDistance))
      
      print("2点間の距離は\(distance)")
      
      if distance > 55 {
         return false
      }
      
      return true
   }
   
   

   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
