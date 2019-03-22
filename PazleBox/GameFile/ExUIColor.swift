//
//  ExUIColor.swift
//  PazleBox
//
//  Created by jun on 2019/03/21.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension puzzle {
   
   func GetRandColor() -> UIColor {
      let r: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
      let g: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
      let b: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
      let color: UIColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
      
      return color
   }
}


extension UIImage {
   // resize image
   func reSizeImage(reSize:CGSize)->UIImage {
      //UIGraphicsBeginImageContext(reSize);
      UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
      self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
      let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      return reSizeImage;
   }
   
   // scale the image at rates
   func scaleImage(scaleSize:CGFloat)->UIImage {
      let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
      return reSizeImage(reSize: reSize)
   }
}
