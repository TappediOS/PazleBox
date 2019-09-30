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

   var pAllPosi: [[Contents]] = Array()
   var SerchpAllPosi = PArry() //こいつは重いぞー
   
   var ArryNum: Int? = 0
   
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
   
   //フィールドに出ているかどうか
   var isPiceUp: Bool = false
   
   init(frame: CGRect, name: String, WindowFlame: CGRect) {
      
      AlphaImageView = UIImageView(frame: frame)
      self.PicePosi = GetPicePosi(ViewX: WindowFlame.width, ViewY: WindowFlame.height)
      selfName = name
      
      super.init(frame: frame)
      
      SetImage(name: name)
      InitTileInfo(iPhoneWide: WindowFlame.width)
      InitPiceInfo(name: name)
      InitPiceFlameToStage()
      
      InitPiceArry(name: name)
      
      self.isUserInteractionEnabled = true
   }
   
   /// タイルの大きさ設定
   /// - Parameter iPhoneWide: userのデバイスの横画面
   private func InitTileInfo(iPhoneWide: CGFloat) {
      TileWide = iPhoneWide / 10
      TileInter = iPhoneWide / 100
   }
   
   /// 縦と横の長さカウントを取得する
   /// - Parameter name: PICEの名前
   private func InitPiceInfo(name: String) {
      //正規表現で23p11とかの初めの2文字をInt型で取得
      if let PiceNumber = Int(name.pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")) {
         PiceHeightNum = PiceNumber % 10
         PiceWideNum = (PiceNumber - PiceHeightNum) / 10
      }else{
         fatalError("正規表現でint型を取得できない")
      }
   }
   
   /// PiceのしんのFlameを設定する
   private func InitPiceFlameToStage() {
      let Width = TileWide! * CGFloat(PiceWideNum) + TileInter! * CGFloat(PiceWideNum)
      let Height = TileWide! * CGFloat(PiceHeightNum) + TileInter! * CGFloat(PiceHeightNum)
      PiceFlameToStage = CGRect(x: 0, y: 0, width: Width, height: Height)
   }
   
   /// 引数からImageを生成する
   /// - Parameter name: Piceの名前
   private func SetImage(name: String) {
      self.image = UIImage(contentsOfFile: Bundle.main.path(forResource: name, ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)
   }
   
   /// Alpha Imageの生成
   public func SetUPAlphaImageView() {
      AlphaImageView.image = self.image
      AlphaImageView.alpha = 0.25
      AlphaImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      AlphaImageView.isUserInteractionEnabled = false
      addSubview(AlphaImageView)
   }
   
   private func InitPiceArry(name: String) {
      let PiceName = name.pregReplace(pattern: "(Green|Blue|Red)", with: "")
      self.pAllPosi = SerchpAllPosi.GerPArry(PuzzleStyle: PiceName)
   }
   
   /// Piceを大きくする
   private func PiceToBeLarge() {
      self.frame = CGRect(x: frame.minX, y: frame.minY, width: PiceFlameToStage!.width, height: PiceFlameToStage!.height)
      AlphaImageView.frame = CGRect(x: 0, y: 0, width: PiceFlameToStage!.width, height: PiceFlameToStage!.height)
   }
   
   /// Piceが選択された状態にする
   /// これはVCから操作される
   public func ChangeTRUEisPiceUp() {
      self.isPiceUp = true
   }
   
   public func UpdateArryNum(ArryNum: Int) {
      self.ArryNum = ArryNum
   }
   
   //MARK:- 通知を送信
   //FIXME:- もしかしたら，SentObjectいらんかも
   private func FinishMoveTilePOSTMotification() {
      if self.ArryNum == nil {
         fatalError("配列番号がnilやのに置いてる")
      }
      let SentObject: [String : Any] = ["ArryNum": self.ArryNum!]
      
      print("")
      NotificationCenter.default.post(name: .PiceMoved, object: nil, userInfo: SentObject)
   }
   
   public func isBeforPositionIsNothing() -> Bool {
      if (BeforePositionX == nil || BeforePositionY == nil) { return true }
      return false
   }
   
   public func ReBackPicePosition() {
      self.PositionX! = BeforePositionX!
      self.PositionY! = BeforePositionY!
      
      let BeforePoint = PicePosi.GetAnyPostionXY(xpoint: self.PositionX!, ypoint: self.PositionY!)
      
      let Flame = CGRect(x: BeforePoint.x, y: BeforePoint.y, width: frame.width, height: frame.height)
      self.frame = Flame
      //TODO:- Alphaも白
      //self.AlphaNode.position = BeforePoint
      
      Play3DtouchHeavy()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         self.Play3DtouchHeavy()
      }
   }
   
   public func GetOfInfomation() -> [String : Any] {
      let AllInfomation: [String : Any] = ["StartPointX": self.PositionX! as Int,
                                           "StartPointY": self.PositionY! as Int,
                                           "PuzzleWide": self.PiceHeightNum as Int,
                                           "PuzzleHight": self.PiceHeightNum as Int,
                                           "PArry": self.pAllPosi as Array]
      
      return AllInfomation
   }
   
   public func GetArryNum() -> Int {
      self.ArryNum!
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      PiceToBeLarge()
      //もし地震がPickUPされてなければ，VCに対して送信を行う
      if isPiceUp == false {
         let SentObject: [String : Any] = ["PiceName": selfName as String]
         NotificationCenter.default.post(name: .PickUpPiceImageView, object: nil, userInfo: SentObject)
      }
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
      
      //これはCPU使いまくる場合はなくてもいいかもしれない
      AlphaImageView.center.x -= dx
      AlphaImageView.center.y -= dy
      //これはCPU使いまくる場合はなくてもいいかもしれない
      
      PositionX = PicePosi.GetAlphasXPosi(AlPosiX: frame.minX, SizeWidth: PiceWideNum)
      PositionY = PicePosi.GetAlphasYPosi(AlPosiY: frame.minY, SizeHight: PiceHeightNum)
      
      if PositionX != PositionForHapTicX || PositionY != PositionForHapTicY {
         Play3DtouchLight()
         PositionForHapTicX = PositionX!
         PositionForHapTicY = PositionY!
         
         //これはCPU使いまくる場合はなくてもいいかもしれない
         let XPosi = PicePosi.GetAnyPosiX(xpoint: PositionX!)
         let YPosi = PicePosi.GetAnyPosiY(ypoint: PositionY!)
         let Flame = CGRect(x: XPosi - frame.minX, y: YPosi - frame.minY, width: frame.width, height: frame.height)
         AlphaImageView.frame = Flame
         //これはCPU使いまくる場合はなくてもいいかもしれない
      }
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      //FIXME:- kyouseiannrappuwotoru
      let XPosi = PicePosi.GetAnyPosiX(xpoint: PositionX!)
      let YPosi = PicePosi.GetAnyPosiY(ypoint: PositionY!)
      let Flame = CGRect(x: XPosi, y: YPosi, width: frame.width, height: frame.height)
      self.frame = Flame
      
      let AlphaViewFlame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      AlphaImageView.frame = AlphaViewFlame
      
      Play3DtouchMedium()
      
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}
