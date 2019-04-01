//
//  ExNotification.swift
//  PazleBox
//
//  Created by jun on 2019/03/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

extension Notification.Name {
   static let TileMoved = Notification.Name("TileMoved")
   static let PuzzleTouchStart = Notification.Name("PuzzleTouchStart")
   static let PuzzleTouchMoved = Notification.Name("PuzzleTouchMoved")
   static let PuzzleTouchEnded = Notification.Name("PuzzleTouchEnded")
   static let GameClear = Notification.Name("GameClear")
   static let SellectStage = Notification.Name("SellectStage")
   static let RePut = Notification.Name("RePut")
   static let Hint = Notification.Name("Hint")
   static let Pouse = Notification.Name("Pouse")
   static let SellectBack = Notification.Name("SellectBack")
   static let RewardAD = Notification.Name("RewardAD")
   static let TapNext = Notification.Name("TapNext")
   static let TapHome = Notification.Name("TapHome")
}
