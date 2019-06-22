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
   
   let SmalToBigAnimation = AnimationType.zoom(scale: 1.5)
   let BigToSmalAnimation = AnimationType.zoom(scale: 0)
   
   let ClearLabelAnimationTime = 2.3
   let StageReviewLabelAnimationTime = 2.5
   let HartAnimationTime1 = 2.7
   let HartAnimationTime2 = 2.8
   let HartAnimationTime3 = 2.9
   let HartAnimationTime4 = 3.0
   let HartAnimationTime5 = 3.1
   let ADInfoLabelAnimationTime = 3.3
   let NextButtonAnimationTime = 3.5
   let HomeButtonAnimationTime = 3.6
   let NoAdButtonAnimaitonTime = 3.7
}
