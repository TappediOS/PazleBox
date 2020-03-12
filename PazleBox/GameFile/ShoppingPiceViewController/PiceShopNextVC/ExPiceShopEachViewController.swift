//
//  ExPiceShopEachViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/12.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

extension PiceShopEachViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     print("Cellタップされた Cell: \(indexPath.item)")
   }
}

extension PiceShopEachViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("ステージ数の合計: \(self.UsingPiceSet.count)")
      return self.UsingPiceSet.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
      
      for subview in cell.contentView.subviews{
         subview.removeFromSuperview()
      }
        
      let imageName = self.UsingPiceSet[indexPath.item]
      let PiceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageName, ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)
      
      let ImageView = UIImageView()
      ImageView.frame = cell.contentView.frame
      ImageView.image = PiceImage
      
      cell.contentView.addSubview(ImageView)
      

      cell.layer.borderColor = UIColor.black.cgColor
      cell.layer.borderWidth = 1
      cell.hero.modifiers = [.fade, .scale(0.5)]

      return cell
    }
}

extension PiceShopEachViewController: UICollectionViewDelegateFlowLayout {
   // Screenサイズに応じたセルサイズを返す
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
       let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / itemsPerRow
      
       return CGSize(width: widthPerItem, height: widthPerItem + 42)
   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
   }

   // セルの行間の設定
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 10.0
   }
}
