//
//  ExUIImage.swift
//  PazleBox
//
//  Created by jun on 2019/07/09.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
   func resize(size _size: CGSize) -> UIImage? {
      let widthRatio = _size.width / size.width
      let heightRatio = _size.height / size.height
      let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
      
      let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
      
      UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
      draw(in: CGRect(origin: .zero, size: resizedSize))
      let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return resizedImage
   }

   // 画質を担保したままResizeするクラスメソッド.
   func ResizeUIImage(width : CGFloat, height : CGFloat)-> UIImage!{
      
      let size = CGSize(width: width, height: height)
      
      UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
      var context = UIGraphicsGetCurrentContext()
      
      self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return image
   }

}
