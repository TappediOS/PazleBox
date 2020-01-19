//
//  TutorialManager.swift
//  PazleBox
//
//  Created by jun on 2020/01/18.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import TapticEngine
import Firebase

enum TutorialState {
   case none                           //状態なし
   case wait                           //まつ
   case advance                        //文字を進める状態
   case operationFinButton             //ユーザがFinButtonを操作する状態
   case operationResChoseButton        //ユーザがResChoseButtonを操作する状態
   case operationCollectionViewFirst   //ユーザがCollectionView操作する状態(1回目)
   case operationCollectionViewSecond  //ユーザがCollectionView操作する状態(2回目)
   case operationTapPiceViewFirst      //ユーザがPiceView操作する状態(1回目)
   case operationTapPiceViewSecond     //ユーザがPiceView操作する状態(2回目)
}

class TutorialManager {
   var state = TutorialState.none
   var tutorialNum = 1
   
   let gameSound = GameSounds()
   
   init() {
      state = .advance
   }
   
   public func getState() -> TutorialState { return self.state }
   public func getTutorialNum() -> Int { return self.tutorialNum }
   
   public func advanceTutorial() {
      tutorialNum += 1
      NotificationCenter.default.post(name: .AdvanceTutorial, object: nil)
   }
   
   func TurnOnCollectionViewNotification() {
      NotificationCenter.default.post(name: .TurnOnCollectionView, object: nil)
   }
   
   func TuronOffCollectionViewNotification() {
      NotificationCenter.default.post(name: .TuronOffCollectionView, object: nil)
   }
   
   func TurnOnFinButtonNotification() {
      NotificationCenter.default.post(name: .TurnOnFinButton, object: nil)
   }
   
   func TuronOffFinButtonNotification() {
      NotificationCenter.default.post(name: .TuronOffFinButton, object: nil)
   }
   
   func TurnOnChoseResButtonNotification() {
      NotificationCenter.default.post(name: .TurnOnChoseResButton, object: nil)
   }
   
   func TuronOffChoseResButtonNotification() {
      NotificationCenter.default.post(name: .TuronOffChoseResButton, object: nil)
   }
   
   //cellタップしたときに出てくる3つのpiceをタップできるようにする。
   func TurnOnPiceImagesNotification() {
      NotificationCenter.default.post(name: .TuronOnPiceImageView, object: nil)
   }
   
   func StartAnimationCollectionViewFirst() {
      NotificationCenter.default.post(name: .StartAnimationCollectionViewFirst, object: nil)
   }
   
   func StartAnimationCollectionViewSecond() {
      NotificationCenter.default.post(name: .StartAnimationCollectionViewSecond, object: nil)
   }
   
   func StartAnimationFinButton() {
      NotificationCenter.default.post(name: .StartAnimationFinButton, object: nil)
   }
   
   func StartAnimationResButton() {
      NotificationCenter.default.post(name: .StartAnimationResButton, object: nil)
   }
   
   func StartAnimationDragAndDropFirst() {
      NotificationCenter.default.post(name: .StartAnimationDragAndDropFirst, object: nil)
   }
   
   func StartAnimationDragAndDropSecond() {
      NotificationCenter.default.post(name: .StartAnimationDragAndDropSecond, object: nil)
   }
   
   func ClearTapImageView() {
      NotificationCenter.default.post(name: .ClearTapImageView, object: nil)
   }
   
   func FinishTutorial() {
      NotificationCenter.default.post(name: .FinishTutorial, object: nil)
   }
   

   
   public func TapTutorialView() {
      print("現在のチュートリアル番号: \(self.tutorialNum)")
      switch self.tutorialNum {
      case 1:
         advanceTutorial()
         state = .advance
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial1", parameters: nil)
      case 2:
         advanceTutorial()
         TurnOnCollectionViewNotification()
         StartAnimationCollectionViewFirst()
         state = .operationCollectionViewFirst
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial2", parameters: nil)
      case 3:
         print("状態が3のときはCollectionViewタップするまで待つ。")
         return
      case 4:
         advanceTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial4", parameters: nil)
      case 5:
         advanceTutorial()
         TurnOnPiceImagesNotification()
         StartAnimationDragAndDropFirst()
         state = .operationTapPiceViewFirst
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial5", parameters: nil)
      case 6:
         print("状態が6のときはPiceViewタップするまで待つ。")
         return
      case 7:
         advanceTutorial()
         TurnOnCollectionViewNotification()
         StartAnimationCollectionViewSecond()
         state = .operationCollectionViewSecond
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial7", parameters: nil)
      case 8:
         print("状態が8のときはCollectionViewタップするまで待つ。")
         return
      case 9:
         print("状態が9のときはPiceViewタップするまで待つ。")
         return
      case 10:
         print("状態が10のときはFinボタンタップするまで待つ。")
         return
      case 11:
         advanceTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial11", parameters: nil)
      case 12:
         advanceTutorial()
         StartAnimationResButton()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial12", parameters: nil)
         return
      case 13:
         print("状態が13のときは初期位置決めのためにピース移動するまで待つ。")
         return
      case 14:
         advanceTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial14", parameters: nil)
      case 15:
         advanceTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial15", parameters: nil)
      case 16:
         advanceTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial16", parameters: nil)
      case 17:
         print("チュートリアル終わり！")
         FinishTutorial()
         gameSound.PlaySoundsTapButton()
         Play3DtouchMedium()
         Analytics.logEvent("FinTutorial17", parameters: nil)
      default:
         print("チュートリアル番号が間違っています。")
         return
      }
   }
   
   public func finishTapCollectionViewFirst() {
      print("CollectinViewのタップ終わったよ。1回目")
      TuronOffCollectionViewNotification()
      ClearTapImageView()
      advanceTutorial()
      state = .advance
      Analytics.logEvent("FinTutorial3", parameters: nil)
   }
   
   public func finishTapCollectionViewSecond() {
      print("CollectinViewのタップ終わったよ。2回目")
      TuronOffCollectionViewNotification()
      ClearTapImageView()
      StartAnimationDragAndDropSecond()
      advanceTutorial()
      state = .operationTapPiceViewSecond
      Analytics.logEvent("FinTutorial8", parameters: nil)
   }
   
   public func finishDragAndDropPiceFirst() {
      print("ドラッグアンドドロップおわったよ。1回目")
      ClearTapImageView()
      advanceTutorial()
      state = .advance
      Analytics.logEvent("FinTutorial6", parameters: nil)
   }
   
   public func finishDragAndDropPiceSecond() {
      print("ドラッグアンドドロップおわったよ。2回目")
      advanceTutorial()
      ClearTapImageView()
      TurnOnFinButtonNotification()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
         self.StartAnimationFinButton()
      }
      state = .operationFinButton
      Analytics.logEvent("FinTutorial9", parameters: nil)
   }
   
   public func finishTapFinButton() {
      print("Finボタンのタップおわったよ")
      advanceTutorial()
      TurnOnChoseResButtonNotification()
      state = .operationResChoseButton
      ClearTapImageView()
      Analytics.logEvent("FinTutorial10", parameters: nil)
   }
   
   public func finishTapFinChoseResButton() {
      //FinResがピース移動した上で押されたことが保証されているから14まで飛ばしていい
      tutorialNum = 14
      NotificationCenter.default.post(name: .AdvanceTutorial, object: nil)
      ClearTapImageView()
      state = .advance
      Analytics.logEvent("FinTutorial13", parameters: nil)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
