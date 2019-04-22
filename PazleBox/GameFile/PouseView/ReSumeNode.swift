//
//  ReSumeNode.swift
//  PazleBox
//
//  Created by jun on 2019/04/12.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import ChameleonFramework

class ReSumeNode : SKSpriteNode {
   
   private var TouchBegan = CGPoint(x: 0, y: 0)
   private var AreYouLarge: Bool = false
   
   private var isLocked = false
   
   private let NodeText: SKLabelNode = SKLabelNode(text: "Resume")
   
   
   init(ViewX: Int, ViewY: Int, StartX: Int, StartY: Int) {
      
      
      let NodeSize = CGSize(width: CGFloat(ViewX), height: CGFloat(ViewY))
      //let NodeColor = UIColor.flatYellow()
      
      super.init(texture: nil, color: UIColor.flatNavyBlue(), size: NodeSize)
      self.position = CGPoint(x: StartX, y: StartY)
      
      self.zPosition = 101
      
      InitLabel(textY: ViewY / 4)
      
      self.isUserInteractionEnabled = true
   }
   
   private func InitLabel(textY: Int) {
      self.NodeText.zPosition = 102
      self.NodeText.fontName = "Helvetica"
      self.NodeText.fontSize = 100
      self.NodeText.fontColor = UIColor(contrastingBlackOrWhiteColorOn: UIColor.flatNavyBlue(), isFlat: true)
      
      self.NodeText.position = CGPoint(x: 0, y: -textY)
      
      self.addChild(NodeText)
   }
   
   
   private func PostNotificationPouse() {
      NotificationCenter.default.post(name: .ReSume, object: nil, userInfo: nil)
   }
   
   public func LockPuzzle() {
      self.isLocked = true
   }
   
   //MARK:- タッチイベント
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      if isLocked == true {
         return
      }
      
      if let TouchStartPoint = touches.first?.location(in: self) {
         self.TouchBegan = TouchStartPoint
         LargeAnimation()
      }else{
         print("タッチ離したとき、Nilでした。")
      }
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      if isLocked == true {
         return
      }
      
      if let TouchEndPoint = touches.first?.location(in: self) {
         var TmpPoint = TouchEndPoint
         TmpPoint.x = TmpPoint.x - self.TouchBegan.x
         TmpPoint.y = TmpPoint.y - self.TouchBegan.y
         
         SmallAnimateion()
         if LengthOfTwoPoint(Start: TouchBegan, End: TouchEndPoint) == false {
            return
         }
         
         PostNotificationPouse()
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
      
      if distance > 55 { return false }
      return true
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

