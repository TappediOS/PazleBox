//
//  BackTileImage.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackTileImage: UIImageView {
   
   init(TilePosiY: CGFloat, TilePosiX: CGFloat, ViewX: CGFloat, ViewY: CGFloat) {
      let TileWide = ViewX / 10
      let Intarnal = TileWide / 10
      
      let PosiIntarnalX = Intarnal + (Intarnal * TilePosiX)
      let PositionWideX = TileWide * TilePosiX
      let x1 = PosiIntarnalX + PositionWideX
      
      let PosiIntarnalY = Intarnal * TilePosiY
      let PositionWideY = TileWide * (TilePosiY - 1)
      
      let y1 = PosiIntarnalY + PositionWideY
      
      super.init(frame: CGRect(x: x1, y: y1, width: TileWide, height: TileWide))
      
      //let BackTileImage = UIImage(named: "NullTile.png")
      let BackTileImage = UIImage(contentsOfFile: Bundle.main.path(forResource: "NullTile", ofType: "png")!)
      self.image = BackTileImage
      self.backgroundColor = UIColor.black
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
