//
//  ExSellectForSegmentedControl.swift
//  PazleBox
//
//  Created by jun on 2019/12/14.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import TwicketSegmentedControl
import TapticEngine
import Firebase

extension SellectInternetStageViewController: TwicketSegmentedControlDelegate {
   
   func didSelect(_ segmentIndex: Int) {
      Play3DtouchMedium()
      guard CanSellectStage == true else {
         print("Segment Controllできません。")
         return
      }
      
      print("Selected index: \(segmentIndex)")
      
      UsingStageDatas.removeAll()
      
      switch segmentIndex {
      case 0:
         UsingStageDatas = LatestStageDatas
         Analytics.logEvent("TapLatestStageDatas", parameters: nil)
      case 1:
         UsingStageDatas = PlayCountStageDatas
         Analytics.logEvent("TapPlayCountStageDatas", parameters: nil)
      case 2:
         UsingStageDatas = RatedStageDatas
         Analytics.logEvent("TapRatedStageDatas", parameters: nil)
      default:
         print("\n\nあり得ない\n\n")
         return
      }
      
      self.StageCollectionView.reloadData()
   }
}
