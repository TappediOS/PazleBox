//
//  GameScene.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import SAConfettiView
import AudioToolbox
import FlatUIKit


class GameScene: SKScene {
   
   
   let AllStage = AllStageInfo()
   let Stage = HoldStage()
   
   var CheckedStage: [[Contents]] = Array()
   


   var PuzzleBox = Array<Any>()
   var HintPuzzleBox = Array<Any>()
   
   var DontMoveNodeNum = 0
   var ShouldMoveNodeNum = 0
   
   
   let Debug = true
   
   var HintButtonNode: HintNode?
   var RePutButtonNode: RePutButton?
   var PousePuttonNode: PouseNode?
   
   var PouseViewNode: PouseView?
   
   var HintPouseViewNode: HintPouseView?
   
   
   var PostedStageNum = 1
   var StageLebel: StageLevel = .Easy
   
   var userDefaults = UserDefaults.standard
   
   private let GameSound = GameSounds()
   private var GameBGM = BGM()
   
    override func sceneDidLoad() {

      //ビューの長さを取得
      let ViewSizeX = self.scene?.frame.width
      let ViewSizeY = self.scene?.frame.height

      InitBackGroundColor()
      
      InitStageLevel()
      InitStageNumber()
      
      InitStageSize(SizeX: ViewSizeX, SizeY: ViewSizeY)
      SetStage(StageNum: self.PostedStageNum)
      
      ShowTile()
      
      InitRePutButton(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitHintButton(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitPouseButton(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      InitPouseViewNode(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitHintPouseViewNode(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      InitHintPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      
      puzzleInit()
      AddPuzzle()
      
      CrearCheckedStage()
      
      InitNotification()
      
      
      
      //InitBGM()
      
      let p = SKEmitterNode.init(fileNamed: "GameSetParticle")
      p?.position.y += ViewSizeY! / 2
      //addChild(p!)
    }
   
 
   //MARK:- 初期化
   private func InitRePutButton(SizeX: CGFloat?, SizeY: CGFloat?){
      let RePutB = RePutButton(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      self.addChild(RePutB)
      
      RePutButtonNode = RePutB
   }
   
   private func InitBGM() {
      self.GameBGM.PlaySounds()
   }
   
   private func InitHintButton(SizeX: CGFloat?, SizeY: CGFloat?){
      let HintButton = HintNode(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      self.addChild(HintButton)
      self.addChild(HintButton.GetCirc1())
      self.addChild(HintButton.GetCirc2())
      
      HintButtonNode = HintButton
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
   
   private func InitHintPouseViewNode(SizeX: CGFloat?, SizeY: CGFloat?){
      let CreateHintPouseView = HintPouseView(ViewX: Int(SizeX!), ViewY: Int(SizeY!))
      HintPouseViewNode = CreateHintPouseView
   }
   
   private func InitStageNumber() {
      print("ステージ番号の取得開始")
      self.PostedStageNum = userDefaults.integer(forKey: "StageNum")
      print("ステージ番号の取得完了: \(self.PostedStageNum)")
      //self.PostedStageNum = self.userData?.value(forKey: "StageNum") as! Int
   }
   
   private func InitStageLevel() {
      print("ステージ難易度の取得開始")
      switch userDefaults.integer(forKey: "SelectedStageLevel") {
      case 1:
         self.StageLebel = .Easy
      case 2:
         self.StageLebel = .Normal
      case 3:
         self.StageLebel = .Hard
      default:
         fatalError()
      }
      print("ステージ難易度の取得完了: \(self.StageLebel)")
      
   }
   
   
   private func InitNotification() {
      print("通知センター初期化開始")
      NotificationCenter.default.addObserver(self, selector: #selector(MovedTileCatchNotification(notification:)), name: .TileMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchStartCatchNotification(notification:)), name: .PuzzleTouchStart, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchMovedCatchNotification(notification:)), name: .PuzzleTouchMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PuzzleTouchEndedCatchNotification(notification:)), name: .PuzzleTouchEnded, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(RePutCatchNotification(notification:)), name: .RePut, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(HintCatchNotification(notification:)), name: .Hint, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PouseCatchNotification(notification:)), name: .Pouse, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(ReSumeCatchNotification(notification:)), name: .ReSume, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(AdWatchCatchNotification(notification:)), name: .AdWatch, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(AdNoWatchCatchNotification(notification:)), name: .AdNoWatch, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(FinRewardWatchCatchNotification(notification:)), name: .FinRewardWatch, object: nil)
      print("通知センター初期化完了")
   }
   
   //MARK: パズルを初期化する。
   //Px Py に1片の長さを入れる
   private func InitPuzzle(SizeX: CGFloat?, SizeY: CGFloat?){
      print("パズルBoxの初期化開始")
      switch self.StageLebel {
      case .Easy:
         PuzzleBox = GetEasyPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      case .Normal:
         PuzzleBox = GetNormalPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      case .Hard:
         PuzzleBox = GetHardPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      }
       print("パズルBoxの初期化完了")
   }
   
   private func InitHintPuzzle(SizeX: CGFloat?, SizeY: CGFloat?) {
      print("パズルBox(Hint)の初期化開始")
      switch self.StageLebel {
      case .Easy:
         HintPuzzleBox = GetEasyHintPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      case .Normal:
         HintPuzzleBox = GetNormalHintPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      case .Hard:
         HintPuzzleBox = GetHardHintPuzzleBox(ViewSizeX: SizeX!, ViewSizeY: SizeY!)
      }
      print("パズルBox(Hint)の初期化完了")
   }
   
   //MARK:- チェックする配列を初期化する
   private func CrearCheckedStage() {
      CheckedStage = AllStage.Checked
   }
   
   //MARK: ステージの配列の取得
   private func SetStage(StageNum: Int){
      //FIXME:- ココの右辺は変数にするのがいいかも
      print("ステージの初期化開始")
      
      switch self.StageLebel {
      case .Easy:
         Stage.GStage = GetEasyMainStage()
      case .Normal:
         Stage.GStage = GetNormalMainStage()
      case .Hard:
         Stage.GStage = GetHardMainStage()
      }
      print("ステージの初期化完了")
   }
   
   
   private func puzzleInit() {
      //ココの引数は特に使ってない。場所の位置変更で使ってもいいかも。
      //pAllArryの初期化をしてるね。
      //
      print("全てのパズルの表示開始")
      for Puzzle in PuzzleBox {
         addChild((Puzzle as! puzzle))
         addChild((Puzzle as! puzzle).GetAlhpaNode())
      }
      print("全てのパズルの表示完了")
   }
   
   //配列に入れて行ってる
   private func AddPuzzle() { }
   
   private func InitBackGroundColor() {
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 0)
   }
   
   //MARK: 背景のタイルを表示してる。
   private func ShowTile(){
      print("タイルの表示開始")
      for x in 0 ... 11 {
         for y in 0 ... 8 {
            addChild(Stage.getAllTile(x: x, y: y))
         }
      }
      print("タイルの表示完了")
   }

   //MARK: ステージサイズを初期化してる。クラスにしても良さそう。
   private func InitStageSize(SizeX: CGFloat?, SizeY: CGFloat?){
       print("ステージサイズの初期化開始")
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
      print("ステージサイズの初期化完了")
   }
   
   
   //MARK:- パズルアンロックするたやつ
   private func LockAllNode() {
      
      for Puzzle in PuzzleBox {
         (Puzzle as! puzzle).LockPuzzle()
      }
      RePutButtonNode?.LockPuzzle()
      HintButtonNode?.LockPuzzle()
      PousePuttonNode?.LockPuzzle()
   }
   
   private func UnLockAllNode(){
      for Puzzle in PuzzleBox {
         (Puzzle as! puzzle).UnLockPuzzle()
      }
      RePutButtonNode?.UnLockPuzzle()
      HintButtonNode?.UnLockPuzzle()
      PousePuttonNode?.UnLockPuzzle()
   }
   
   
   //MARK:- ゲーム終了。
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
      print("")
      let CountOfUsedHint = HintButtonNode?.GetCountOfUsedHint()
      print("ヒントを使った回数：　\(String(describing: CountOfUsedHint))")
      let SentObject: [String : Any] = ["CountOfUsedHint": CountOfUsedHint! as Int]
      NotificationCenter.default.post(name: .GameClear, object: nil, userInfo: SentObject)
   }
   
   //MARK:- ゲームの行う関数群
   private func GameCheck() -> Bool {
      //TODO: デバック終わったら消してOK
      ShowStage()
      ShowCheckStage()
      
      //MARK: これね
      //配列が一致したらおわりね
      if Stage.GStage.elementsEqual(CheckedStage) { return true }
      
      return false
   }
   
   //MARK:- 位置の判定をしてる
   private func CheckLeftUp(x: Int, y: Int) -> Bool {
      if x >= 0 && y <= 11 { return true }
      return false
   }
   
   private func CheckLeftDown(x: Int, y: Int) -> Bool {
      if x >= 0 && y >= 0 { return true }
      return false
   }
   
   private func CheckRightUp(x: Int, y: Int) -> Bool {
      if x <= 8 && y <= 11 { return true }
      return false
   }
   
   private func CheckRightDown(x: Int, y: Int) -> Bool {
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
   
   //MARK: なんかこれおんなじことしてていらんような気がする。
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
   private func PuzzleAwayyy(AwayX: Int, AwayY: Int, Puzzle: puzzle) -> Bool {
      
      if AwayX > 0 { return true }
      if AwayY < 0 { return true }
      
      let PuzzleWide = Puzzle.PuzzleWide
      let PuzzleHight = Puzzle.PuzzleHight
      
      if PuzzleWide + AwayX  <= 0 { return true }
      if PuzzleHight - AwayY <= 0 { return true }
      
      return false
   }
   
   private func ExsitsPuzzle(SerchX: Int, SerchY: Int, SentNum: Int) -> Bool {
      
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
         //TODO:- カチって音を鳴らすならここ
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
   
   //MARK: ナニコノカンスウ？
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
   
   //MARK: ヒント表示
   @objc func HintCatchNotification(notification: Notification) -> Void {
      print("HintCatchNotifi")
      
      if HintButtonNode?.CountOfHint == 0 { return }
      
      if HintButtonNode?.CountOfHint == 2{
         SetHint1()
      }
      
      if HintButtonNode?.CountOfHint == 1 && userDefaults.bool(forKey: "BuyRemoveAd") == true{
         SetHint2()
      }
      
      if HintButtonNode?.CountOfHint == 1 && userDefaults.bool(forKey: "BuyRemoveAd") == false{
         if HintButtonNode?.GetEnableLastHint() == true{
            GameSound.PlaySoundsTapButton()
            AdShowOrNot()
            return
         }
         SetHint2()
      }
      
      
      GameSound.PlaySounds(Type: 3)
      HintButtonNode?.DecleCountOfHint()
   }
   
   @objc func AdWatchCatchNotification(notification: Notification) -> Void {
      print("AdWatchCatchNotification")
      //PouseViewNode?.removeFromParent()
      
      GameSound.PlaySoundsTapButton()
      ShowAdPOSTMotification()
      //FIXME:-  これは広告をちゃんと見た人に表示する
      
      
      HintPouseViewNode?.FadeOutAniAndRemoveFromParent()
      UnLockAllNode()
   }
   
   @objc func AdNoWatchCatchNotification(notification: Notification) -> Void {
      print("AdNoWatchCatchNotification")
      //PouseViewNode?.removeFromParent()
      HintPouseViewNode?.FadeOutAniAndRemoveFromParent()
      UnLockAllNode()
      GameSound.PlaySoundsTapButton()
   }
   
   @objc func FinRewardWatchCatchNotification(notification: Notification) -> Void {
      print("FinRewardWatchCatchNotification")
      HintButtonNode?.EnableLastHint()
   }
   
   @objc func ReSumeCatchNotification(notification: Notification) -> Void {
      print("ReSumeCatchNotifi")
      //PouseViewNode?.removeFromParent()
      PouseViewNode?.FadeOutAniAndRemoveFromParent()
      UnLockAllNode()
      GameSound.PlaySoundsTapButton()
   }
   
   private func ShowAdPOSTMotification() {
      NotificationCenter.default.post(name: .RewardAD, object: nil, userInfo: nil)
   }
   
  
   
   private func AdShowOrNot() {
      
      if self.HintPouseViewNode!.GetIsLocked() == false {
         self.addChild(self.HintPouseViewNode!)
         self.HintPouseViewNode!.ShowViewAnimation()
         LockAllNode()
      }else{
         print("現在Viewを消している最中です.")
      }
      
      
   }
   
   private func SetHint1() {
      let Hint = HintPuzzleBox[1] as! HintPuzzle
     
      self.addChild(Hint)
      Hint.Animation()
      self.HintButtonNode?.DissMisLile2()
   }
   
   private func SetHint2() {
      let Hint = HintPuzzleBox[0] as! HintPuzzle
      
      self.addChild(Hint)
      Hint.Animation()
      self.HintButtonNode?.DissMisLile1()
      
   }

    override func update(_ currentTime: TimeInterval) { }
}
