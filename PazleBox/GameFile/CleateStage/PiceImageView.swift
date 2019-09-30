//
//  PiceImageView.swift
//  PazleBox
//
//  Created by jun on 2019/09/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine

class PiceImageView : UIImageView {
   
   var TileWide: CGFloat?
   var TileInter: CGFloat?
   
   var PiceWideNum = 0
   var PiceHeightNum = 0
   
   var PiceFlameToStage: CGRect?
   var AlphaImageView: UIImageView
   
   var PicePosi: GetPicePosi
   
   var PositionX: Int? = nil
   var PositionY: Int? = nil
   var BeforePositionX: Int? = nil
   var BeforePositionY: Int? = nil
   
   //HapTIcを鳴らすための変数
   var PositionForHapTicX = 11
   var PositionForHapTicY = 11
   
   //じしんのpiceの名前
   var selfName: String = ""
   
   init(frame: CGRect, name: String, WindowFlame: CGRect) {
      
      AlphaImageView = UIImageView(frame: frame)
      self.PicePosi = GetPicePosi(ViewX: WindowFlame.width, ViewY: WindowFlame.height)
      selfName = name
      
      super.init(frame: frame)
      
      SetImage(name: name)
      InitTileInfo(iPhoneWide: WindowFlame.width)
      InitPiceInfo(name: name)
      InitPiceFlameToStage()
      
      self.isUserInteractionEnabled = true
   }
   
   private func InitTileInfo(iPhoneWide: CGFloat) {
      TileWide = iPhoneWide / 10
      TileInter = iPhoneWide / 100
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
      let Width = TileWide! * CGFloat(PiceWideNum) + TileInter! * CGFloat(PiceWideNum)
      let Height = TileWide! * CGFloat(PiceHeightNum) + TileInter! * CGFloat(PiceHeightNum)
      PiceFlameToStage = CGRect(x: 0, y: 0, width: Width, height: Height)
   }
   
   private func SetImage(name: String) {
      self.image = UIImage(named: name)?.ResizeUIImage(width: 128, height: 128)
      
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
      self.frame = CGRect(x: frame.minX, y: frame.minY, width: PiceFlameToStage!.width, height: PiceFlameToStage!.height)
      AlphaImageView.frame = CGRect(x: 0, y: 0, width: PiceFlameToStage!.width, height: PiceFlameToStage!.height)
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

      self.center.x += dx
      self.center.y += dy
      
      PositionX = PicePosi.GetAlphasXPosi(AlPosiX: frame.minX, SizeWidth: PiceWideNum)
      PositionY = PicePosi.GetAlphasYPosi(AlPosiY: frame.minY, SizeHight: PiceHeightNum)
      
      if PositionX != PositionForHapTicX || PositionY != PositionForHapTicY {
         Play3DtouchLight()
         PositionForHapTicX = PositionX!
         PositionForHapTicY = PositionY!
      }
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      //FIXME:- kyouseiannrappuwotoru
      let XPosi = PicePosi.GetAnyPosiX(xpoint: PositionX!)
      let YPosi = PicePosi.GetAnyPosiY(ypoint: PositionY!)
      let Flame = CGRect(x: XPosi, y: YPosi, width: frame.width, height: frame.height)
      self.frame = Flame
      
      Play3DtouchMedium()
      
      let SentObject: [String : Any] = ["PiceName": selfName as String]
      NotificationCenter.default.post(name: .PickUpPiceImageView, object: nil, userInfo: SentObject)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}
