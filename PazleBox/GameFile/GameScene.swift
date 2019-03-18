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


      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 0)
      
      //ビューの長さを取得
      let ViewSizeX = self.scene?.frame.width
      let ViewSizeY = self.scene?.frame.height
      
      InitStageSize(SizeX: ViewSizeX, SizeY: ViewSizeY)
      SetStage()
      
      ShowTile()
      
      InitPuzzle(SizeX: ViewSizeX, SizeY: ViewSizeY)
      puzzleInit()
      AddPuzzle()
      
      CrearCheckedStage()
      
      InitNotification()
    }
   
   private func CrearCheckedStage() {
      CheckedStage = AllStage.Checked
   }
   
   private func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(MovedTileCatchNotification(notification:)), name: .TileMoved, object: nil)
   }
   
   private func InitPuzzle(SizeX: CGFloat?, SizeY: CGFloat?){
      Puzzle1 = puzzle(PX: 3, PY: 2, CustNum: 1, ViewX: Int(SizeX!), ViewY: Int(SizeY!), TextureName: "P32.png")
      Puzzle2 = puzzle(PX: 2, PY: 3, CustNum: 1, ViewX: Int(SizeX!), ViewY: Int(SizeY!), TextureName: "P23.png")
      Puzzle3 = puzzle(PX: 2, PY: 3, CustNum: 1, ViewX: Int(SizeX!), ViewY: Int(SizeY!), TextureName: "P232.png")
      Puzzle4 = puzzle(PX: 2, PY: 3, CustNum: 1, ViewX: Int(SizeX!), ViewY: Int(SizeY!), TextureName: "P233.png")
   }
   
   private func puzzleInit() {
      Puzzle1!.InitPazzle(PazzleX: 3, PazzleY: 2, CustomNum: 1)
      Puzzle2!.InitPazzle(PazzleX: 2, PazzleY: 3, CustomNum: 1)
      Puzzle3!.InitPazzle(PazzleX: 2, PazzleY: 3, CustomNum: 1)
      Puzzle4!.InitPazzle(PazzleX: 2, PazzleY: 3, CustomNum: 1)
   
      addChild(Puzzle1!)
      addChild(Puzzle1!.GetAlhpaNode())
      addChild(Puzzle2!)
      addChild(Puzzle2!.GetAlhpaNode())
      addChild(Puzzle3!)
      addChild(Puzzle3!.GetAlhpaNode())
      addChild(Puzzle4!)
      addChild(Puzzle4!.GetAlhpaNode())
   }
   
   private func AddPuzzle() {
       PuzzleBox.append(Puzzle1!)
       PuzzleBox.append(Puzzle2!)
       PuzzleBox.append(Puzzle3!)
       PuzzleBox.append(Puzzle4!)
      
      
   }
   
   private func ShowTile(){
      
      for x in 0 ... 11 {
         for y in 0 ... 8 {
            addChild(Stage.getAllTile(x: x, y: y))
         }
      }
   }
   
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
   
   private func SetStage(){
      //FIXME:- ココの右辺は変数にするのがいいかも
      Stage.GStage = AllStage.EasyStage.E1
   }
   
   private func FinishGame() {
      print("game Set")
   }
   
   private func GameCheck() -> Bool {
      
      if Stage.GStage.elementsEqual(CheckedStage) {
         return true
      }
      
      return false
   }
   
   private func CheckedStageFill(StageObject: [String : Any]) {
      
   }
   
   private func GameDecision() {
      
      let Object = Puzzle1?.GetOfInfomation()
      
      for Puzzle in PuzzleBox {
         let PuzzleInfo = (Puzzle as! puzzle).GetOfInfomation()
         CheckedStageFill(StageObject: PuzzleInfo)
      }
      
      if GameCheck() == true {
         FinishGame()
      }
      
      CrearCheckedStage()
      return
      
      
   }
   
   //MARK:- 通知を受け取る関数郡
   @objc func MovedTileCatchNotification(notification: Notification) -> Void {
      print("--- Move notification ---")
      
      
      GameDecision()
      
      if let userInfo = notification.userInfo {
         let PosiX = userInfo["PX"] as! Int
         let PosiY = userInfo["PY"] as! Int
         let PArry = userInfo["PArry"] as! NSArray
         print("PosiX = \(PosiX)")
         print("PosiY = \(PosiY)")
         
         //PositionCheck()
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
