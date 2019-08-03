//
//  PieceStoreViewController.swift
//  PazleBox
//
//  Created by jun on 2019/06/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import Hero

class PiceStoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
   @IBOutlet weak var CollectionView: UICollectionView!
   
   let photos = ["33p22Blue", "33p21Blue","43p21Blue","43p2Green","21p1Red",
                 "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
                 "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
                 "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
                 "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue",
                 "33p34Blue","43p35Blue","43p36Red","43p25Blue","43p31Blue"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.CollectionView.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.CollectionView.delegate = self
      self.CollectionView.dataSource = self
      self.hero.isEnabled = true
      
      CollectionView.hero.modifiers = [.cascade]
      
      print(CollectionView.frame)
   
      
      InitLayout()
   }
   

   
   private func InitLayout() {
      let Layout = UICollectionViewFlowLayout()
      Layout.itemSize = CGSize(width: self.view.frame.width / 5, height: self.view.frame.width / 5)
      
      //横の感覚
      Layout.minimumInteritemSpacing = self.view.frame.width / 25
      //縦の感覚
      Layout.minimumLineSpacing = self.view.frame.width / 8
      //余白
      Layout.sectionInset = UIEdgeInsets(top: self.view.frame.width / 25, left: self.view.frame.width / 25, bottom: self.view.frame.width / 25, right: self.view.frame.width / 25)
      
      CollectionView.collectionViewLayout = Layout
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
      
      let cellImage = UIImage(contentsOfFile: Bundle.main.path(forResource: photos[indexPath.row], ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)
      // UIImageをUIImageViewのimageとして設定
      imageView.image = cellImage
      
      // Tag番号を使ってLabelのインスタンス生成
      let label = testCell.contentView.viewWithTag(2) as! UILabel
      label.text = photos[indexPath.row]
      
      testCell.hero.modifiers = [.fade, .scale(0.45)]
      
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
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print(indexPath.item)
      
      // Identifierが"Segue"のSegueを使って画面遷移する関数
      
   }
   
   
   // Screenサイズに応じたセルサイズを返す
   // UICollectionViewDelegateFlowLayoutの設定が必要
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      // 横方向のスペース調整
      //let horizontalSpace:CGFloat = 1
      let size = CGSize(width: self.view.frame.width / 4, height: self.view.frame.width / 4)
      // 正方形で返すためにwidth,heightを同じにする
      return size
   }
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}
