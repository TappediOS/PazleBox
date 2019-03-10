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
import Crashlytics

class GameViewController: UIViewController {

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

                  view.backgroundColor = UIColor.white.withAlphaComponent(1)
                  self.view.backgroundColor = UIColor.white.withAlphaComponent(1)
                  
            
                  
                  
                  
                  
                  
                  print("背景色：\(String(describing: view.backgroundColor))")
                  print("背景色：\(String(describing: self.view.backgroundColor))")
                  
                    view.presentScene(sceneNode)
                  
                  print(self.view.frame.width)
                  print(self.view.frame.height)
                  
                  print(view.frame)
                  print(sceneNode.frame)
                    
                    view.ignoresSiblingOrder = true
               
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
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
