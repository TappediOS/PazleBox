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
   
   let scaleFactor: CGFloat = 1.65
   let animationTime: Double = 1.5
   
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
      
      UIView.animate(withDuration: animationTime,
                     delay: 0.0,
                     options: [.autoreverse, .repeat, .curveEaseIn],
                     animations: {
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width * scaleFactor, height: self.frame.height * scaleFactor )
                        print("アニメーション1")
                     },
                     completion: {_ in
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width / scaleFactor, height: self.frame.height / scaleFactor)
                        print("アニメーション2")
                     })

   }
}
