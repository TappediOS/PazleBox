//
//  HintTextNode.swift
//  PazleBox
//
//  Created by jun on 2019/04/29.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import ChameleonFramework

class HintTextNode: SKLabelNode {
   
   
   init(StartX: Int, StartY: Int) {
      super.init()
      
      self.text = "Watch AD and get a hint"
      
      self.fontSize = 50
      self.fontName = "HelveticaNeue-Light"
      self.fontColor = UIColor(contrastingBlackOrWhiteColorOn: UIColor.flatWhite(), isFlat: true)
      
      self.position = CGPoint(x: StartX, y: StartY)
      
      self.zPosition = 101
      self.isUserInteractionEnabled = false
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
