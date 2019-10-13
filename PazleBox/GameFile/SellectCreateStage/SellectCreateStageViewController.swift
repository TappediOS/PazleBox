//
//  SellectCreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import RealmSwift

class SellectCreateStageViewController: UIViewController {
   
   let SavedStageDataBase = UserCreateStageDataBase()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   @IBOutlet weak var StageCollectionView: UICollectionView!
   private let sectionInsets = UIEdgeInsets(top: 10.0, left: 6.0, bottom: 5.0, right: 6.0)
   private let itemsPerRow: CGFloat = 3
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
      
      self.StageCollectionView.delegate = self
      self.StageCollectionView.dataSource = self

   }
   
   
   private func LoadStageInfomation(CellNum: Int) {
      let PiceList = SavedStageDataBase.GetPiceFromDataNumberASList(DataNum: CellNum)
      let FieldYList = SavedStageDataBase.GetFieldYFromDataNumberASList(DataNum: CellNum)
      //EXファイルに存在している
      PiceArray = GetPiceArrayFromPiceList(PiceList: PiceList)
      StageArray = GetPiceArrayFromPiceList(FieldYList: FieldYList)
   }
   
   private func PresentGameViewController() {
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      vc2.LoadPiceArray(PiceArray: PiceArray)
      vc2.LoadStageArray(StageArray: StageArray)
         
      //これを追加して重ならないようにするiOS13以降に自動適用される。
      vc2.modalPresentationStyle = .fullScreen
      self.present(vc2, animated: true, completion: {
         print("プレゼント終わった")
      })
   }
}


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
