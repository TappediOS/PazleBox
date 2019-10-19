//
//  ExCreateStageVC.swift
//  PazleBox
//
//  Created by jun on 2019/10/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

extension CleateStageViewController: UICollectionViewDataSource {
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
   
 
}

extension CleateStageViewController: UICollectionViewDelegateFlowLayout {
   
   // Screenサイズに応じたセルサイズを返す
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      var PiceHeightNum: CGFloat = 0
      var PiceWideNum: CGFloat = 0
      if let PiceNumber = Int(photos[indexPath.item].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")) {
         PiceHeightNum = CGFloat(PiceNumber % 10)
         PiceWideNum = (CGFloat(PiceNumber) - PiceHeightNum) / 10
      }else{
         fatalError("正規表現でint型を取得できない")
      }
      
      let PiceSizePidding = PiceWideNum / PiceHeightNum
      
      print("Hei = \(PiceHeightNum), wid = \(PiceWideNum), Pidding = \(PiceSizePidding)")

       let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
       let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / itemsPerRow
      
       //return CGSize(width: widthPerItem, height: widthPerItem + 42)
      return CGSize(width: 50 * PiceSizePidding, height: 50)
   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
   }

   // セルの行間の設定
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 10.0
   }
}

