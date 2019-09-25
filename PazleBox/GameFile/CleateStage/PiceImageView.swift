//
//  PiceImageView.swift
//  PazleBox
//
//  Created by jun on 2019/09/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class PiceImageView : UIImageView {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.isUserInteractionEnabled = true
   }
   
   
   public func SetImage(name: String) {
      self.image = UIImage(named: name)?.ResizeUIImage(width: 64, height: 64)
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       let touchEvent = touches.first!
       
       // ドラッグ前の座標, Swift 1.2 から
      let preDx = touchEvent.previousLocation(in: self).x
       let preDy = touchEvent.previousLocation(in: self).y
       
       // ドラッグ後の座標
       let newDx = touchEvent.location(in: self).x
       let newDy = touchEvent.location(in: self).y
       
      let dx = newDx - preDx
      let dy = newDy - preDy

      self.center.x += dx
      self.center.y += dy
      
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
