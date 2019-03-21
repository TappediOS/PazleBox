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
   let GameClearVeiwIntensity: Float = 0.6

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
               
               
               switch UIScreen.main.nativeBounds.height {
               case 2436.0:
                  sceneNode.scaleMode = .fill
               case 1792.0:
                  sceneNode.scaleMode = .fill
               case 2688.0:
                  sceneNode.scaleMode = .fill
               default:
                  sceneNode.scaleMode = .aspectFill
               }
                // Set the scale mode to scale to fit the window
               if UIDevice.current.userInterfaceIdiom == .pad {
                  sceneNode.scaleMode = .fill
               }
                  
                // Present the scene
                if let view = self.view as! SKView? {

   
                    view.presentScene(sceneNode)
      
                    view.ignoresSiblingOrder = true
               
                  view.showsDrawCount = true
                  view.showsQuadCount = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
      
      InitGameClearView()
      InitNotificationCenter()
      

    }
   
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(MovedTileCatchNotification(notification:)), name: .GameClear, object: nil)
   }
   
   private func InitGameClearView() {
      let Rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      GameClearView = SAConfettiView(frame: Rect)
      GameClearView.type! = .star
      GameClearView.intensity = GameClearVeiwIntensity
      GameClearView.startConfetti()
      
   }
   
   private func StartConfetti(){
      self.view?.addSubview(GameClearView)
      GameClearView.startConfetti()
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
