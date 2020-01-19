//
//  UsersGameScene.swift
//  PazleBox
//
//  Created by jun on 2019/10/07.
//  Copyright © 2019 jun. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import SAConfettiView
import AudioToolbox
import FlatUIKit
import Firebase

class UsersGameScenePart2: SKScene {
   
   let AllStage = AllStageInfo()
   let Stage = HoldStage()
   
   var CheckedStage: [[Contents]] = Array()

   var PuzzleBox = Array<Any>()
   
   var DontMoveNodeNum = 0
   var ShouldMoveNodeNum = 0
   
   
   let Debug = true
   
   var RePutButtonNode: RePutButton?
   var PousePuttonNode: PouseNode?
   
   var PouseViewNode: PouseView?
   
   
   var PostedStageNum = 1
   
   var userDefaults = UserDefaults.standard
   
   private let GameSound = GameSounds()
   
    override func sceneDidLoad() {

      //ビューの長さを取得
      let ViewSizeX = self.scene?.frame.width
      let ViewSizeY = self.scene?.frame.height
      
      
      //MARK:- ココのトレースは，FirebaseがConfigurしてないとクラッシュする
      print("Users 初期化開始")
      let InitTimePeformance = Performance.startTrace(name: "InitUsersGameSeceneTime")
      

      InitBackGroundColor()
      
      InitStageNumber()
      
      InitStageSize(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      //ShowTile()
      
      InitRePutButton(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitPouseButton(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      InitPouseViewNode(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      
      //puzzleInit()
      AddPuzzle()
      
      CrearCheckedStage()
      
      InitNotification()
      
      //MARK:- ココのトレースは，FirebaseがConfigurしてないとクラッシュする
      print("Users初期化終わり")
      InitTimePeformance?.stop()

    }
   
 
   //MARK:- 初期化
   private func InitRePutButton(SizeX: CGFloat?, SizeY: CGFloat?){
      let RePutB = RePutButton(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      self.addChild(RePutB)
      
      RePutButtonNode = RePutB
   }
   
   
   
  
   
   private func InitPouseButton(SizeX: CGFloat?, SizeY: CGFloat?){
      let Pouse = PouseNode(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      self.addChild(Pouse)
      PousePuttonNode = Pouse
   }
   
   private func InitPouseViewNode(SizeX: CGFloat?, SizeY: CGFloat?){
      let CreatePouseView = PouseView(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      PouseViewNode = CreatePouseView
   }
   
 
   private func InitStageNumber() {
      print("Users ステージ番号の取得開始")
      self.PostedStageNum = userDefaults.integer(forKey: "StageNum")
      print("Users ステージ番号の取得完了: \(self.PostedStageNum)")
   }
   

   
   
   private func InitNotification() {
      print("Users 通知センター初期化開始")
      NotificationCenter.default.addObserver(self, selector: #selector(MovedTileCatchNotification(notification:)), name: .TileMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchStartCatchNotification(notification:)), name: .PuzzleTouchStart, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchMovedCatchNotification(notification:)), name: .PuzzleTouchMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchEndedCatchNotification(notification:)), name: .PuzzleTouchEnded, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(RePutCatchNotification(notification:)), name: .RePut, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PouseCatchNotification(notification:)), name: .Pouse, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(ReSumeCatchNotification(notification:)), name: .ReSume, object: nil)
      print("Users 通知センター初期化完了")
   }
   
   //MARK: パズルを初期化する。
   //Px Py に1片の長さを入れる
   public func InitPuzzleArrayBoforeScene(SizeX: CGFloat, SizeY: CGFloat, PiceArray: [PiceInfo]){
      print("Users パズルBoxの初期化開始")
      for tmp in 0 ... PiceArray.count - 1 {
         let Pice = PiceArray[tmp]
         let Puzzle = puzzle(PX: Pice.PiceW, PY: Pice.PiceH, CustNum: tmp, ViewX: Int(SizeX), ViewY: Int(SizeY),
                             PuzzleStyle: Pice.PiceName, PuzzleColor: Pice.PiceColor, RespawnX: Pice.ResX, RespawnY: Pice.ResY)
         
         PuzzleBox.append(Puzzle)
      }
      print("Users パズルBoxの初期化完了")
      
      puzzleInit()
   }
   

   
   //MARK:- チェックする配列を初期化する
   private func CrearCheckedStage() {
      CheckedStage = AllStage.Checked
   }
   
   //MARK: ステージの配列の取得
   //MARK:- ここはScene遷移する前にする
   public func SetStageArrayBeforeScene(StageArray: [[Contents]]){
      //FIXME:- ココの右辺は変数にするのがいいかも
      print("Users ステージの初期化開始")
      Stage.GStage = StageArray
      print("Users ステージの初期化完了")
      ShowTile()
   }
   
   
   private func puzzleInit() {
      print("Users 全てのパズルの表示開始")
      for Puzzle in PuzzleBox {
         addChild((Puzzle as! puzzle))
         addChild((Puzzle as! puzzle).GetAlhpaNode())
      }
      print("Users 全てのパズルの表示完了")
   }
   
   //元もファイルでも使用していない
   private func AddPuzzle() {}
   
   //背景色を決める
   private func InitBackGroundColor() {
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 0)
   }
   
   //MARK: 背景のタイルを表示してる。
   private func ShowTile(){
      print("Users タイルの表示開始")
      for x in 0 ... 11 {
         for y in 0 ... 8 {
            addChild(Stage.getAllTile(x: x, y: y))
         }
      }
      print("Users タイルの表示完了")
   }

   //MARK: ステージサイズを初期化してる。クラスにしても良さそう。
   private func InitStageSize(SizeX: CGFloat?, SizeY: CGFloat?){
       print("Users ステージサイズの初期化開始")
      if let X = SizeX {
         Stage.SetStageSizeX(SizeX: X)
      }else{
         fatalError("ビューの横を初期化できませんでした。")
      }
      if let Y = SizeY {
         Stage.SetStageSizeY(SizeY: Y)
      }else{
         fatalError("ビューの縦を初期化できませんでした。")
      }
      print("Users ステージサイズの初期化完了")
   }
   
   
   //MARK:- パズルロックするたやつ
   private func LockAllNode() {
      
      for Puzzle in PuzzleBox {
         (Puzzle as! puzzle).LockPuzzle()
      }
      RePutButtonNode?.LockPuzzle()
      PousePuttonNode?.LockPuzzle()
   }
   
   private func UnLockAllNode(){
      for Puzzle in PuzzleBox {
         (Puzzle as! puzzle).UnLockPuzzle()
      }
      RePutButtonNode?.UnLockPuzzle()
      PousePuttonNode?.UnLockPuzzle()
   }
   
   
   //MARK:- ゲーム終了。
   //ロックして，ポストするよー
   private func FinishGame() {
      print("game Set")
      LockAllNode()
      GameSerPOSTMotification()
   }
   
   //MARK:- 配列の情報を出力
   private func ShowCheckStage() {
      guard Debug else { return }
      
      for x in 0 ... 11 {
         print()
         for y in 0 ... 8 {
            if CheckedStage[11 - x][y] == .Out {
               print("\(CheckedStage[11 - x][y]) ", terminator: "")
            }else{
               print("\(CheckedStage[11 - x][y])  ", terminator: "")
            }
         }
      }
      print()
      print()
   }
   
   private func ShowStage(){
      guard Debug else {
         return
      }
      
      for x in 0 ... 11 {
         print()
         for y in 0 ... 8 {
            if Stage.GStage[11 - x][y] == .Out {
               print("\(Stage.GStage[11 - x][y]) ", terminator: "")
            }else{
               print("\(Stage.GStage[11 - x][y])  ", terminator: "")
            }
         }
      }
      print()
   }
   
   //MARK:- ゲーム終わって通知を送る関数
   private func GameSerPOSTMotification() {
      NotificationCenter.default.post(name: .UsersGameClear, object: nil, userInfo: nil)
   }
   
   //MARK:- ゲームのチェックを行う関数群
   private func GameCheck() -> Bool {
      ShowStage()
      ShowCheckStage()
      
      //MARK: これね
      //配列が一致したらおわりね
      if Stage.GStage.elementsEqual(CheckedStage) { return true }
      
      return false
   }
   
   //MARK:- 位置の判定をしてる
   func CheckLeftUp(x: Int, y: Int) -> Bool {
      if x >= 0 && y <= 11 { return true }
      return false
   }
   
   func CheckLeftDown(x: Int, y: Int) -> Bool {
      if x >= 0 && y >= 0 { return true }
      return false
   }
   
   func CheckRightUp(x: Int, y: Int) -> Bool {
      if x <= 8 && y <= 11 { return true }
      return false
   }
   
   func CheckRightDown(x: Int, y: Int) -> Bool {
      if x <= 8 && y >= 0 { return true }
      return false
   }
   
   //MARK: 存在しているパズル全てを判定用の配列に埋めていく
   private func CheckedStageFill(StageObject: [String : Any]) {
      
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
      
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightUpX = StartX + (PuzzleWide - 1)
      let RightUpY = StartY
      
      let LeftDownX = StartX
      let LeftDownY = StartY - (PuzzleHight - 1)
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY - (PuzzleHight - 1)
      
      //はみ出てたらさようなら。
      if CheckLeftUp(x: LeftUpX, y: LeftUpY) == false || CheckLeftDown(x: LeftDownX, y: LeftDownY) == false {
         return
      }
      
      if CheckRightUp(x: RightUpX, y: RightUpY) == false || CheckRightDown(x: RightDownX, y: RightDownY) == false {
         return
      }
      
      //ここでFillしてく
      for x in LeftUpX ... RightDownX {
         for y in RightDownY ... LeftUpY {
            let ReverseY = (LeftUpY - y) + RightDownY
            
            //.OutなのにFillしたら，もし先客が.In入れてた場合にOutで塗りつぶしてしまう。
            if PArry[y - RightDownY][x - LeftUpX] == .In {
               CheckedStage[ReverseY][x] = PArry[y - RightDownY][x - LeftUpX]
            }
         }
      }
   }
   
   //MARK: Notificationの後に毎回来る
   private func GameDecision() {
      
      //パズルを取り出して，判定用の配列にFillしちゃう
      for Puzzle in PuzzleBox {
         let PuzzleInfo = (Puzzle as! puzzle).GetOfInfomation()
         CheckedStageFill(StageObject: PuzzleInfo)
      }
      
      //MARK: ここここ，ここで帰るやつ
      if GameCheck() == true { FinishGame() }
      
      //ゲームが終わらなかったら，配列をクリアする。
      CrearCheckedStage()
      return
   }
   
   //MARK: Piceを置いたときに最初にChek配列にそいつを埋める
   private func CheckdPuzzleFillSentPazzle(StageObject: [String : Any]) -> Bool {
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
      
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightUpX = StartX + (PuzzleWide - 1)
      let RightUpY = StartY
      
      let LeftDownX = StartX
      let LeftDownY = StartY - (PuzzleHight - 1)
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY - (PuzzleHight - 1)
      
      //はみ出てたらさようなら。
      if CheckLeftUp(x: LeftUpX, y: LeftUpY) == false || CheckLeftDown(x: LeftDownX, y: LeftDownY) == false {
         return false
      }
      
      if CheckRightUp(x: RightUpX, y: RightUpY) == false || CheckRightDown(x: RightDownX, y: RightDownY) == false {
         return false
      }
      
      for x in LeftUpX ... RightDownX {
         for y in RightDownY ... LeftUpY {
            let ReverseY = (LeftUpY - y) + RightDownY
               CheckedStage[ReverseY][x] = PArry[y - RightDownY][x - LeftUpX]
         }
      }
      
      return true
   }
   
   //被っても動くように.
   private func SentCheckedStageFill(StageObject: [String : Any]) -> Bool {
      
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
      
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY - (PuzzleHight - 1)
      
      for x in LeftUpX ... RightDownX {
         for y in RightDownY ... LeftUpY {
            let ReverseY = (LeftUpY - y) + RightDownY
            if CheckedStage[ReverseY][x] == .In && PArry[y - RightDownY][x - LeftUpX] == .In {
               return true
            }
         }
      }
      
      return false
   }
   
   //MARK:- パズルが被ってるかを判定
   private func OverRapped(BirthDay: Int) -> Bool {
      let SentPazzle: puzzle = PuzzleBox[BirthDay] as! puzzle
      let SentPuzzleInfo = SentPazzle.GetOfInfomation()
      
      //はみ出てたらそもそもアウト
      if CheckdPuzzleFillSentPazzle(StageObject: SentPuzzleInfo) == false { return true }
      
      for Puzzle in PuzzleBox {
         //自分は調べないからcontinueで飛ばす
         if (Puzzle as! puzzle) == SentPazzle {
            print("かぶった。番号-> \((Puzzle as! puzzle).GetBirthDayNum())")
            continue
         }
         
         let PuzzleInfo = (Puzzle as! puzzle).GetOfInfomation()
         
         //かぶってたらReturn true
         if SentCheckedStageFill(StageObject: PuzzleInfo) == true { return true }
      }
      // 被りなし。
      return false
   }
   
   
   //MARK:- 送信された座標に他のパズル(.In)があるかどうかを判定。
   func PuzzleAwayyy(AwayX: Int, AwayY: Int, Puzzle: puzzle) -> Bool {
      
      if AwayX > 0 { return true }
      if AwayY < 0 { return true }
      
      let PuzzleWide = Puzzle.PuzzleWide
      let PuzzleHight = Puzzle.PuzzleHight
      
      if PuzzleWide + AwayX  <= 0 { return true }
      if PuzzleHight - AwayY <= 0 { return true }
      
      return false
   }
   
   func ExsitsPuzzle(SerchX: Int, SerchY: Int, SentNum: Int) -> Bool {
      for Puzzle in PuzzleBox {
         //送信者と一致したらcontinue
         if Puzzle as! puzzle == (PuzzleBox[SentNum] as! puzzle){
            print("Puzzle:\((Puzzle as! puzzle).GetBirthDayNum()) は送信者やからパス")
            continue
         }
         
         //上下左右にどれだけ離れてる。右が正，上が正
         let AwayNumX = (Puzzle as! puzzle).CenterX - SerchX
         let AwayNumY = (Puzzle as! puzzle).CenterY - SerchY
         
         print("AwayNum: (\(AwayNumX), \(AwayNumY))")
         
         //離れすぎてたらcontinue
         if PuzzleAwayyy(AwayX: AwayNumX, AwayY: AwayNumY, Puzzle: Puzzle as! puzzle) == true {
            print("Puzzle:\((Puzzle as! puzzle).GetBirthDayNum()) 離れすぎ")
            continue
         }
      
         //配列の座標に変換
         let x = -AwayNumX
         let y = AwayNumY
         
         //一致してたら，そいつの番号を保存してTRUEを返す。
         if (Puzzle as! puzzle).pAllPosi[y][x] == .In {
            ShouldMoveNodeNum = (Puzzle as! puzzle).GetBirthDayNum()
            print(".Inでした。こいつ動かします。")
            return true
         }else{
            print("あったけど .Out やったわ")
         }
      }
      
      return false
   }
   
   private func MovedNodePutRightPosition(BirthDay: Int, StageObject: [String : Any]) -> Bool{
      
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
      
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightUpX = StartX + (PuzzleWide - 1)
      let RightUpY = StartY
      
      let LeftDownX = StartX
      let LeftDownY = StartY - (PuzzleHight - 1)
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY - (PuzzleHight - 1)
      
      //はみ出てたらさようなら。
      if CheckLeftUp(x: LeftUpX, y: LeftUpY) == false || CheckLeftDown(x: LeftDownX, y: LeftDownY) == false { return false }
      
      if CheckRightUp(x: RightUpX, y: RightUpY) == false || CheckRightDown(x: RightDownX, y: RightDownY) == false { return false }
      
      //ここでFillしてく
      for x in LeftUpX ... RightDownX {
         for y in RightDownY ... LeftUpY {
            let ReverseY = (LeftUpY - y) + RightDownY
            
            if PArry[y - RightDownY][x - LeftUpX] == .Out { continue }
            
            if PArry[y - RightDownY][x - LeftUpX] != Stage.GStage[ReverseY][x] {
               return false
            }
         }
      }
      
      return true
   }
   
   //MARK:- サウンドとかパーティクル再生する
   private func PlayParticleForRightSet(BirthDay: Int) {
      let ParticlePuzzle = PuzzleBox[BirthDay] as! puzzle
      ParticlePuzzle.PlayParticleForRightSet()
   }
   
   private func PlaySoundKatch() {
      let queue = OperationQueue()
      let operation = BlockOperation {
        self.GameSound.PlaySounds(Type: 1)
      }
      queue.addOperation(operation)
   }
   
   //MARK:- 通知を受け取る関数郡
   @objc func MovedTileCatchNotification(notification: Notification) -> Void {
      print("--- Move notification ---")
      CrearCheckedStage()
      
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["BirthDay"] as! Int
         print("送信者番号: \(SentNum)")
         
         //Nodeを置いた場所に他のノードがいたら，元に戻ってもらう。
         if OverRapped(BirthDay: SentNum) == true {
            (PuzzleBox[SentNum] as! puzzle).ReBackNodePosition()
            CrearCheckedStage()
            return
         }
         
         CrearCheckedStage()
         
         //Nodeを置いた正しい場所(黒い場所)だったらパーティクル表示。
         let SentOb = (PuzzleBox[SentNum] as! puzzle).GetOfInfomation()
         if MovedNodePutRightPosition(BirthDay: SentNum, StageObject: SentOb) == true {
            PlayParticleForRightSet(BirthDay: SentNum)
            PlaySoundKatch()
         }
         
         CrearCheckedStage()
         //ゲーム判定へ。
         GameDecision()
         
      }else{ print("通知受け取ったけど、中身nilやった。") }
      
      return
   }
   
   //MARK: .OUTをタップしたときにPuzzleからくる関数
   @objc func PuzzleTouchStartCatchNotification(notification: Notification) -> Void {
      print("--- Alpha Tap notification ---")

      if let userInfo = notification.userInfo {
         let SentNum = userInfo["BirthDay"] as! Int
         let TapPosi = userInfo["TapPosi"] as! CGPoint
         let X = userInfo["X"] as! Int
         let Y = userInfo["Y"] as! Int
         print("送信者番号: \(SentNum)")
         print("タップした座標: \(TapPosi)")
         
         let SerchX = (PuzzleBox[SentNum] as! puzzle).CenterX + X
         let SerchY = (PuzzleBox[SentNum] as! puzzle).CenterY - Y
         
         print("SerchPoint: (\(SerchX), \(SerchY))")
         
         if ExsitsPuzzle(SerchX: SerchX, SerchY: SerchY, SentNum: SentNum) == true {
            print("存在してたよ！")
            DontMoveNodeNum = (PuzzleBox[SentNum] as! puzzle).GetBirthDayNum()
            print("SoudlNum = \(ShouldMoveNodeNum)")
            print("DontNum  = \(DontMoveNodeNum)")
            (PuzzleBox[ShouldMoveNodeNum] as! puzzle).SelfTouchBegan()
         }else{
            (PuzzleBox[SentNum] as! puzzle).ChangeTRUEMoveMyself()
            return
         }
         
      }else{
         print("通知受け取ったけど、中身nilやった。")
      }
      
      return
   }
   
   @objc func PuzzleTouchMovedCatchNotification(notification: Notification) -> Void {
      if let userInfo = notification.userInfo {
         let Dx = userInfo["Dx"] as! CGFloat
         let Dy = userInfo["Dy"] as! CGFloat
         
         let ShouldMovedNode = PuzzleBox[ShouldMoveNodeNum] as! puzzle
         
         ShouldMovedNode.SelfTouchMoved(Dx: Dx, Dy: Dy)
      }
   }
   
   @objc func PuzzleTouchEndedCatchNotification(notification: Notification) -> Void {
      let ShouldMovedNode = PuzzleBox[ShouldMoveNodeNum] as! puzzle
      let DontMoveNode = PuzzleBox[DontMoveNodeNum] as! puzzle
      
      ShouldMovedNode.SelfTouchEnded()
      
      DontMoveNode.ChangeTRUEMoveMyself()
   }
   
   //RePutButtonを押した時の処理。リスポーンに戻して，音を鳴らす。
   @objc func RePutCatchNotification(notification: Notification) -> Void {
      
      for Puzzle in PuzzleBox {
         (Puzzle as! puzzle).PositionToRespown()
      }
      GameSound.PlaySounds(Type: 2)
   }
   
   
   //MARK:  ポーズをする
   @objc func PouseCatchNotification(notification: Notification) -> Void {
      print("PouseCatchNotifi")
      
      if self.PouseViewNode!.GetIsLocked() == false {
         GameSound.PlaySoundsTapButton()
         self.addChild(self.PouseViewNode!)
         self.PouseViewNode!.ShowViewAnimation()
         LockAllNode()
      }else{
         print("現在Viewを消している最中です.")
      }
   }
 

 
   @objc func ReSumeCatchNotification(notification: Notification) -> Void {
      print("ReSumeCatchNotifi")
      //PouseViewNode?.removeFromParent()
      PouseViewNode?.FadeOutAniAndRemoveFromParent()
      UnLockAllNode()
      GameSound.PlaySoundsTapButton()
   }
   
 

    override func update(_ currentTime: TimeInterval) { }
}
