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

class PiceShopEachViewController: UIViewController {
   
   
   @IBOutlet weak var PiceCollectionView: UICollectionView!
   //こいつがCollecti on viewのレイアウトを決めている
   //上下左右にどれだけの感覚を開けるかを決める。
   let sectionInsets = UIEdgeInsets(top: 15.0, left: 8.0, bottom: 10.0, right: 8.0)
   //Cellを横に何個入れるか
   let itemsPerRow: CGFloat = 4
   
   var PiceShptTag = 0
   
   
   @IBOutlet weak var PerchaseButton: UIButton!
   @IBOutlet weak var RestoreButton: UIButton!
   
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
   
   let PiceSet4 = ["33p7Red", "33p7Green", "33p7Blue",
                   "43p10Red", "43p1Green", "43p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   "23p12Red", "23p12Green", "23p12Blue",
                   "43p26Red", "43p26Green", "43p26Blue",
                   "33p25Red","33p25Green","33p25Blue"
   ]
   
   var UsingPiceSet: [String] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      print("表示するタグ番号: \(PiceShptTag)\n")
      SetUpNavigationBar()
      SetUpUsingPiceSet()
      SetUpPerchaseButton()
      SetUpRestoreButton()
      LoadCollectionView()
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("Pice Set \(self.PiceShptTag)", comment: "")
   }
   
   private func SetUpUsingPiceSet() {
      self.UsingPiceSet.removeAll()
      switch self.PiceShptTag {
      case 1:
         self.UsingPiceSet = self.PiceSet1
      case 2:
         self.UsingPiceSet = self.PiceSet2
      case 3:
         self.UsingPiceSet = self.PiceSet3
      case 4:
         self.UsingPiceSet = self.PiceSet4
      default:
         fatalError("訳のわからん数字が入ってる")
      }
   }
   
   private func SetUpPerchaseButton() {
      let title = NSLocalizedString("Perchase", comment: "")
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
      PiceCollectionView.layer.borderWidth = 1
      PiceCollectionView.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
      PiceCollectionView.layer.cornerRadius = 5
      PiceCollectionView.layer.masksToBounds = true
      PiceCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
      PiceCollectionView.delegate = self
      PiceCollectionView.dataSource = self
      PiceCollectionView.collectionViewLayout.invalidateLayout()
      PiceCollectionView.hero.modifiers = [.cascade]
   }
   
   public func getPiceShopTag(tag: Int) {
      self.PiceShptTag = tag
   }
}
