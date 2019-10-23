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
   
   private var isLocked = false
   var MoveMyself = true
   
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
      
      self.hero.modifiers = [.fade, .scale(0.5)]
      
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
      self.image = UIImage(contentsOfFile: Bundle.main.path(forResource: name, ofType: "png")!)?.ResizeUIImage(width: 180, height: 180)
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
      print("UpdateArryNum : \(ArryNum)")
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
                                           "PuzzleWide": self.PiceWideNum as Int,
                                           "PuzzleHight": self.PiceHeightNum as Int,
                                           "PArry": self.pAllPosi as Array]
      
      return AllInfomation
   }
   
   public func GetArryNum() -> Int {
      self.ArryNum!
   }
   
   public func ChangeTRUEMoveMyself() {
      self.MoveMyself = true
   }
   
   private func SaveSelfPosition() {
      self.BeforePositionX = self.PositionX
      self.BeforePositionY = self.PositionY
   }
   
   public func UpdateBeforXY() {
      BeforePositionX = PositionX
      BeforePositionY = PositionY
   }
   
   private func TouchPointIsAlpha(X: Int, Y: Int) -> Bool {
        if self.pAllPosi[Y][X] == .Out {
           print("透明部分をタップしました。")
           return true
        }
        return false
   }
   
   private func PuzzleTouchStartPostNotification(touches: Set<UITouch>, X: Int, Y: Int) {
      print("わたし \(self.ArryNum)が透明部を触ったことを通知します。")
      print("タップした座標: \(String(describing: touches.first?.location(in: self)))")
      
      let TouchPoint: CGPoint = touches.first!.location(in: self)
      
      let SentObject: [String : Any] = ["ArryNum": self.ArryNum!,
                                        "TapPosi": TouchPoint as CGPoint,
                                        "X": X as Int,
                                        "Y": Y as Int]
      
      print("")
      NotificationCenter.default.post(name: .PiceTouchStarted, object: nil, userInfo: SentObject)
   }
   
   private func PuzzleTouchMovedPostNotification(Dx: CGFloat, Dy: CGFloat) {
      let SentObject: [String : Any] = ["Dx": Dx as CGFloat,
                                        "Dy": Dy as CGFloat]
      
      NotificationCenter.default.post(name: .PiceTouchMoved, object: nil, userInfo: SentObject)
   }
   
   private func PuzzleTouchEndedPostNotification() {
      NotificationCenter.default.post(name: .PiceTouchEnded, object: nil, userInfo: nil)
   }
   
   private func UpdatePositionForTouchMove(dx: CGFloat, dy: CGFloat) {
      self.center.x += dx
      self.center.y += dy
      
      AlphaImageView.center.x -= dx
      AlphaImageView.center.y -= dy
      
      PositionX = PicePosi.GetAlphasXPosi(AlPosiX: frame.minX, SizeWidth: PiceWideNum)
      PositionY = PicePosi.GetAlphasYPosi(AlPosiY: frame.minY, SizeHight: PiceHeightNum)
      
      if PositionX != PositionForHapTicX || PositionY != PositionForHapTicY {
         Play3DtouchLight()
         PositionForHapTicX = PositionX!
         PositionForHapTicY = PositionY!
         
         let XPosi = PicePosi.GetAnyPosiX(xpoint: PositionX!)
         let YPosi = PicePosi.GetAnyPosiY(ypoint: PositionY!)
         let Flame = CGRect(x: XPosi - frame.minX, y: YPosi - frame.minY, width: frame.width, height: frame.height)
         AlphaImageView.frame = Flame
      }
   }
   
   //MARK:- 自前のタッチイベント
   public func SelfTouchBegan(){
      SaveSelfPosition()
   }

   public func SelfTouchMoved(Dx: CGFloat, Dy: CGFloat){
      guard MoveMyself == true else {
         return
      }
      UpdatePositionForTouchMove(dx: Dx, dy: Dy)
   }
   
   public func SelfTouchEnded(){
      FinishMoveTilePOSTMotification()
   }
   
   public func LockPuzzle() {
      self.isLocked = true
   }
   
   public func UnLockPuzzle() {
      self.isLocked = false
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      PiceToBeLarge()
      //もし地震がPickUPされてなければ，VCに対して他のPiceを削除する送信を行う
      if isPiceUp == false {
         let SentObject: [String : Any] = ["PiceName": selfName as String]
         NotificationCenter.default.post(name: .PickUpPiceImageView, object: nil, userInfo: SentObject)
         return
      }
      
      //CGFloat(PiceWideNum) / 2  は 左上に揃えるためにしてる
      let TapPosiX = touches.first!.location(in: self).x - CGFloat(TileWide!) / 2
      let TapPosiY = touches.first!.location(in: self).y - CGFloat(TileWide!) / 2
      
      let PosiX = Int(TapPosiX / CGFloat(TileWide!))
      let PosiY = Int(TapPosiY / CGFloat(TileWide!))

      print("TapPosi = (\(TapPosiX), \(TapPosiY))")
      print("Posi    = (\(PosiX), \(PosiY))")
      
      if TouchPointIsAlpha(X: PosiX, Y: PosiY) == true {
         MoveMyself = false
         SaveSelfPosition()
         PuzzleTouchStartPostNotification(touches: touches, X: PosiX, Y: PosiY)
         return
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
      
      //パズルの空白をタッチしてて，そこに違うパズルがあったら，そいつを移動させないとあかんから
      //ココでパズルの移動量をGameSceneに送る
      guard MoveMyself == true else {
         PuzzleTouchMovedPostNotification(Dx: dx, Dy: dy)
         return
      }
      
      UpdatePositionForTouchMove(dx: dx, dy: dy)


   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      //touchMove経由しなかったら，つまり，タップしたときにnilを防ぐ
      if PositionX == nil || PositionY == nil {
         PositionX = PicePosi.GetAlphasXPosi(AlPosiX: frame.minX, SizeWidth: PiceWideNum)
         PositionY = PicePosi.GetAlphasYPosi(AlPosiY: frame.minY, SizeHight: PiceHeightNum)
      }
      
      guard MoveMyself == true else {
         PuzzleTouchEndedPostNotification()
         return
      }
      
      
      FinishMoveTilePOSTMotification()
   }
   
   public func touchEndAndPutPice() {
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
   private func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
}
