//
//  GameScene.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
   
   let AllStage = AllStageInfo()
   let Stage = HoldStage()
   
   var CheckedStage: [[Contents]] = Array()
   
   var Puzzle1: puzzle?
   var Puzzle2: puzzle?
   var Puzzle3: puzzle?
   var Puzzle4: puzzle?

   var PuzzleBox = Array<Any>()
   
    override func sceneDidLoad() {

      //ビューの長さを取得
      let ViewSizeX = self.scene?.frame.width
      let ViewSizeY = self.scene?.frame.height

      InitBackGroundColor()
      
      InitStageSize(SizeX: ViewSizeX, SizeY: ViewSizeY)
      SetStage()
      
      ShowTile()
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      puzzleInit()
      AddPuzzle()
      
      CrearCheckedStage()
      
      InitNotification()
    }
   
   //MARK:- チェックする配列を初期化する
   private func CrearCheckedStage() {
      CheckedStage = AllStage.Checked
   }
   
   //MARK:- 初期化
   private func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(MovedTileCatchNotification(notification:)), name: .TileMoved, object: nil)
   }
   
   //MARK: パズルを初期化する。
   //Px Py に1片の長さを入れる
   private func InitPuzzle(SizeX: CGFloat?, SizeY: CGFloat?){
      Puzzle1 = puzzle(PX: 3, PY: 2, CustNum: 0, ViewX: Int(SizeX!), ViewY: Int(SizeY!), PuzzleStyle: "32p1", PuzzleColor: "Red")
      Puzzle2 = puzzle(PX: 2, PY: 3, CustNum: 1, ViewX: Int(SizeX!), ViewY: Int(SizeY!), PuzzleStyle: "23p1", PuzzleColor: "Green")
      Puzzle3 = puzzle(PX: 2, PY: 3, CustNum: 2, ViewX: Int(SizeX!), ViewY: Int(SizeY!), PuzzleStyle: "23p2", PuzzleColor: "Blue")
      Puzzle4 = puzzle(PX: 2, PY: 3, CustNum: 3, ViewX: Int(SizeX!), ViewY: Int(SizeY!), PuzzleStyle: "23p2", PuzzleColor: "Red")
   }
   
   
   private func puzzleInit() {
      //ココの引数は特に使ってない。場所の位置変更で使ってもいいかも。
      //pAllArryの初期化をしてるね。
      //
      Puzzle1!.InitPazzle(PositionX: 2, PositionY: 3, CustomNum: 1)
      Puzzle2!.InitPazzle(PositionX: 4, PositionY: 5, CustomNum: 1)
      Puzzle3!.InitPazzle(PositionX: 2, PositionY: 10, CustomNum: 1)
      Puzzle4!.InitPazzle(PositionX: 6, PositionY: 10, CustomNum: 1)
   
      addChild(Puzzle1!)
      addChild(Puzzle1!.GetAlhpaNode())
      addChild(Puzzle2!)
      addChild(Puzzle2!.GetAlhpaNode())
      addChild(Puzzle3!)
      addChild(Puzzle3!.GetAlhpaNode())
      addChild(Puzzle4!)
      addChild(Puzzle4!.GetAlhpaNode())
   }
   
   //配列に入れて行ってる
   private func AddPuzzle() {
       PuzzleBox.append(Puzzle1!)
       PuzzleBox.append(Puzzle2!)
       PuzzleBox.append(Puzzle3!)
       PuzzleBox.append(Puzzle4!)
   }
   
   private func InitBackGroundColor() {
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 0)
   }
   
   //MARK: 背景のタイルを表示してる。
   private func ShowTile(){
      for x in 0 ... 11 {
         for y in 0 ... 8 {
            addChild(Stage.getAllTile(x: x, y: y))
         }
      }
   }

   //MARK: ステージサイズを初期化してる。クラスにしても良さそう。
   private func InitStageSize(SizeX: CGFloat?, SizeY: CGFloat?){
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
   }
   
   //MARK: ステージの配列の取得
   private func SetStage(){
      //FIXME:- ココの右辺は変数にするのがいいかも
      Stage.GStage = AllStage.EasyStage.E1
   }
   
   //MARK:- ゲーム終了。
   private func FinishGame() {
      print("game Set")
   }
   
   //MARK:- 配列の情報を出力
   private func ShowCheckStage() {
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
   
   //MARK:- ゲームの行う関数群
   private func GameCheck() -> Bool {
   
      //TODO: デバック終わったら消してOK
      ShowStage()
      ShowCheckStage()
      
      //配列が一致したらおわりね
      if Stage.GStage.elementsEqual(CheckedStage) {
         return true
      }
      
      return false
   }
   
   //MARK: 位置の判定をしてる
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
            
            //.OutなのにFillしたら，もし先客が.In入れてても塗りつぶしてしまう。
            if PArry[y - RightDownY][x - LeftUpX] == .In {
               CheckedStage[ReverseY][x] = PArry[y - RightDownY][x - LeftUpX]
            }
         }
      }
      
   }
   
   //MARk: Notificationの後に毎回来る
   private func GameDecision() {
      
      
      for Puzzle in PuzzleBox {
         let PuzzleInfo = (Puzzle as! puzzle).GetOfInfomation()
         CheckedStageFill(StageObject: PuzzleInfo)
      }
      
      if GameCheck() == true {
         FinishGame()
      }
      
      //ゲームが終わらなかったら，配列をクリアする。
      CrearCheckedStage()
      return
   }
   
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
      
      let RightUpX = StartX + (PuzzleWide - 1)
      let RightUpY = StartY
      
      let LeftDownX = StartX
      let LeftDownY = StartY - (PuzzleHight - 1)
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY - (PuzzleHight - 1)
      
      
      //FIXME:- はみ出している可能性0？
//      //はみ出てたらさようなら。
//      if CheckLeftUp(x: LeftUpX, y: LeftUpY) == false || CheckLeftDown(x: LeftDownX, y: LeftDownY) == false {
//         return false
//      }
//
//      if CheckRightUp(x: RightUpX, y: RightUpY) == false || CheckRightDown(x: RightDownX, y: RightDownY) == false {
//         return false
//      }
      
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
   
   private func OverRapped(BirthDay: Int) -> Bool {
      
      let SentPazzle: puzzle = PuzzleBox[BirthDay] as! puzzle
      let SentPuzzleInfo = SentPazzle.GetOfInfomation()
      
      //はみ出てたらそもそもアウト
      if CheckdPuzzleFillSentPazzle(StageObject: SentPuzzleInfo) == false {
         return true
      }
      
      for Puzzle in PuzzleBox {
         
         if (Puzzle as! puzzle) == SentPazzle {
            print("かぶった。番号-> \((Puzzle as! puzzle).GetBirthDayNum())")
            continue
         }
         
         let PuzzleInfo = (Puzzle as! puzzle).GetOfInfomation()
         
         //かぶってたらReturn true
         if SentCheckedStageFill(StageObject: PuzzleInfo) == true {
            return true
         }
      }
      
      // 被りなし。
      return false
      
   }
   
   //MARK:- 通知を受け取る関数郡
   @objc func MovedTileCatchNotification(notification: Notification) -> Void {
      print("--- Move notification ---")
      
      
      CrearCheckedStage()
      
      
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["BirthDay"] as! Int
         print("送信者番号: \(SentNum)")
         
         if OverRapped(BirthDay: SentNum) == true {
            (PuzzleBox[SentNum] as! puzzle).ReBackNodePosition()
            CrearCheckedStage()
            return
         }
         
         CrearCheckedStage()
         
         //ゲーム判定へ。
         GameDecision()
         
         
      }else{
         print("通知受け取ったけど、中身nilやった。")
      }
      
      return
   }
    
//    
//    func touchDown(atPoint pos : CGPoint) {
//      print("Tap Point is \(pos)")
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//  
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//    
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//      for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    override func update(_ currentTime: TimeInterval) {
//   
//    }
}
