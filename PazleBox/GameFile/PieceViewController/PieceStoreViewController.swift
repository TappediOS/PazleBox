//
//  PieceStoreViewController.swift
//  PazleBox
//
//  Created by jun on 2019/06/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class PiceStoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 18 // 表示するセルの数
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
      cell.backgroundColor = .black  // セルの色
      return cell
   }
}
