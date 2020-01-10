//
//  TabBarContentsView.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import pop

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
   
   public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
      UIView.beginAnimations("small", context: nil)
      UIView.setAnimationDuration(0.2)
      let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
      self.imageView.transform = transform
      UIView.commitAnimations()
      completion?()
   }
    
   public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
      UIView.beginAnimations("big", context: nil)
      UIView.setAnimationDuration(0.2)
      let transform = CGAffineTransform.identity
      self.imageView.transform = transform
      UIView.commitAnimations()
      completion?()
   }
    
   private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> ())?) {
      view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
        
      let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
      scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
      scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
      scale?.beginTime = CACurrentMediaTime()
      scale?.duration = 0.3
      scale?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
      scale?.removedOnCompletion = true
        
      let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
      alpha?.fromValue = 0.6
      alpha?.toValue = 0.6
      alpha?.beginTime = CACurrentMediaTime()
      alpha?.duration = 0.25
      alpha?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
      alpha?.removedOnCompletion = true
        
      view.layer.pop_add(scale, forKey: "scale")
      view.layer.pop_add(alpha, forKey: "alpha")
        
      scale?.completionBlock = ({ animation, finished in
         completion?()
      })
   }
}
