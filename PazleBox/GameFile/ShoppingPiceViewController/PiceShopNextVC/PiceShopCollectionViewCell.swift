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
   
   override func awakeFromNib() {
      super.awakeFromNib()
      SetUpPiceShopPiceImageView()
   }
   
   private func SetUpPiceShopPiceImageView() {
      //self.layer.borderWidth = 0.5
      //self.layer.borderColor = UIColor.systemBackground.cgColor
      //self.layer.cornerRadius = 8
      //self.backgroundColor = .secondarySystemBackground
   }
   
   public func setPiceShopPiceImageView(image: UIImage) {
      self.PiceShopPiceImageView.image = image
      self.PiceShopPiceImageView.contentMode = .scaleAspectFill
   }
}
