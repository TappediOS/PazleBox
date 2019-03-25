//
//  GameViewController.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SAConfettiView


class GameViewController: UIViewController {
   
   var GameClearView = SAConfettiView()
   let GameClearVeiwIntensity: Float = 0.55
   var ShowGameClearView = false
   
   var StageLevel: StageLevel = .Normal
   
   var LoadStageNum = false
   
   var LoadSKView = SKView()
   var LoadGKScene = GameScene()
   
   //MARK: user defaults
   var userDefaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
      
      LoadStageLebel()
      
      InitStageSellectView()
      
      
      InitGameView()
      InitGameClearView()
      InitNotificationCenter()
      //LoadGameView()
   }
   
   
   private func LoadStageLebel() {
      
      guard LoadStageNum == true else {
         return
      }

      print("StageLevel = \(StageLevel)")
      userDefaults.set(StageLevel, forKey: "SelectedStageLevel")
      LoadStageNum = true
   }
   
   
   
   func InitGameView() {
      
      print("GameSene，GameViewの初期化開始")
      if let scene = GKScene(fileNamed: "GameScene") {
            
         // Get the SKScene from the loaded GKScene
         if let sceneNode = scene.rootNode as! GameScene? {
               
            LoadGKScene = sceneNode
            
            sceneNode.scaleMode = GetSceneScalaMode(DeviceHeight: UIScreen.main.nativeBounds.height)
            
            
            // Present the scene
            if let view = self.view as! SKView? {
               LoadSKView = view
               
                  
               sceneNode.userData = NSMutableDictionary()
               sceneNode.userData?.setValue(StageLevel, forKey: "StageNum")

               view.ignoresSiblingOrder = true
               
               view.showsDrawCount = true
               view.showsQuadCount = true
                  
               view.showsFPS = true
               view.showsNodeCount = true
            }
         }
      }
      print("GameSene，GameViewの初期化完了")
   }
   
   private func GetSceneScalaMode(DeviceHeight: CGFloat) -> SKSceneScaleMode {
      
      if UIDevice.current.userInterfaceIdiom == .pad {
         return .fill
      }
      
      switch DeviceHeight {
      case 2436.0:
         return .fill
      case 1792.0:
         return .fill
      case 2688.0:
         return .fill
      default:
         return .aspectFill
      }
   }
   
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(GameClearCatchNotification(notification:)), name: .GameClear, object: nil)
   }
   
   private func InitGameClearView() {
      let Rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      GameClearView = SAConfettiView(frame: Rect)
      GameClearView.intensity = GameClearVeiwIntensity
      GameClearView.type! = .star
      GameClearView.startConfetti()
      
   }
   
   private func StartConfetti(){
      self.view?.addSubview(GameClearView)
      GameClearView.startConfetti()
      ShowGameClearView = true
   }
   
   @objc func GameClearCatchNotification(notification: Notification) -> Void {
      
      guard ShowGameClearView == false else {
         return
      }
      
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
         self.StartConfetti()
      }
      return
   }
   
   func LoadGameView() {
      // Present the scene
      LoadSKView.presentScene(LoadGKScene)
      
   }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
