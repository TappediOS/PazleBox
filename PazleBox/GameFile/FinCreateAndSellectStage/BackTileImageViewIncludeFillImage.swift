//
//  BackTileImageViewIncludeFillImage.swift
//  PazleBox
//
//  Created by jun on 2019/10/05.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackTileImageViewIncludeFillImage: UIImageView {
   
   init(TilePosiY: CGFloat, TilePosiX: CGFloat, ViewX: CGFloat, ViewY: CGFloat, Content: Contents) {
      let TileWide = ViewX / 10
      let Intarnal = TileWide / 10
      
      let PosiIntarnalX = Intarnal + (Intarnal * TilePosiX)
      let PositionWideX = TileWide * TilePosiX
      let x1 = PosiIntarnalX + PositionWideX
      
      let PosiIntarnalY = Intarnal * TilePosiY
      let PositionWideY = TileWide * TilePosiY
      
      let y1 = PosiIntarnalY + PositionWideY
      
      super.init(frame: CGRect(x: x1, y: y1, width: TileWide, height: TileWide))
      
      if Content == .In {
         let BackTileImage = UIImage(contentsOfFile: Bundle.main.path(forResource: "BaseTile", ofType: "png")!)?.ResizeUIImage(width: 1, height: 1)
         self.image = BackTileImage
      }else if Content == .Out {
         let BackTileImage = UIImage(contentsOfFile: Bundle.main.path(forResource: "NullTile", ofType: "png")!)?.ResizeUIImage(width: 1, height: 1)
         self.image = BackTileImage
      }else{
         fatalError("InでもOutでもないんですけど")
      }
      
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

