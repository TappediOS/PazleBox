//
//  Stage.swift
//  PazleBox
//
//  Created by jun on 2019/03/07.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class HoldStage {
   
   enum Contents {
      case In
      case Out
      case Put
      case NotPut
   }
   
   //Stage 9 * 12
   public var Stage: [[Contents]]

   
   
   
   init(){
      Stage = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
      
      InitStage()
   }
   
   private func InitStage(){

   }

}
