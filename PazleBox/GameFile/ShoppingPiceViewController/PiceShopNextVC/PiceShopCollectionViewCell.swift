//
//  PiceShopCollectionViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/03/12.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class PiceShopCollectionViewCell: UICollectionViewCell {
    
   @IBOutlet weak var PiceShopPiceImageView: UIImageView!
   

   
   public func setPiceShopPiceImageView(image: UIImage) {
      self.PiceShopPiceImageView.image = image
   }
}
