//
//  PiceShopEachViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/12.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Hero
import SwiftyStoreKit
import Firebase
import TapticEngine

class PiceShopEachViewController: UIViewController {
   
   
   @IBOutlet weak var PurchaseInfoLabel: UILabel!
   @IBOutlet weak var PiceCollectionView: UICollectionView!
   //こいつがCollecti on viewのレイアウトを決めている
   //上下左右にどれだけの感覚を開けるかを決める。
   let sectionInsets = UIEdgeInsets(top: 5, left: 20, bottom: 18, right: 20)
   //Cellを横に何個入れるか
   let itemsPerRow: CGFloat = 3
   //セル同士の間隔をどれくらいにするか
   let cellPerInset: CGFloat = 12
   var cellWide:CGFloat = 0
   
   var PiceShopTag = 0
   
   let PICE_SET_1_ID = "Pice_Set_Part1"
   let PICE_SET_2_ID = "Pice_Set_Part2"
   let PICE_SET_3_ID = "Pice_Set_Part3"
   let PICE_SET_4_ID = "Pice_Set_Part4"
   let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   var Using_PICE_SET_ID = ""
   
   var LockPurchasButton = false
   
   @IBOutlet weak var PerchaseButton: UIButton!
   @IBOutlet weak var RestoreButton: UIButton!
   
   
   @IBOutlet weak var PriceLabel: UILabel!
   
   let PiceSet1 = ["33p7Red", "33p7Green", "33p7Blue",
                   "43p10Red", "43p10Green", "43p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   "23p12Red", "23p12Green", "23p12Blue",
                   "43p26Red", "43p26Green", "43p26Blue",
                   "33p25Red","33p25Green","33p25Blue"
                  ]
   
   let PiceSet2 = ["32p3Red", "32p3Green", "32p3Blue",
                   "43p14Red", "43p14Green", "43p14Blue",
                   "43p14Red", "43p14Green", "43p14Blue",
                   "32p12Red", "32p12Green", "32p12Blue",
                   "43p24Red", "43p24Green", "43p24Blue",
                   "33p21Red","33p21Green","33p21Blue"
   ]
   
   let PiceSet3 = ["33p7Red", "33p7Green", "33p7Blue",
                   "43p10Red", "43p1Green", "43p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   "23p12Red", "23p12Green", "23p12Blue",
                   "43p26Red", "43p26Green", "43p26Blue",
                   "33p25Red","33p25Green","33p25Blue"
   ]
   
   let PiceSet4 = ["33p6Red", "33p6Green", "33p6Blue",
                   "43p4Red", "43p4Green", "43p4Blue",
                   "33p15Red", "33p15Green", "33p15Blue",
                   "23p13Red", "23p13Green", "23p13Blue",
                   "33p26Red", "33p26Green", "33p26Blue",
                   "33p22Red","33p22Green","33p22Blue"
   ]
   
   var UsingPiceSet: [String] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      print("表示するタグ番号: \(PiceShopTag)\n")
      SetUpNavigationBar()
      SetUpUsingPiceSet()
      SetUpPriceLabel()
      SetUpPurchaseInfoLabel()
      SetUpPerchaseButton()
      SetUpRestoreButton()
      LoadCollectionView()
      CheckIAPInfomation()
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("Pice Set \(self.PiceShopTag)", comment: "")
   }
   
   private func SetUpPriceLabel() {
      PriceLabel.text = ""
      PriceLabel.adjustsFontSizeToFitWidth = true
   }
   
   private func SetUpUsingPiceSet() {
      self.UsingPiceSet.removeAll()
      switch self.PiceShopTag {
      case 1:
         self.UsingPiceSet = self.PiceSet1
         self.Using_PICE_SET_ID = self.PICE_SET_1_ID
      case 2:
         self.UsingPiceSet = self.PiceSet2
         self.Using_PICE_SET_ID = self.PICE_SET_2_ID
      case 3:
         self.UsingPiceSet = self.PiceSet3
         self.Using_PICE_SET_ID = self.PICE_SET_3_ID
      case 4:
         self.UsingPiceSet = self.PiceSet4
         self.Using_PICE_SET_ID = self.PICE_SET_4_ID
      default:
         fatalError("訳のわからん数字が入ってる")
      }
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpPurchaseInfoLabel() {
      let title = NSLocalizedString("以下のピースセットをステージ作りで使えるようになります", comment: "")
      PurchaseInfoLabel.text = title
      PurchaseInfoLabel.adjustsFontSizeToFitWidth = true
      PurchaseInfoLabel.adjustsFontForContentSizeCategory = true
      PurchaseInfoLabel.minimumScaleFactor = 0.45
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpPerchaseButton() {
      let title = NSLocalizedString("Perchase", comment: "")
      PerchaseButton.setTitle(title, for: .normal)
      PerchaseButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PerchaseButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PerchaseButton.layer.cornerRadius =  5
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpRestoreButton() {
      let title = NSLocalizedString("Restore", comment: "")
      RestoreButton.setTitle(title, for: .normal)
      RestoreButton.titleLabel?.adjustsFontSizeToFitWidth = true
      RestoreButton.titleLabel?.adjustsFontForContentSizeCategory = true
      RestoreButton.layer.cornerRadius =  5
   }
   
   //TODO:- ローカライズしてなぁ
   private func LoadCollectionView() {
      PiceCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PiceShopCollectionViewCell")
      PiceCollectionView.delegate = self
      PiceCollectionView.dataSource = self
      let margin = sectionInsets.right + sectionInsets.left + cellPerInset * (itemsPerRow - 1)
      cellWide = (view.frame.width - margin) / itemsPerRow
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: cellWide, height: cellWide)
      PiceCollectionView.collectionViewLayout = layout
   }
   
   public func getPiceShopTag(tag: Int) {
      self.PiceShopTag = tag
   }
   
   
   @IBAction func TapParchasePiceSetButton(_ sender: Any) {
      //すでに押されてたら帰る
      if LockPurchasButton == true { return }
      print("購入ボタンが押されました")
      LockPurchasButton = true
      Analytics.logEvent("TapParchasPiceSet\(PiceShopTag)", parameters: nil)
      purchase(PRODUCT_ID: Using_PICE_SET_ID)
   }
   
   @IBAction func TapRestoreButton(_ sender: Any) {
      print("リストアボタンが押されました")
      SwiftyStoreKit.restorePurchases(atomically: true) { results in
         if results.restoreFailedPurchases.count > 0 {
            print("リストアに失敗 \(results.restoreFailedPurchases)")
         }
         else if results.restoredPurchases.count > 0 {
            print("リストアに成功。ユーザは何かしら課金をしている.")
            //購入成功
            for result in results.restoredPurchases {
               let proID = result.productId
               print("購入している課金アイテムのID = \(proID)")
               if proID == self.Using_PICE_SET_ID {
                  print("課金しているアイテムとリストアしたいアイテムが一致しました")
                  print("課金しているアイテムID　 = \(proID)")
                  print("リストアしたいアイテムID = \(self.Using_PICE_SET_ID)")
                  let defaults = UserDefaults.standard
                  let DafaultsKey = "BuyPiceSet" + String(self.PiceShopTag)
                  defaults.set(true, forKey: DafaultsKey)
                  print("リストアに成功しました \(results.restoredPurchases)")
                  print("\(DafaultsKey)　の購入フラグを　\(defaults.bool(forKey: DafaultsKey))　に変更しました")
                  self.CompleateRestore()
               } else {
                  print("何かの課金をしているけど\(proID)は課金していません")
                  print("もしくはこのタイミングではリストアしません\n")
                  self.Play3DtouchError()
               }
            }
            
         }
         else {
            print("リストアするものがない")
            print("Restorボタン押したけどなんも買ってないパターン")
            self.Play3DtouchError()
         }
      }
   }
   
   
   private func CheckIAPInfomation() {
      SwiftyStoreKit.retrieveProductsInfo([Using_PICE_SET_ID]) { result in
         if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            print("Product: \(product.localizedDescription), price: \(priceString)")
            self.PriceLabel.text! = priceString
         }
         else if let invalidProductId = result.invalidProductIDs.first {
            print("Invalid product identifier: \(invalidProductId)")
         }
         else {
            print("Error: \(String(describing: result.error))")
         }
      }
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
