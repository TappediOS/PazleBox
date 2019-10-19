//
//  ExCreateStageVC.swift
//  PazleBox
//
//  Created by jun on 2019/10/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension CleateStageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("データベースのデータ数は,\(photos.count)")
      return photos.count
   }
   
   //cellをそれぞれ返す
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
      
      for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
      }
      
      print("セルの生成します \(indexPath.item)")
      
      let ImageView = UIImageView()
      ImageView.frame = cell.contentView.frame
      ImageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: photos[indexPath.item], ofType: "png")!)?.ResizeUIImage(width: 64, height: 64)
      
      cell.contentView.addSubview(ImageView)
      
      return cell
   }
   
   func RemoveAllFromWorkArry() {
      guard WorkPlacePiceImageArray.count != 0 else { return }
      
      //Viewからけして
      for Pice in WorkPlacePiceImageArray {
         Pice.removeFromSuperview()
      }
      //配列きれいにして
      WorkPlacePiceImageArray.removeAll()
      //OnViewもけしす
      NotShowOnPiceView()
   }
   
   // Cell が選択された場合
   // ここで値を渡して画面遷移を行なっている。
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("Cell tap \(indexPath.item)")
      
      ///もしCellタップしたときにOnViewがあったら全部消す。
      RemoveAllFromWorkArry()
      
      TappedCell(CellNum: indexPath.item)
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 5
   }
}

