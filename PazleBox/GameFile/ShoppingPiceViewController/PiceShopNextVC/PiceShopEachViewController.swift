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
   
   //CollectionViewの画像のキャッシュ
   //UIImage.Resize()に数秒かかっててカクツクから，最初の表示の後にキャッシュして
   //スクロールして再生成する時にキャッシュを使用してUIImage.Resize()を呼ばないようにする
   //アプリを再起動するとキャッシュはクリアされるらしい
   let CollectionViewImageCache = NSCache<AnyObject, AnyObject>()
   
   
   
   let PiceSet1 = ["23p1Red", "23p1Green", "23p1Blue",
                   "23p4Red", "23p4Green", "23p4Blue",
                   "23p6Red", "23p6Green", "23p6Blue",
                   "23p8Red", "23p8Green", "23p8Blue",
                   "23p9Red", "23p9Green", "23p9Blue",
                   "23p10Red", "23p10Green", "23p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   
                   "32p3Red", "32p3Green", "32p3Blue",
                   "32p4Red", "32p4Green", "32p4Blue",
                   "32p6Red", "32p6Green", "32p6Blue",
                   "32p8Red", "32p8Green", "32p8Blue",
                   "32p9Red", "32p9Green", "32p9Blue",
                   "32p10Red", "32p10Green", "32p10Blue",
                   "32p14Red", "32p14Green", "32p14Blue",
                   
                   "33p5Red", "33p5Green", "33p5Blue",
                   "33p16Red", "33p16Green", "33p16Blue",
                   "33p23Red", "33p23Green", "33p23Blue",
                   
                   "43p1Red", "43p1Green", "43p1Blue",
                   "43p2Red", "43p2Green", "43p2Blue",
                   "43p6Red", "43p6Green", "43p6Blue",
                  ]
   
   let PiceSet2 = ["33p8Red", "33p8Green", "33p8Blue",
                   "33p9Red", "33p9Green", "33p9Blue",
                   "33p10Red", "33p10Green", "33p10Blue",
                   "33p11Red", "33p11Green", "33p11Blue",
                   "33p13Red", "33p13Green", "33p13Blue",
                   "33p15Red", "33p15Green", "33p15Blue",
                   "33p17Red", "33p17Green", "33p17Blue",
                   "33p19Red", "33p19Green", "33p19Blue",
                   "33p20Red", "33p20Green", "33p20Blue",
                   "33p22Red", "33p22Green", "33p22Blue",
                   "33p25Red", "33p25Green", "33p25Blue",
                   "33p26Red", "33p26Green", "33p26Blue",
                   "33p27Red", "33p27Green", "33p27Blue",
                   "33p43Red", "33p43Green", "33p43Blue",
                   "33p44Red", "33p44Green", "33p44Blue",
                   
                   "43p3Red", "43p3Green", "43p3Blue",
                   "43p4Red", "43p4Green", "43p4Blue",
                   "43p5Red", "43p5Green", "43p5Blue",
                   "43p7Red", "43p7Green", "43p7Blue",
                   "43p8Red", "43p8Green", "43p8Blue",
                  ]
   
   let PiceSet3 = ["33p7Red", "33p7Green", "33p7Blue",
                   "33p29Red", "33p29Green", "33p29Blue",
                   "33p30Red", "33p30Green", "33p30Blue",
                   "33p31Red", "33p31Green", "33p31Blue",
                   "33p32Red", "33p32Green", "33p32Blue",
                   "33p33Red", "33p33Green", "33p33Blue",
                   "33p34Red", "33p34Green", "33p34Blue",
                   "33p35Red", "33p35Green", "33p35Blue",
                   "33p36Red", "33p36Green", "33p36Blue",
                   "33p38Red", "33p38Green", "33p38Blue",
                   
                   "43p10Red", "43p10Green", "43p10Blue",
                   "43p11Red", "43p11Green", "43p11Blue",
                   "43p12Red", "43p12Green", "43p12Blue",
                   "43p13Red", "43p13Green", "43p13Blue",
                   "43p14Red", "43p14Green", "43p14Blue",
                   "43p15Red", "43p15Green", "43p15Blue",
                   "43p16Red", "43p16Green", "43p16Blue",
                   "43p17Red", "43p17Green", "43p17Blue",
                   "43p18Red", "43p18Green", "43p18Blue",
                   "43p19Red", "43p19Green", "43p19Blue",
                   "43p20Red", "43p20Green", "43p20Blue",
                   "43p21Red", "43p21Green", "43p21Blue",
                   "43p22Red", "43p22Green", "43p22Blue",
                   "43p23Red", "43p23Green", "43p23Blue",
                   "43p24Red", "43p24Green", "43p24Blue",
                  ]
   
   let PiceSet4 = ["33p18Red", "33p18Green", "33p18Blue",
                   "33p39Red", "33p39Green", "33p39Blue",
                   "33p40Red", "33p40Green", "33p40Blue",
                   "33p41Red", "33p41Green", "33p41Blue",
                   "33p42Red", "33p42Green", "33p42Blue",
                   
                   "43p25Red", "43p25Green", "43p25Blue",
                   "43p27Red", "43p27Green", "43p27Blue",
                   "43p28Red", "43p28Green", "43p28Blue",
                   "43p29Red", "43p29Green", "43p29Blue",
                   "43p30Red", "43p30Green", "43p30Blue",
                   "43p31Red", "43p31Green", "43p31Blue",
                   "43p32Red", "43p32Green", "43p32Blue",
                   "43p33Red", "43p33Green", "43p33Blue",
                   "43p34Red", "43p34Green", "43p34Blue",
                   "43p35Red", "43p35Green", "43p35Blue",
                   "43p36Red", "43p36Green", "43p36Blue",
                   "43p37Red", "43p37Green", "43p37Blue",
                   "43p38Red", "43p38Green", "43p38Blue",
                   "43p39Red", "43p39Green", "43p39Blue",
                   "43p40Red", "43p40Green", "43p40Blue",
                   "43p41Red", "43p41Green", "43p41Blue",
                   "43p42Red", "43p42Green", "43p42Blue",
                   "43p43Red", "43p43Green", "43p43Blue",
                   "43p44Red", "43p44Green", "43p44Blue",
                   "43p45Red", "43p45Green", "43p45Blue",
                   "43p46Red", "43p46Green", "43p46Blue",
                   "43p47Red", "43p47Green", "43p47Blue",
                   "43p48Red", "43p48Green", "43p48Blue",
                   "43p49Red", "43p49Green", "43p49Blue",
                   "43p50Red", "43p50Green", "43p50Blue",
                  ]
   
   var UsingPiceSet: [String] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      print("表示するタグ番号: \(PiceShopTag)\n")
      RemoveAllImageCache()
      SetUpNavigationBar()
      SetUpUsingPiceSet()
      SetUpPiceImageCache()
      SetUpPriceLabel()
      SetUpPurchaseInfoLabel()
      SetUpPerchaseButton()
      SetUpRestoreButton()
      LoadCollectionView()
      CheckIAPInfomation()
   }
   
   private func RemoveAllImageCache() {
      CollectionViewImageCache.removeAllObjects()
   }
   
   private func SetUpNavigationBar() {
      let PiceSet = NSLocalizedString("PiceSet", comment: "") + " " + String(self.PiceShopTag)
      self.navigationItem.title = NSLocalizedString(PiceSet, comment: "")
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
   
   private func SetUpPiceImageCache() {
      DispatchQueue.global(qos: .userInteractive).async {
         for PiceName in self.UsingPiceSet {
            if self.CollectionViewImageCache.object(forKey: PiceName as AnyObject) != nil { continue } //既にキャッシュされてたらコンティニュー
            let PiceImage = UIImage(contentsOfFile: Bundle.main.path(forResource: PiceName, ofType: "png")!)?.ResizeUIImage(width: 128, height: 128)
            self.CollectionViewImageCache.setObject(PiceImage!, forKey: PiceName as AnyObject)
         }
      }
      
   }
   
   private func SetUpPurchaseInfoLabel() {
      let title = NSLocalizedString("IfYouBuyPice", comment: "")
      PurchaseInfoLabel.text = title
      PurchaseInfoLabel.adjustsFontSizeToFitWidth = true
      PurchaseInfoLabel.adjustsFontForContentSizeCategory = true
      PurchaseInfoLabel.minimumScaleFactor = 0.45
   }
   
   private func SetUpPerchaseButton() {
      let title = NSLocalizedString("Purchase", comment: "")
      PerchaseButton.setTitle(title, for: .normal)
      PerchaseButton.titleLabel?.adjustsFontSizeToFitWidth = true
      PerchaseButton.titleLabel?.adjustsFontForContentSizeCategory = true
      PerchaseButton.layer.cornerRadius =  5
   }
   
   private func SetUpRestoreButton() {
      let title = NSLocalizedString("Restore", comment: "")
      RestoreButton.setTitle(title, for: .normal)
      RestoreButton.titleLabel?.adjustsFontSizeToFitWidth = true
      RestoreButton.titleLabel?.adjustsFontForContentSizeCategory = true
      RestoreButton.layer.cornerRadius =  5
   }
   
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
