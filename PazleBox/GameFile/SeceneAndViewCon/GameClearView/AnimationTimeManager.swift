//
//  AnimationTimeManager.swift
//  PazleBox
//
//  Created by jun on 2019/06/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import ViewAnimator


struct AnimationTimeManager {
   
   let SmalToBigAnimation = AnimationType.zoom(scale: 0)
   let BigToSmalAnimation = AnimationType.zoom(scale: 1.5)
   
   let ClearLabelAnimationTime = 1.5
   let StageReviewLabelAnimationTime = 1.8
   let HartAnimationTime1 = 2.0
   let HartAnimationTime2 = 2.1
   let HartAnimationTime3 = 2.2
   let HartAnimationTime4 = 2.3
   let HartAnimationTime5 = 2.4
   let ADInfoLabelAnimationTime = 2.7
   let NextButtonAnimationTime = 3.0
   let HomeButtonAnimationTime = 3.15
   let NoAdButtonAnimaitonTime = 3.3
}
