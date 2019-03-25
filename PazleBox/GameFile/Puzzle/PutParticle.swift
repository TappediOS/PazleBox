//
//  PutParticle.swift
//  PazleBox
//
//  Created by jun on 2019/03/21.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SpriteKit

class PutParticle {
   
   var particle = SKEmitterNode()

   
   init(PX: Int, PY: Int, CustNum: Int, ViewX: Int, ViewY: Int) {
      
      let PazzleSizeFound = ViewX / 10 + (ViewX / 100)
      
      let CenterX = PazzleSizeFound * PX / 2 - PazzleSizeFound / 2
      let CenterY = -( PazzleSizeFound * PY / 2 ) + PazzleSizeFound / 2
      
      
//      let LeftUpX = -PazzleSizeFound / 2
//      let LeftUpY = PazzleSizeFound / 2
//
//      let RangeX = PazzleSizeFound * PX
//      let RangeY = -( PazzleSizeFound * PY )
      
      particle = SKEmitterNode(fileNamed: "PutPuzzleParticle")!
      
      particle.position = CGPoint(x: CenterX, y: CenterY)
      //particle.particlePositionRange = CGVector(dx: RangeX, dy: RangeY)
      

   }
   
   public func GetParticle() -> SKEmitterNode {
      return self.particle
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
