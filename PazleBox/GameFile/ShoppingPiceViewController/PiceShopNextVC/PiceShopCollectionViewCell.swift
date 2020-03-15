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
      SetUpCell()
      SetUpPiceShopPiceImageView()
   }
   
   private func SetUpCell() {
      self.layer.borderWidth = 0.7
      self.layer.borderColor = UIColor.black.cgColor
      self.layer.cornerRadius = 10
      self.backgroundColor = .secondarySystemBackground
   }
   
   private func SetUpPiceShopPiceImageView() {
      self.PiceShopPiceImageView.layer.borderWidth = 0.42
      self.PiceShopPiceImageView.layer.borderColor = UIColor.black.cgColor
      self.PiceShopPiceImageView.layer.cornerRadius = 4.5
   }
   
   public func setPiceShopPiceImageView(image: UIImage) {
      self.PiceShopPiceImageView.image = image
      self.PiceShopPiceImageView.contentMode = .scaleAspectFill
   }
}
