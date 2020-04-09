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
     //print("Cellタップされた Cell: \(indexPath.item)")
   }
}

extension PiceShopEachViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("購入するピースの合計数: \(self.UsingPiceSet.count)\n")
      return self.UsingPiceSet.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //print("\(indexPath.item)番目のCellを返す")
      let cell = PiceCollectionView.dequeueReusableCell(withReuseIdentifier: "PiceShopPiceCell", for: indexPath) as! PiceShopCollectionViewCell

      let PiceImageName: String = self.UsingPiceSet[indexPath.item]
      
      //もしキャッシュされていたらその画像をセットする.とても速い!
      if let cachedImage = CollectionViewImageCache.object(forKey: PiceImageName as AnyObject) as? UIImage {
         cell.setPiceShopPiceImageView(image: cachedImage)
         return cell
      }
      
      //Noキャッシュならば，画像データを生成する//ResizeUIImage()はとても遅い。
      let PiceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: PiceImageName, ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)
            
      self.CollectionViewImageCache.setObject(PiceImage!, forKey: PiceImageName as AnyObject)
      cell.setPiceShopPiceImageView(image: PiceImage!)

      //cell.hero.modifiers = [.fade, .scale(0.5)]
      return cell
    }
}

extension PiceShopEachViewController: UICollectionViewDelegateFlowLayout {
   // Screenサイズに応じたセルサイズを返す
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //let paddingSpace = sectionInsets.right + sectionInsets.left + cellPerInset * (itemsPerRow - 1)
      //let availableWidth = view.frame.width - paddingSpace
      //let widthPerItem = availableWidth / itemsPerRow
      var hightPerItem = cellWide
      let piceName = UsingPiceSet[indexPath.row].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")
      
      //print(widthPerItem)
      //print("\(cellWide)\n")
      
      switch piceName {
      case "22", "33":
         hightPerItem *= 1
      case "23":
         hightPerItem *= 1.2
      case "32":
         hightPerItem *= 0.85
      case "43":
         hightPerItem *= 0.75
      case "42":
         hightPerItem *= 2 / 4
      default:
         print("Cellの大きさを決定するときのSwitch文で，")
         print("\(piceName)の追加忘れているよ")
      }
      
      let cellSize = CGSize(width: self.cellWide, height: hightPerItem)      
      return cellSize
   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
   }

   // セルの行間(n行目とn+1行目)の設定
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 18.0
   }


   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return self.cellPerInset - 2.5
   }
}
