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
import SpriteKitEasingSwift

class HintNode : SKSpriteNode {
   
   var Circ1 = SKSpriteNode()
   var Circ2 = SKSpriteNode()
   
   private var TouchBegan = CGPoint(x: 0, y: 0)
   private var AreYouLarge: Bool = false
   
   private var LockedLastHint = true
   
   private var isLocked = false
   
   var CountOfHint = 2
   
   
   
   init(ViewX: Int, ViewY: Int) {
      
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      let x1 = -PazzleSizeFound * 1
      
      let yposi = PazzleSizeFound * 12
      let y1 = -ViewY * 3 / 8 + yposi
      
      //MARK: 画像の初期化
      let texture: SKTexture
      texture = SKTexture(imageNamed: "Hint.png")
      texture.usesMipmaps = true
      
      
      let NodeSize = CGSize(width: CGFloat(PazzleSizeFound), height: CGFloat(PazzleSizeFound))
      
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      self.position = CGPoint(x: x1, y: y1)
      
      self.isUserInteractionEnabled = true
      
      let LikeSize = CGSize(width: CGFloat(PazzleSizeFound / 2), height: CGFloat(PazzleSizeFound / 2))
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true{
         Circ1 = SKSpriteNode(texture: SKTexture(imageNamed: "Like.png"), size: LikeSize)
      }else{
         Circ1 = SKSpriteNode(texture: SKTexture(imageNamed: "NoLike"), size: LikeSize)
      }
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
   
   public func DissMisLile1() {
      let LargeAction = SKEase.scale(easeFunction: .curveTypeCubic, easeType: .easeTypeIn, time: 0.35, from: 1, to: 2)
      
      let FadeOut = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.45, fromValue: 1, toValue: 0.04)
      let SmallAction = SKEase.scale(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 0.45, from: 1.3, to: 0.2)
      
      let groupAktion = SKAction.group([FadeOut, SmallAction])
      
      let FadeAction = SKAction.sequence([LargeAction, groupAktion, SKAction.run({ [weak self] in
         self?.Circ1.isHidden = true
      }) ])
      
      self.Circ1.run(FadeAction)
   }
   
   public func DissMisLile2() {
      let LargeAction = SKEase.scale(easeFunction: .curveTypeCubic, easeType: .easeTypeIn, time: 0.25, from: 1, to: 2)
      
      let FadeOut = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.35, fromValue: 1, toValue: 0.04)
      let SmallAction = SKEase.scale(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 0.35, from: 1.3, to: 0.2)
      
      let groupAktion = SKAction.group([FadeOut, SmallAction])
      
      let FadeAction = SKAction.sequence([LargeAction, groupAktion, SKAction.run({ [weak self] in
         self?.Circ2.isHidden = true
      }) ])
      
      self.Circ2.run(FadeAction)
   }
   
   private func NotificationSentOrNot() {
      
      if CountOfHint == 0 {
         return
      }
      
      PostNotificationHint()
      
      if CountOfHint == 0 {
         ChangeImageOfHint()
      }
   }
   
   public func DecleCountOfHint() {
      self.CountOfHint -= 1
   }
   
   public func GetCountOfUsedHint() -> Int {
      return 2 - self.CountOfHint
   }
   
   private func ChangeImageOfHint() {
      self.texture = SKTexture(imageNamed: "NoHint.png")
   }
   
   public func LockPuzzle() {
      self.isLocked = true
   }
   
   public func UnLockPuzzle() {
      self.isLocked = false
   }
   
   public func EnableLastHint() {
      Circ1.texture = SKTexture(imageNamed: "Like")
      self.LockedLastHint = false
   }
   
   public func GetEnableLastHint() -> Bool {
      return self.LockedLastHint
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
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      
      
   }
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
   
 
   private func LengthOfTwoPoint(Start: CGPoint, End: CGPoint) -> Bool {
      
      let xDistance = Start.x - End.x
      let yDistance = Start.y - End.y
      let distance = sqrtf(Float(xDistance*xDistance + yDistance*yDistance))
      
      if distance > 55 {
         return false
      }
      
      return true
   }
   
   

   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
