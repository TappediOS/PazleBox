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
      let cell = PiceCollectionView.dequeueReusableCell(withReuseIdentifier: "PiceShopPiceCell", for: indexPath) as! PiceShopCollectionViewCell
      

        
      let imageName = self.UsingPiceSet[indexPath.item]
      let PiceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: imageName, ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)

      
      cell.PiceShopPiceImageView.image = PiceImage
   
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
      
      let piceName = UsingPiceSet[indexPath.row].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")
      
      var hightPerItem = widthPerItem
      
      switch piceName {
      case "22", "33":
         hightPerItem *= 1
      case "23":
         hightPerItem *= 1.12
      case "32":
         hightPerItem *= 0.8
      case "43":
         hightPerItem *= 0.9
      case "42":
         hightPerItem *= 2 / 4
      default:
         print("これ忘れているよ")
      }
      
      
      return CGSize(width: widthPerItem, height: hightPerItem)
   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
   }

   // セルの行間の設定
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 15.0
   }
}
