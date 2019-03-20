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
}
