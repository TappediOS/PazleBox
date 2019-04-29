//
//  HintPouseView.swift
//  PazleBox
//
//  Created by jun on 2019/04/29.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SpriteKitEasingSwift

class HintPouseView : SKSpriteNode {
   
   private var YesNodes: YesNode?
   private var NoNodes: NoNode?
   
   private var TouchBegan = CGPoint(x: 0, y: 0)
   private var AreYouLarge: Bool = false
   
   private var isLocked = false
   
   private var ViewW = 0
   private var ViewH = 0
   
   
   private let PouseViewPosiX = 0
   private let PouseViewPosiY = 0
   
   init(ViewX: Int, ViewY: Int) {
      
      self.ViewW = ViewX / 10 * 8
      self.ViewH = self.ViewW
      
      let NodeSize = CGSize(width: CGFloat(ViewW), height: CGFloat(ViewH))
      let NodeColor = UIColor(red: 255, green: 255, blue: 204, alpha: 1)
      
      super.init(texture: nil, color: NodeColor, size: NodeSize)
      self.position = CGPoint(x: PouseViewPosiX, y: PouseViewPosiY)
      
      self.zPosition = 100
      
      self.isUserInteractionEnabled = false
      
      
      InitHintPouseLabel()
      InitYesNode()
      InitNoNode()
   }
   
   
   private func InitHintPouseLabel() {
      let y = ViewH / 4
      let startY = y + y / 4
      
      let Node = HintTextNode(StartX: 0, StartY: startY - startY / 4)
      
      self.addChild(Node)
   }
   
   private func InitYesNode() {
      let x = ViewW / 10 * 8
      let y = ViewH / 4
      
      let Node = YesNode(ViewX: x, ViewY: y, StartX: 0, StartY: 0)
      self.YesNodes = Node
      self.addChild(self.YesNodes!)
   }
   
   
   public func GetIsLocked() -> Bool {
      return self.isLocked
   }
   
   private func InitNoNode() {
      
      let x = ViewW / 10 * 8
      let y = ViewH / 4
      let startY = y + y / 4
      
      let Node = NoNode(ViewX: x, ViewY: y, StartX: 0, StartY: -startY)
      self.NoNodes = Node
      self.addChild(Node)
   }
   
   
   
   private func ReSetNodeSize() {
      self.size = CGSize(width: CGFloat(ViewW), height: CGFloat(ViewH))
      self.alpha = 1
   }
   
   
   public func ShowViewAnimation() {
      self.alpha = 0.2
      let WaitActon = SKAction.wait(forDuration: 0.01)
      let LargeAction = SKEase.scale(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 0.085, from: 1, to: 1.1)
      
      let SmallAction = SKEase.scale(easeFunction: .curveTypeBack, easeType: .easeTypeOut, time: 0.175, from: 1.1, to: 1)
      let PouseAnime = SKAction.sequence([WaitActon, LargeAction, SmallAction])
      
      let FadeInAction = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.28, fromValue: 0.2, toValue: 1)
      let RunAni = SKAction.group([PouseAnime, FadeInAction])
      
      self.run(RunAni)
   }
   
   public func FadeOutAniAndRemoveFromParent() {
      
      self.isLocked = true
      
      let LargeAction = SKEase.scale(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 0.085, from: 1, to: 1.08)
      
      let SmallAction = SKEase.scale(easeFunction: .curveTypeLinear, easeType: .easeTypeIn, time: 0.24, from: 1.1, to: 0)
      let FadeOutAction = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.36, fromValue: 1, toValue: 0)
      
      let SmallGroup = SKAction.group([SmallAction, FadeOutAction])
      
      let LargeAndSmallGroup = SKAction.sequence([LargeAction, SmallGroup])
      
      let RunAction = SKAction.sequence([LargeAndSmallGroup, SKAction.run({ [weak self] in
         self?.ReSetNodeSize()
         self?.removeFromParent()
         self?.isLocked = false
         self?.YesNodes!.UnLockPuzzle()
         self?.NoNodes!.UnLockPuzzle()
      }) ])
      
      self.run(RunAction)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}



