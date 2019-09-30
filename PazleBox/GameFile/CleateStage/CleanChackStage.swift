//
//  CleanChackStage.swift
//  PazleBox
//
//  Created by jun on 2019/09/30.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

class CleanCheckStage {
   
   var Checked: [[Contents]] = Array()
   
   init() {
      InitCheckd()
   }
   
   private func InitCheckd() {
      Checked = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
                 [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
}
