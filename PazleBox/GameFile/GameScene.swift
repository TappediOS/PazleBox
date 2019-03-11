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
   
   var Puzzle: puzzle?
   
 
   
    override func sceneDidLoad() {


      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 0)
      
      //ビューの長さを取得
      let ViewSizeX = self.scene?.frame.width
      let ViewSizeY = self.scene?.frame.height
      
      InitStageSize(SizeX: ViewSizeX, SizeY: ViewSizeY)
      SetStage()
      
      ShowTile()
      
      Puzzle = puzzle(PX: 3, PY: 2, CustNum: 1, ViewX: Int(ViewSizeX!), ViewY: Int(ViewSizeY!))
      puzzleInit()
      
    }
   
   private func puzzleInit() {
      Puzzle!.InitPazzle(PazzleX: 3, PazzleY: 2, CustomNum: 1)
      addChild(Puzzle!)
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
      Stage.GStage = AllStage.EasyStage.E1
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
