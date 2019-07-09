//
//  BackTileImageView.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackTileImageView:UIView {
   
   
   override init(frame: CGRect) {
      let TileWide = frame.width / 10
      let Inter = TileWide / 10
      
      let ViewHeight = 12 * (TileWide + Inter)
      let ViewStartY = frame.height - ViewHeight
      
      let Frame = CGRect(x: 0, y: ViewStartY, width: frame.width, height: ViewHeight)
      super.init(frame: Frame)
      
      InitBackTileImage()
   }
   

   
   func InitBackTileImage() {
      print("タイルの表示開始")
      for y in 0 ... 11 {
         for x in 0 ... 8 {
            let ImageView = BackTileImage(TilePosiY: CGFloat(y), TilePosiX: CGFloat(x), ViewX: self.frame.width, ViewY: self.frame.height)
            self.addSubview(ImageView)
         }
      }
      print("タイルの表示完了")
   }
   
   
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
