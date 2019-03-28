//
//  RePutButton.swift
//  PazleBox
//
//  Created by jun on 2019/03/28.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class RePutButton : SKSpriteNode {
   
   
   init(ViewX: Int, ViewY: Int) {
      
     
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100) * 2
      
      
     
      
      //MARK: 画像の初期化
//      let texture: SKTexture
//      texture = SKTexture(imageNamed: TextureName)
      
      //let x1 = ViewHalf + PosiIntarnal + PositionWide + TileHalfWide
      let x1 = 0
      
      
      let yposi = PazzleSizeFound * 12
      let y1 = -ViewY * 3 / 8 + yposi
      
      
      
      let NodeSize = CGSize(width: CGFloat(PazzleSizeFound), height: CGFloat(PazzleSizeFound))
      
      super.init(texture: nil, color: UIColor.black, size: NodeSize)
      
      self.position = CGPoint(x: x1, y: y1)
      
      
   }
   
   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


