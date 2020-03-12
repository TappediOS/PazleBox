//
//  PiceShopEachViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/12.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class PiceShopEachViewController: UIViewController {
   
   var PiceShptTag = 0
   
   let PiceSet1 = ["33p7Red", "33p7Green", "33p7Blue",
                   "43p10Red", "43p1Green", "43p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   "23p12Red", "23p12Green", "23p12Blue",
                   "43p26Red", "43p26Green", "43p26Blue",
                   "33p25Red","33p25Green","33p25Blue"
                  ]
   
   let PiceSet2 = ["33p7Red", "33p7Green", "33p7Blue",
                   "43p10Red", "43p1Green", "43p10Blue",
                   "23p14Red", "23p14Green", "23p14Blue",
                   "23p12Red", "23p12Green", "23p12Blue",
                   "43p26Red", "43p26Green", "43p26Blue",
                   "33p25Red","33p25Green","33p25Blue"
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
   
   public func getPiceShopTag(tag: Int) {
      self.PiceShptTag = tag
   }
}
