//
//  CreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class CleateStageViewController: UIViewController {
   
   
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   var OnPiceView = UIView()
   
   var RedFlame = CGRect()
   var GreenFlame = CGRect()
   var BlueFlame = CGRect()
   
   var MochUserSellectedImageView = UIImageView()
   
   var PiceImageArray: [PiceImageView] = Array()
   
   
   let photos = ["33p22Blue", "33p21Blue","43p21Blue","43p2Green","21p1Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue",
   "33p34Blue","43p35Blue","43p36Red","43p25Blue","43p31Blue",
   "33p22Blue", "33p21Blue","43p21Blue","43p2Green","21p1Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
      
      InitNotification()
      
      InitOnPiceView()
      InitRedFlame()
      InitGreenFlame()
      InitBlueFlame()
      
      InitMochUserSellectedImageView()
      
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
 
      collectionView.backgroundColor = UIColor.flatWhite()
      collectionView.delegate = self
      collectionView.dataSource = self
      
      collectionView.collectionViewLayout.invalidateLayout()
   }
   
   private func InitBackTileImageView() {
      let BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView)
   }
   
   private func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(PiceUpPiceImageView(notification:)), name: .PickUpPiceImageView, object: nil)
   }
   
   private func InitOnPiceView() {
      let Flame = CGRect(x: view.frame.width / 20, y: 150, width: view.frame.width / 25 * 23, height: 85)
      OnPiceView = UIView(frame: Flame)
      OnPiceView.backgroundColor = UIColor.flatWhite()
      OnPiceView.isHidden = true
      view.addSubview(OnPiceView)
   }

   private func InitRedFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 * 9 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      RedFlame = Flame
   }
   private func InitGreenFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      GreenFlame = Flame
   }
   private func InitBlueFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 * 17 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      BlueFlame = Flame
   }

   private func InitMochUserSellectedImageView() {
      
   }
   
   @objc func PiceUpPiceImageView(notification: Notification) -> Void {
      if let userInfo = notification.userInfo {
         let PiceName = userInfo["PiceName"] as! String
         print("選択されたPiceName = \(PiceName)")
      }else{ print("Nil きたよ") }
   }
   
   func TappedCell(CellNum: Int) {
      let PiceName: String = photos[CellNum].pregReplace(pattern: "(Green|Blue|Red)", with: "")
      print("TapName = \(PiceName)")
      
      let GreenPiceImageView = PiceImageView(frame: GreenFlame, name: PiceName + "Green", WindowFlame: view.frame)
      let RedPiceImageView = PiceImageView(frame: RedFlame, name: PiceName + "Red", WindowFlame: view.frame)
      let BluePiceImageView = PiceImageView(frame: BlueFlame, name: PiceName + "Blue", WindowFlame: view.frame)
      
      GreenPiceImageView.SetUPAlphaImageView()
      RedPiceImageView.SetUPAlphaImageView()
      BluePiceImageView.SetUPAlphaImageView()
      
      view.addSubview(GreenPiceImageView)
      view.addSubview(RedPiceImageView)
      view.addSubview(BluePiceImageView)
      
      PiceImageArray.append(GreenPiceImageView)
      PiceImageArray.append(RedPiceImageView)
      PiceImageArray.append(BluePiceImageView)
      
      
      OnPiceView.isHidden = false

   }
}

extension CleateStageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   //cellの個数設定
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
      ImageView.image = UIImage(named: photos[indexPath.item])?.ResizeUIImage(width: 64, height: 64)
      
      cell.contentView.addSubview(ImageView)
      
      return cell
   }
   
   // Cell が選択された場合
   // ここで値を渡して画面遷移を行なっている。
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("Cell tap \(indexPath.item)")
      
      TappedCell(CellNum: indexPath.item)
//      if let TappedCell = collectionView.cellForItem(at: indexPath) {
//         TappedCell.content
//      }
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 5
   }
}
