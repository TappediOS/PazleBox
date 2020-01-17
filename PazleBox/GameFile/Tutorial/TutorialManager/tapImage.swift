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
      
      UIView.animate(withDuration: 2,
                     delay: 0.0,
                     options: [.autoreverse],
                     animations: {
                        self.transform.scaledBy(x: 1.5, y: 1.5)
                        self.alpha = 0
                        print("アニメーション1")
                     },
                     completion: {_ in
                           //self.transform.scaledBy(x: 0.5, y: 0.5)
                           //self.alpha = 1
                           print("アニメーション2")
                     })

   }
}
