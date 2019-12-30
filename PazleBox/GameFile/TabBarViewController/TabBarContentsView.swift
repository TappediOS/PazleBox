//
//  TabBarContentsView.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarBasicContentView: ESTabBarItemContentView {
   public var duration = 0.3
    
   override init(frame: CGRect) {
      super.init(frame: frame)
      textColor = UIColor.init(white: 50.0 / 255.0, alpha: 1.0)
      highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
      iconColor = UIColor.init(white: 50.0 / 255.0, alpha: 1.0)
      highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
   }
    
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
    
   override func selectAnimation(animated: Bool, completion: (() -> ())?) {
      self.bounceAnimation()
      completion?()
   }
    
   func bounceAnimation() {
      let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
      impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
      impliesAnimation.duration = duration * 2
      impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
      imageView.layer.add(impliesAnimation, forKey: nil)
   }
}
