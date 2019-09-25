//
//  PiceImageView.swift
//  PazleBox
//
//  Created by jun on 2019/09/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class PiceImageView : UIImageView {
   
   var TileWide: CGFloat?
   var TileInter: CGFloat?
   
   var PiceWideNum = 0
   var PiceHeightNum = 0
   
   var PiceFlameToStage: CGRect?
   var AlphaImageView: UIImageView
   
   init(frame: CGRect, name: String) {
      AlphaImageView = UIImageView(frame: frame)
      super.init(frame: frame)
      
      SetImage(name: name)
      InitTileInfo(frame: frame)
      InitPiceInfo(name: name)
      InitPiceFlameToStage()
      
      self.isUserInteractionEnabled = true
   }
   
   private func InitTileInfo(frame: CGRect) {
      TileWide = frame.width / 10
      TileInter = frame.width / 100
   }
   
   private func InitPiceInfo(name: String) {
      if let PiceNumber = Int(name.pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")) {
         PiceHeightNum = PiceNumber % 10
         PiceWideNum = (PiceNumber - PiceHeightNum) / 10
         print("(横，縦) = (\(PiceWideNum),\(PiceWideNum))")
      }else{
         fatalError("正規表現でint型を取得できない")
      }
   }
   
   private func InitPiceFlameToStage() {
      let Width = CGFloat(TileWide * PiceWideNum + TileInter * (PiceWideNum - 1))
      let Height = CGFloat(TileWide * PiceHeightNum + TileInter * (PiceHeightNum - 1))
      PiceFlameToStage = CGRect(x: 0, y: 0, width: Width, height: Height)
   }
   
   private func SetImage(name: String) {
      self.image = UIImage(named: name)?.ResizeUIImage(width: 64, height: 64)
      
   }
   
   public func SetUPAlphaImageView() {
      AlphaImageView.image = self.image
      AlphaImageView.alpha = 0.4
      AlphaImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      AlphaImageView.isUserInteractionEnabled = false
      addSubview(AlphaImageView)
      AlphaImageView.bringSubviewToFront(self)
   }
   
   
   private func PiceToBeLarge() {
      self.frame = PiceFlameToStage!
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      PiceToBeLarge()
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touchEvent = touches.first!

      let preDx = touchEvent.previousLocation(in: self).x
      let preDy = touchEvent.previousLocation(in: self).y
      let newDx = touchEvent.location(in: self).x
      let newDy = touchEvent.location(in: self).y
       
      let dx = newDx - preDx
      let dy = newDy - preDy

      AlphaImageView.center.x += dx
      AlphaImageView.center.y += dy
      
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
