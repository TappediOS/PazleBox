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
   static let ReSume = Notification.Name("ReSume")
   static let AdWatch = Notification.Name("AdWatch")
   static let AdNoWatch = Notification.Name("AdNoWatch")
   static let FinRewardWatch = Notification.Name("FinRewardWatch")
   static let StopHomeViewBGM = Notification.Name("StopHomeViewBGM")
   static let StartHomeViewBGM = Notification.Name("StartHomeViewBGM")
   static let LockBuyCoinButton = Notification.Name("LockBuyCoinButton")
   static let UnLockBuyCoinButton = Notification.Name("UnLockBuyCoinButton")
   static let BuyNoAdsInClearView = Notification.Name("BuyNoAdsInClearView")
   static let PickUpPiceImageView = Notification.Name("PickUpPiceImageView")
   
   static let PiceMoved = Notification.Name("PiceMoved")
   static let PiceTouchStarted = Notification.Name("PiceTouchStart")
   static let PiceTouchMoved = Notification.Name("PiceTouchMoved")
   static let PiceTouchEnded = Notification.Name("PiceTouchEnded")
   static let UsersGameClear = Notification.Name("UsersGameClear")
   
   static let TapPlayButton = Notification.Name("TapPlayButton")
   static let TapDeleteButton  = Notification.Name("TapDeleteButton")
   static let TapCloseButton = Notification.Name("TapCloseButton")
   
   
   static let ErrSentStageToFireStore = Notification.Name("ErrSentStageToFireStore")
   static let SuccessSentStageToFireStore = Notification.Name("SuccessSentStageToFireStore")
   
   static let AcceptUserAgreement = Notification.Name("AcceptUserAgreement")
   
   static let AdvanceTutorial = Notification.Name("AdvanceTutorial")
   
   static let TurnOnCollectionView = Notification.Name("TurnOnCollectionView")
   static let TuronOffCollectionView = Notification.Name("TuronOffCollectionView")
   static let TurnOnFinButton = Notification.Name("TurnOnFinButton")
   static let TuronOffFinButton = Notification.Name("TuronOffFinButton")
   static let TurnOnChoseResButton = Notification.Name("TurnOnChoseResButton")
   static let TuronOffChoseResButton = Notification.Name("TuronOffChoseResButton")
   static let TuronOnPiceImageView = Notification.Name("TuronOnPiceImageView")
}
