//
//  ExSellectStageVCCollection.swift
//  PazleBox
//
//  Created by jun on 2019/10/13.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension SellectCreateStageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("Cellタップされた Cell: \(indexPath.item)")
      LoadStageInfomation(CellNum: indexPath.item)
      PresentGameViewController()
    }
}

extension SellectCreateStageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("ステージ数の合計: \(SavedStageDataBase.GetMAXDataNumOfDataBaseDataCount())")
      return SavedStageDataBase.GetMAXDataNumOfDataBaseDataCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStagesCell", for: indexPath)
        
      let ImageData = SavedStageDataBase.GetImageDataFromDataNumberASNSData(DataNum: indexPath.item)
      
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
      
         if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
            imageView.image = Image
            
          }else{
            fatalError("Cellの中のImageviewが存在しない")
         }
      }
      
      cell.layer.borderColor = UIColor.black.cgColor
      cell.layer.borderWidth = 1

        return cell
    }
}

extension SellectCreateStageViewController: UICollectionViewDelegateFlowLayout {
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

