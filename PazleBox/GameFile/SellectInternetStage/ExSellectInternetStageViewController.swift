//
//  ExSellectInternetStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension SellectInternetStageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard CanSellectStage == true else {
         print("ステージを選べません")
         return
      }
      CanSellectStage = false
      print("Cellタップされた Cell: \(indexPath.item)")
      
      var Image = UIImage()
      let StageData = SavedStageDataBase.GetImageDataFromDataNumberASNSData(DataNum: indexPath.item)
      if let data = StageData {
         Image = UIImage(data: data as Data)!
      }
      
      let flame = CGRect(x: view.frame.width / 10, y: view.frame.height / 4, width: view.frame.width / 10 * 8, height: view.frame.width / 10 * 8)
      
      let SellectedView = SellectView(frame: flame, Image: Image, CellNum: indexPath.item)
      SellectedView.center.y = view.center.y
      self.view.addSubview(SellectedView)
      
      Play3DtouchMedium()
      GameSound.PlaySoundsTapButton()
    }
}

extension SellectInternetStageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("ステージ数の合計: \(StageDatas.count)")
      return StageDatas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InternetStagesCell", for: indexPath)
        
      let ImageData = StageDatas[indexPath.item]["ImageData"] as? NSData
      
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         
         //CollectionViewのImageViewのアンラップ
         if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
            imageView.image = Image
          }else{
            fatalError("Cellの中のImageviewが存在しない")
         }
      }
      
      cell.layer.borderColor = UIColor.black.cgColor
      cell.layer.borderWidth = 1
      
      //heroつけた
      //消すんやったらInitHeroID()のCollecti onVie
      //のIDも削除したほうがいい
      cell.hero.modifiers = [.fade, .scale(0.5)]

        return cell
    }
}

extension SellectInternetStageViewController: UICollectionViewDelegateFlowLayout {
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


