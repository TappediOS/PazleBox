//
//  ExUIImage.swift
//  PazleBox
//
//  Created by jun on 2019/07/09.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

extension UIImage {
   func resize(size _size: CGSize) -> UIImage? {
      let widthRatio = _size.width / size.width
      let heightRatio = _size.height / size.height
      let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
      
      let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
      
      UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
      draw(in: CGRect(origin: .zero, size: resizedSize))
      let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return resizedImage
   }
}
