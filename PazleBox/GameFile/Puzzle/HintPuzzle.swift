//
//  HintPuzzle.swift
//  PazleBox
//
//  Created by jun on 2019/03/29.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

import Foundation
import SpriteKit
import UIKit
import TapticEngine
import SpriteKitEasingSwift
import AVFoundation

class HintPuzzle: SKSpriteNode {
   
   
   var SerchpAllPosi = PArry()
   
   public var PuzzleWide = 0
   public var PuzzleHight = 0
   
   public var CenterX: Int = 0
   public var CenterY: Int = 0
   
   private var AnsX: Int = 0
   private var AnsY: Int = 0
 
   
   private var PuzzleStyle: String
   private var PuzzleColor: String
   
   
   //割って場所を特定する
   var SerchPlace: CGFloat
   
   var Tilep: TilePosi
   

   var PuzzleSizeWide: Int
   
   /// 初期化
   ///
   /// - Parameters:
   ///   - PX: パズルの横幅
   ///   - PY: パズルの縦幅
   ///   - CustNum: 使ってない←
   ///   - ViewX: 画面サイズwide
   ///   - ViewY: 画面サイズheight
   ///   - PuzzleStyle: パズルの形
   ///   - PuzzleColor: パズルの色
   init(PX: Int, PY: Int, CustNum: Int, ViewX: Int, ViewY: Int, PuzzleStyle: String, PuzzleColor: String, AnsX: Int, AnsY: Int) {
      
      self.PuzzleStyle = PuzzleStyle
      self.PuzzleColor = PuzzleColor
      
      self.PuzzleWide = PX
      self.PuzzleHight = PY
      
      self.AnsX = AnsX
      self.AnsY = AnsY
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      
      self.PuzzleSizeWide = PazzleSizeFound
      
      //MARK: 移動後の座標提供者の初期化
      SerchPlace = CGFloat(PazzleSizeFound)
      self.Tilep = TilePosi(ViewX: ViewX, ViewY: ViewY)
      
      let PazzleWideSize = PazzleSizeFound * PX
      let PazzleHightSize = PazzleSizeFound * PY
      
      //MARK: 画像の初期化
      let texture: SKTexture
      let TextureName = PuzzleStyle + PuzzleColor
      texture = SKTexture(imageNamed: TextureName)
      texture.usesMipmaps = true
      
      //texture.

      
      let NodeSize = CGSize(width: CGFloat(PazzleWideSize), height: CGFloat(PazzleHightSize))
      
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      
      //print("anchor: \(CGPoint(x: 1 / (PX * 2), y: 1 - ( 1 / (PY * 2) )))")
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = false
      self.alpha = 0.55
      
      
      //ポジションの設定。
      self.CenterX = self.AnsX
      self.CenterY = self.AnsY
      
      let SetPosi = ViewX / 10 + (ViewX / 100)
      
      let yposi: Int = SetPosi * 12
      let y1: Int = -ViewY * 3 / 8 + yposi
      
      var x1 = 0
      
      if CustNum == 0 {
         x1 = 0
      }else{
         x1 = SetPosi * 1
      }
      
      self.position = CGPoint(x: x1, y: y1)
      //FIXME:- これは多さによって変えるべきである。
      self.zPosition = 2
      
   }
   
   private func SetAnchor() {
      let Anchor = CGPoint(x: 1 / CGFloat(PuzzleWide * 2), y: 1 - 1 / CGFloat(PuzzleHight * 2) )
      self.anchorPoint = Anchor
   }
   
   private func MoveToRightPosi() {
      self.isHidden = true
      
      let WaitActon = SKAction.wait(forDuration: 0.5)
      let WaitGroup = SKAction.sequence([WaitActon, SKAction.run({ [weak self] in
         self?.isHidden = false
      }) ])
      
      let SmallAction = SKEase.scale(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 0.02, from: 0.2, to: 0.15)
      let FadeOutAction = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.02, fromValue: 0.05, toValue: 0.01)
      
      let SmallAcitonGroup = SKAction.group([SmallAction, FadeOutAction])
      
      let SetAnchorAction = SKAction.sequence([SmallAcitonGroup, SKAction.run({ [weak self] in
         self?.SetAnchor()
      }) ])
      
      let LargeAction = SKEase.scale(easeFunction: .curveTypeBack, easeType: .easeTypeOut, time: 0.5, from: 0.15, to: 1)
      let FadeInAction = SKEase.fade(easeFunction: .curveTypeBack, easeType: .easeTypeOut, time: 0.5, fromValue: 0.01, toValue: 0.3)
      
      let MovePointRight = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      let MoveAction = SKEase.move(easeFunction: .curveTypeQuadratic, easeType: .easeTypeOut, time: 0.55, from: self.position, to: MovePointRight)
      
      
      
      let LargeActionGroup = SKAction.group([LargeAction, FadeInAction, MoveAction])
      

      let RecreatedAktion = SKAction.sequence([WaitGroup, SetAnchorAction, LargeActionGroup])
      
      self.run(RecreatedAktion)
      AudioServicesPlaySystemSound(1521)
   }
   
   public func Animation() {
      MoveToRightPosi()
      self.alpha = 0.4
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
