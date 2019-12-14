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
   }
}
