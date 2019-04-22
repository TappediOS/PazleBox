//
//  PouseTextureNode.swift
//  PazleBox
//
//  Created by jun on 2019/04/12.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import ChameleonFramework

class PouseTextNode: SKLabelNode {
   
   
   init(StartX: Int, StartY: Int) {
      super.init()
      
      self.text = "Pouse"
      
      self.fontSize = 100
      self.fontName = "Helvetica"
      self.fontColor = UIColor(contrastingBlackOrWhiteColorOn: UIColor.flatWhite(), isFlat: true)
      
      self.position = CGPoint(x: StartX, y: StartY)
      
      self.zPosition = 101
      self.isUserInteractionEnabled = false
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
