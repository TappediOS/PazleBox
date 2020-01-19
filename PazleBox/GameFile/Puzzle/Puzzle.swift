//
//  Puzzle.swift
//  PazleBox
//
//  Created by jun on 2019/03/10.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import TapticEngine
import Firebase

class puzzle: SKSpriteNode {

   //selfの配列を取得する
   var pAllPosi: [[Contents]] = Array()
   //配列を全部取る重い気がする
   var SerchpAllPosi = PArry()
   
   public var PuzzleWide = 0
   public var PuzzleHight = 0
   
   public var CenterX: Int = 0
   public var CenterY: Int = 0
   
   private var RespawnX: Int = 0
   private var RespawnY: Int = 0
   
   //1回前のパズルの場所を保存する
   public var OneTimeBackPosiX: Int = 0
   public var OneTimeBackPosiY: Int = 0
   
   private var BeforeCenterX: Int = 0
   private var BeforeCenterY: Int = 0
   
   public var TouchBegan: CGPoint
   
   private var PuzzleStyle: String
   private var PuzzleColor: String
   private var BirthDayNum: Int
   
   private var isLocked = false
   
   private var AlphaNode = SKSpriteNode()
   
   //割って場所を特定する
   var SerchPlace: CGFloat
   
   var Tilep: TilePosi
   
   
   var MoveMyself = true
   
   var PuzzleSizeWide: Int
   
   private var PlayParticle = false
   
   //var SetParticles: PutParticle
   //var SetParticle = SKEmitterNode()
   
   
   init(PX: Int, PY: Int, CustNum: Int, ViewX: Int, ViewY: Int, PuzzleStyle: String, PuzzleColor: String, RespawnX: Int, RespawnY: Int) {
      
      self.BirthDayNum = CustNum
      
      self.PuzzleStyle = PuzzleStyle
      self.PuzzleColor = PuzzleColor
      
      self.PuzzleWide = PX
      self.PuzzleHight = PY
      
      self.RespawnX = RespawnX
      self.RespawnY = RespawnY
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      
      self.PuzzleSizeWide = PazzleSizeFound
      
      //MARK: 移動後の座標提供者の初期化
      SerchPlace = CGFloat(PazzleSizeFound)
      self.Tilep = TilePosi(ViewX: ViewX, ViewY: ViewY)
      
      let PazzleWideSize = PazzleSizeFound * PX
      let PazzleHightSize = PazzleSizeFound * PY
   
   
      //FIXME: 使ってない
      self.TouchBegan = CGPoint(x: 0, y: 0)
      
      //MARK: 画像の初期化
      let texture: SKTexture
      let TextureName = PuzzleStyle + PuzzleColor
      
      //キャッシュ化しないようにcontentOfFiletで画像を取得 128 * 128 やったらぼやける
      let TextureUIImage = UIImage(contentsOfFile: Bundle.main.path(forResource: TextureName, ofType: "png")!)?.ResizeUIImage(width: 200, height: 200)
      
      texture = SKTexture(image: TextureUIImage!)
      texture.usesMipmaps = false
      
      
      
      //SetParticles = PutParticle(PX: PX, PY: PY, CustNum: CustNum, ViewX: ViewX, ViewY: ViewY)
      
      let NodeSize = CGSize(width: CGFloat(PazzleWideSize), height: CGFloat(PazzleHightSize))
      
      super.init(texture: texture, color: UIColor.black, size: NodeSize)
      
      //MARK: アンカーの設定。
      let Anchor = CGPoint(x: 1 / CGFloat(PX * 2), y: 1 - 1 / CGFloat(PY * 2) )
      self.anchorPoint = Anchor
      //ノードがタッチできる状態にする。
      self.isUserInteractionEnabled = true
      
      
      //ポジションの設定。
      self.CenterX = self.RespawnX
      self.CenterY = self.RespawnY
      
      self.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      //FIXME:- これは多さによって変えるべきである。
      self.zPosition = 16
      
      AlphaNode = SKSpriteNode(texture: texture, color: UIColor.black, size: NodeSize)
      
      AlphaNode.anchorPoint = Anchor
      AlphaNode.position = self.position
      AlphaNode.zPosition = 6
      AlphaNode.isUserInteractionEnabled = false
      
      AlphaNode.alpha = 0.575

      //SetParticle = SetParticles.GetParticle()
      
      InitPazzle()
   }
   

   private func InitSetParticle() {
      
   }
   
   //MARK:- 初期化
   func InitPazzle(){
      //場所を決める
      self.CenterX = self.RespawnX
      self.CenterY = self.RespawnY
      self.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      self.AlphaNode.position = self.position
      //MARK: 配列にここで入れる
      self.pAllPosi = SerchpAllPosi.GerPArry(PuzzleStyle: self.PuzzleStyle)
   }
   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK:- 取得
   func GetAlhpaNode() -> SKSpriteNode {
      return self.AlphaNode
   }

   //MARK:- 通知を送信
   //FIXME:- もしかしたら，SentObjectいらんかも
   private func FinishMoveTilePOSTMotification() {
      
      let SentObject: [String : Any] = ["BirthDay": self.BirthDayNum as Int]
      
      print("")
      NotificationCenter.default.post(name: .TileMoved, object: nil, userInfo: SentObject)
   }
   
   public func GetOfInfomation() -> [String : Any] {
      let AllInfomation: [String : Any] = ["StartPointX": self.CenterX as Int,
                                           "StartPointY": self.CenterY as Int,
                                           "PuzzleWide": self.PuzzleWide as Int,
                                           "PuzzleHight": self.PuzzleHight as Int,
                                           "PArry": self.pAllPosi as Array]
      
      return AllInfomation
   }
   
   private func PuzzleTouchStartPostNotification(touches: Set<UITouch>, X: Int, Y: Int) {
      print("わたし \(self.BirthDayNum)が透明部を触ったことを通知します。")
      print("タップした座標: \(String(describing: touches.first?.location(in: self)))")
      
      let TouchPoint: CGPoint = touches.first!.location(in: self)
      
      let SentObject: [String : Any] = ["BirthDay": self.BirthDayNum as Int,
                                        "TapPosi": TouchPoint as CGPoint,
                                        "X": X as Int,
                                        "Y": Y as Int]
      
      print("")
      NotificationCenter.default.post(name: .PuzzleTouchStart, object: nil, userInfo: SentObject)
   }
   
   private func PuzzleTouchMovedPostNotification(Dx: CGFloat, Dy: CGFloat) {
      let SentObject: [String : Any] = ["Dx": Dx as CGFloat,
                                        "Dy": Dy as CGFloat]
      
      NotificationCenter.default.post(name: .PuzzleTouchMoved, object: nil, userInfo: SentObject)
   }
   
   private func PuzzleTouchEndedPostNotification() {
      NotificationCenter.default.post(name: .PuzzleTouchEnded, object: nil, userInfo: nil)
   }
   
   //MARK:- ノードの場所を更新する
   func UpdateAlphaNodePosi() {
      let Selfx = self.position.x
      let Selfy = self.position.y
      
      let BeforeCenterX = self.CenterX
      let BeforeCenterY = self.CenterY
      
      //print(Selfy / SerchPlace)
      self.CenterX = Tilep.GetAlphasXPosi(AlPosiX: Selfx / SerchPlace, SizeWidth: self.PuzzleWide)
      self.CenterY = Tilep.GetAlphasYPosi(AlPosiY: Selfy / SerchPlace, SizeHight: self.PuzzleHight)
      self.AlphaNode.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      
      //前回の場所と今回の場所に変化があったら，前回の場所を保存
      if self.CenterX != BeforeCenterX || self.CenterY != BeforeCenterY {
         Play3DtouchLight()
         OneTimeBackPosiX = BeforeCenterX
         OneTimeBackPosiY = BeforeCenterY
      }
   }
   

   public func ReBackNodePosition() {
      
      self.CenterX = BeforeCenterX
      self.CenterY = BeforeCenterY
      
      let BeforePoint = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      
      self.position = BeforePoint
      self.AlphaNode.position = BeforePoint
      
      Play3DtouchHeavy()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         self.Play3DtouchHeavy()
      }
   }
   
   private func UpdateSelfPosi(){
      self.position = AlphaNode.position
      Play3DtouchMedium()
   }
   
   public func PositionToRespown() {
      self.CenterX = self.RespawnX
      self.CenterY = self.RespawnY
      self.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
      self.AlphaNode.position = Tilep.GetAnyPostionXY(xpoint: self.CenterX, ypoint: self.CenterY)
   }
   
   private func SaveSelfPosition() {
      self.BeforeCenterX = self.CenterX
      self.BeforeCenterY = self.CenterY
   }
   
   public func GetBirthDayNum() -> Int{
      return self.BirthDayNum
   }
   
   public func ChangeTRUEMoveMyself() {
      self.MoveMyself = true
   }
   
   func TouchPointIsAlpha(X: Int, Y: Int) -> Bool {
      if self.pAllPosi[Y][X] == .Out {
         print("透明部分をタップしました。")
         return true
      }
      
      return false
   }
   
   public func PlayParticleForRightSet() {
      Play3DtouchHeavy()
      return
   }
   
   //MARK:- 自前のタッチイベント
   public func SelfTouchBegan(){
      self.zPosition += 2
      SaveSelfPosition()
   }
   
   
   public func SelfTouchMoved(Dx: CGFloat, Dy: CGFloat){
      guard MoveMyself == true else {
         return
      }
      
      self.position.x += Dx
      self.position.y += Dy
      
      UpdateAlphaNodePosi()
   }
   
   public func SelfTouchEnded(){
      self.zPosition -= 2
      UpdateSelfPosi()
      FinishMoveTilePOSTMotification()
   }
   
   public func LockPuzzle() {
      self.isLocked = true
   }
   
   public func UnLockPuzzle() {
      self.isLocked = false
   }
   
   //MARK:- タッチイベント
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      if isLocked == true {
         return
      }
      
      self.zPosition += 2
      
      //CGFloat(PuzzleSizeWide) / 2  は 左上に揃えるためにしてる
      let TapPosiX = touches.first!.location(in: self).x + CGFloat(PuzzleSizeWide) / 2
      let TapPosiY = -touches.first!.location(in: self).y + CGFloat(PuzzleSizeWide) / 2
      
      let PosiX = Int(TapPosiX / CGFloat(PuzzleSizeWide))
      let PosiY = Int(TapPosiY / CGFloat(PuzzleSizeWide))

      print("TapPosi = (\(TapPosiX), \(TapPosiY))")
      print("Posi    = (\(PosiX), \(PosiY))")
      
      if TouchPointIsAlpha(X: PosiX, Y: PosiY) == true {
         MoveMyself = false
         SaveSelfPosition()
         PuzzleTouchStartPostNotification(touches: touches, X: PosiX, Y: PosiY)
         return
      }
      
      
      SaveSelfPosition()
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      if isLocked == true {
         return
      }

      // タッチイベントを取得
      let touchEvent = touches.first!
      let PreviewXPoint = touchEvent.previousLocation(in: self).x
      let PreviewYPoint = touchEvent.previousLocation(in: self).y
      
      let AfterXPoint = touchEvent.location(in: self).x
      let AfterYPoint = touchEvent.location(in: self).y
      
      let Dx = AfterXPoint - PreviewXPoint
      let Dy = AfterYPoint - PreviewYPoint
      
      //パズルの空白をタッチしてて，そこに違うパズルがあったら，そいつを移動させないとあかんから
      //ココでパズルの移動量をGameSceneに送る
      guard MoveMyself == true else {
         PuzzleTouchMovedPostNotification(Dx: Dx, Dy: Dy)
         return
      }
   
      self.position.x += Dx
      self.position.y += Dy
      
      //print("\(self.position.x), \(self.position.y)")
      UpdateAlphaNodePosi()
      
   }
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if isLocked == true {
         return
      }
      
      self.zPosition -= 2
      
      guard MoveMyself == true else {
         PuzzleTouchEndedPostNotification()
         return
      }
      
      UpdateSelfPosi()
      FinishMoveTilePOSTMotification()
   }
   
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     
   }
   
   //MARK:- 3dタッチならす
   
   private func Play3DtouchLight() {
      TapticEngine.impact.feedback(.light)
      return
   }
   
   private func Play3DtouchMedium() {
      TapticEngine.impact.feedback(.medium)
      return
   }
   
   private func Play3DtouchHeavy() {
      TapticEngine.impact.feedback(.heavy)
      return
   }
}
