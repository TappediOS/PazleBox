//
//  tapImage.swift
//  PazleBox
//
//  Created by jun on 2020/01/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

class TapImage: UIImageView {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      let image = UIImage(named: "tap.png")
      self.image = image
      self.isUserInteractionEnabled = false
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK:- 画像を消したり出したりする。
   public func clearImageView() { self.alpha = 0 }
   public func appearImageView() { self.alpha = 1 }
   
   public func changePosition(posiX: CGFloat, posiY: CGFloat) {
      let frame = CGRect(x: posiX, y: posiY, width: self.frame.width, height: self.frame.height)
      self.frame = frame
   }
   
   public func startAnimation() {
      let animation = AnimationType.zoom(scale: 2)
      self.animate(animations: [animation], delay: 3.0, duration: 2.0, options: [.repeat, .curveEaseInOut], completion: {
         print("アニメーション")
      })
   }
}
