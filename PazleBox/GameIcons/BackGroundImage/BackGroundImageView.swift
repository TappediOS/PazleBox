//
//  File.swift
//  PazleBox
//
//  Created by jun on 2019/06/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackGroundImageViews: UIImageView {
   
   var BackGroundImage: UIImage?
   let DeviceMane = DviceChecker()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      InitBackGroundImage()
      SetUpImageForImageView()
   }

   
   private func InitBackGroundImage() {
      if UIDevice().userInterfaceIdiom == .pad {
         self.BackGroundImage = UIImage(named: "BackGroundImageForPad")
         return
      }
      
      if DeviceMane.isIphoneXsOrIphoneXsMax() {
         self.BackGroundImage = UIImage(named: "BackGroundImageForIphoneXsMaxVar2")
         return
      }
      
      self.BackGroundImage = UIImage(named: "BackGroundImageForIphone8PlusVar2")
      return
   }
   
   private func SetUpImageForImageView() {
      if let BackImage = self.BackGroundImage {
         self.image = BackImage
      }else{
         fatalError("イメージにnilが入ってました")
      }
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
