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
   
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

       // cellの枠の太さ
       //self.layer.borderWidth = 1.0
       // cellの枠の色
       //self.layer.borderColor = UIColor.black.cgColor
       // cellを丸くする
       //self.layer.cornerRadius = 8.0
   }
}
