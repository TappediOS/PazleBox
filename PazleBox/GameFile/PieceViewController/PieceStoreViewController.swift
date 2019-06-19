//
//  PieceStoreViewController.swift
//  PazleBox
//
//  Created by jun on 2019/06/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class PiceStoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
   @IBOutlet weak var CollectionView: UICollectionView!
   
   let photos = ["33p22Blue", "33p21Blue","43p21Blue","43p2Blue","43p23Blue",
                 "43p34Blue","43p19Blue","43p12Blue","43p25Blue","43p14Blue"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.CollectionView.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.CollectionView.delegate = self
      self.CollectionView.dataSource = self
      
      InitLayout()
   }
   
   private func InitLayout() {
      
   }
   
   
   func collectionView(_ collectionView: UICollectionView,
                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
      
      // "Cell" はストーリーボードで設定したセルのID
      let testCell:UICollectionViewCell =
         collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                            for: indexPath)
      
      // Tag番号を使ってImageViewのインスタンス生成
      let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
      // 画像配列の番号で指定された要素の名前の画像をUIImageとする
      let cellImage = UIImage(named: photos[indexPath.row])
      // UIImageをUIImageViewのimageとして設定
      imageView.image = cellImage
      
      // Tag番号を使ってLabelのインスタンス生成
      let label = testCell.contentView.viewWithTag(2) as! UILabel
      label.text = photos[indexPath.row]
      
      return testCell
   }
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      // section数は１つ
      return 1
   }
   
   func collectionView(_ collectionView: UICollectionView,
                       numberOfItemsInSection section: Int) -> Int {
      // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
      return photos.count;
   }
   
   
   // Screenサイズに応じたセルサイズを返す
   // UICollectionViewDelegateFlowLayoutの設定が必要
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      // 横方向のスペース調整
      let horizontalSpace:CGFloat = 1
      let cellSize:CGFloat = self.view.bounds.width / 4 - horizontalSpace
      // 正方形で返すためにwidth,heightを同じにする
      return CGSize(width: cellSize, height: cellSize)
   }
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}
