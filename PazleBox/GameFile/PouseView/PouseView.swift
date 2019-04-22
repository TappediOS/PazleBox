//
//  PouseView.swift
//  PazleBox
//
//  Created by jun on 2019/04/12.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SpriteKitEasingSwift

class PouseView : SKSpriteNode {
   
   private var TouchBegan = CGPoint(x: 0, y: 0)
   private var AreYouLarge: Bool = false
   
   private var isLocked = false
   
   private var ViewW = 0
   private var ViewH = 0
   
   private var PouseTouchPosi: CGPoint?
   
   private let PouseViewPosiX = 0
   private let PouseViewPosiY = 0
   
   init(ViewX: Int, ViewY: Int) {
      
      self.ViewW = ViewX / 10 * 8
      self.ViewH = self.ViewW
      
      let NodeSize = CGSize(width: CGFloat(ViewW), height: CGFloat(ViewH))
      let NodeColor = UIColor(red: 255, green: 255, blue: 204, alpha: 0)
      
      super.init(texture: nil, color: NodeColor, size: NodeSize)
      self.position = CGPoint(x: PouseViewPosiX, y: PouseViewPosiY)
      
      self.zPosition = 100
      
      self.isUserInteractionEnabled = false
      
      InitPouseTouchPoint(ViewX: ViewX, ViewY: ViewY)
      
      InitPouseLabel()
      InitReSumeNode()
      InitGoHomeNode()
   }
   
   private func InitPouseTouchPoint(ViewX: Int, ViewY: Int) {
      let PazzleSizeFound: Int = ViewX / 10 + (ViewX / 100)
      let x = PazzleSizeFound * 3
      let yposi: Int = PazzleSizeFound * 12
      let y = -ViewY * 3 / 8 + yposi
      
      self.PouseTouchPosi = CGPoint(x: x, y: y)
   }
   
   private func InitPouseLabel() {
      let y = ViewH / 4
      let startY = y + y / 4
      
      let Node = PouseTextNode(StartX: 0, StartY: startY - startY / 4)
 
      self.addChild(Node)
   }
   
   private func InitReSumeNode() {
      let x = ViewW / 10 * 8
      let y = ViewH / 4
      
      let Node = ReSumeNode(ViewX: x, ViewY: y, StartX: 0, StartY: 0)
      self.addChild(Node)
   }
   
   
   private func InitGoHomeNode() {
      
      let x = ViewW / 10 * 8
      let y = ViewH / 4
      let startY = y + y / 4
      
      let Node = GoHomeNode(ViewX: x, ViewY: y, StartX: 0, StartY: -startY)
      self.addChild(Node)
   }
   
   private func SetViewFirstPosi() {
      if let point = self.PouseTouchPosi {
         self.position = point
      }else {
         return
      }
   }
   
   private func SetViewSize() {
      self.size = CGSize(width: 3, height: 3)
   }
   
   private func MoveAnimation() {
      
      let MovePoint = CGPoint(x: 0, y: 0)
      
      let Aktion = SKEase.move(easeFunction: .curveTypeQuadratic, easeType: .easeTypeOut, time: 1, from: self.position, to: MovePoint)
      let action = SKAction.sequence([Aktion, SKAction.run({ [weak self] in
         
      }) ])
      self.run(action)
   }
   
   public func ShowViewAnimation() {
      SetViewFirstPosi()
      SetViewSize()
      MoveAnimation()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


