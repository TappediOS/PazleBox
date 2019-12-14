//
//  ExSellectForSegmentedControl.swift
//  PazleBox
//
//  Created by jun on 2019/12/14.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import TwicketSegmentedControl

extension SellectInternetStageViewController: TwicketSegmentedControlDelegate {
   
   func didSelect(_ segmentIndex: Int) {
      
      
      
      print("Selected index: \(segmentIndex)")
      
      UsingStageDatas.removeAll()
      
      switch segmentIndex {
      case 0:
         UsingStageDatas = LatestStageDatas
      case 1:
         UsingStageDatas = PlayCountStageDatas
      case 2:
         UsingStageDatas = RatedStageDatas
      default:
         print("\n\nあり得ない\n\n")
         return
      }
      
      self.StageCollectionView.reloadData()
      
   }
}
