//
//  NormalSellectStage.swift
//  PazleBox
//
//  Created by jun on 2019/05/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import TapticEngine
import RealmSwift
import SCLAlertView
import Firebase
import Hero

class SellectStageNormal: UIScrollView {
   
   var ButtonSize: CGFloat = 0
   var Internal: CGFloat = 0
   
   let realm = try! Realm()
   let AllStageNum = 50
   
   let BadgeScale = AllBadgeScale()
   
   var TapLockedButton = false
   
   let HeroID = HeroIDs()

   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      InitStageClearArry()
      print(Realm.Configuration.defaultConfiguration.fileURL!)
   }
   
   private func FirstOpenSellectEasyStage() {
      for tmp in 1 ...  AllStageNum {
         let InitInfo = NormalStageClearInfomation()
         
         InitInfo.StageNum = tmp
         InitInfo.Clear = false
         InitInfo.CountOfUsedHint = 3
         
         try! realm.write {
            realm.add(InitInfo)
         }
      }
   }
   
   private func InitStageClearArry() {
      
      let RealmCount = realm.objects(NormalStageClearInfomation.self).count
      
      print("\nRealmCount(Normal) = \(RealmCount)")
      
      if RealmCount == 0 {
         print("初めて開いたのでRealm(Normal)の初期化を行います")
         FirstOpenSellectEasyStage()
         return
      }
   }
   
   public func InitView(frame: CGRect, ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      self.frame = frame
      
      ButtonSize = frame.width / 5
      Internal = ButtonSize / 5
      
      let BackButtonHight = Internal + ButtonSize / 2
      
      let StageNumH = CGFloat( (AllStageNum + 1) / 4 + 2 )
      let ScrollViewHight: CGFloat = BackButtonHight + (ButtonSize + Internal) * StageNumH
      
      self.contentSize.height = ScrollViewHight
      
      self.InitButton(ButtonColor: ButtonColor, ButtonShadowColor: ButtonShadowColor)
      self.InitBackButton(ButtonColor: ButtonShadowColor, ButtonShadowColor: ButtonShadowColor)
   }
   
   private func InitBackButton(ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      let FirstX = Internal
      let FirstY = Internal
      let Frame = CGRect(x: FirstX, y: FirstY, width: ButtonSize, height: ButtonSize / 2)
      let BackB = FUIButton(frame: Frame)
      BackB.setTitle("←", for: UIControl.State.normal)
      BackB.buttonColor = ButtonColor
      BackB.shadowColor = ButtonShadowColor
      BackB.shadowHeight = 3.0
      BackB.cornerRadius = 6.0
      BackB.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      BackB.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      BackB.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      BackB.addTarget(self, action: #selector(self.TapBackButton(_:)), for: UIControl.Event.touchUpInside)
      BackB.hero.id = HeroID.BackNormalStage
      self.addSubview(BackB)
   }
   
   //ボタンをそれぞれ作成するよ
   private func InitEachButton(tmp: Int, PlayerCanPlayMaxStageNum: Int, ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      let x = (tmp - 1) % 4
      let y = (tmp - 1) / 4
      
      let FirstX = Internal * CGFloat(x + 1) + ButtonSize * CGFloat(x)
      let FirstY = Internal * CGFloat(y + 1) + ButtonSize * CGFloat(y) + ButtonSize
      
      let ButtonFrame = CGRect(x: FirstX, y: FirstY, width: ButtonSize, height: ButtonSize)
      
      let NormalNumberButton = StageSellectButton(frame: ButtonFrame)
      NormalNumberButton.Init(Tag: tmp, PlayerCanPlayMaxStageNum: PlayerCanPlayMaxStageNum, ButtonColor: ButtonColor, ButtonShadowColor: ButtonShadowColor)
      NormalNumberButton.addTarget(self, action: #selector(self.SellectButton(_:)), for: UIControl.Event.touchUpInside)
      NormalNumberButton.hero.modifiers = [.cascade, .fade, .scale(0.65), .delay(0.01 + Double(tmp) * 0.01)]
      self.addSubview(NormalNumberButton)
      
      
      ///MARK: ここからバッジをつける
      let NormalStageInfo = realm.objects(NormalStageClearInfomation.self)
      
      //クリアしてなくて遊べる状態なら続ける
      if NormalStageInfo[tmp - 1].CountOfUsedHint == 3 && tmp <= PlayerCanPlayMaxStageNum{
         return
      }
      
      let BadgeSize = ButtonSize / 2
      let BadgeStartX = FirstX - (BadgeSize / 2)
      let BadgeStartY = FirstY - (BadgeSize / 2)
      let BadgeFrame = CGRect(x: BadgeStartX, y: BadgeStartY, width: BadgeSize, height: BadgeSize)
      
      let Badge = UIImageView(frame: BadgeFrame)
      Badge.isUserInteractionEnabled = false
      Badge.hero.modifiers = [.cascade, .fade, .scale(0.65), .delay(0.01 + Double(tmp) * 0.01)]
      
      switch NormalStageInfo[tmp - 1].CountOfUsedHint {
      case 3:
         let BadgeImage = UIImage(named: "Lock_Badge.png")
         Badge.image = BadgeImage
         Badge.transform = CGAffineTransform(scaleX: BadgeScale.Lock, y: BadgeScale.Lock)
      case 2:
         let BadgeImage = UIImage(named: "Bronze_Badge.png")
         Badge.image = BadgeImage
         Badge.transform = CGAffineTransform(scaleX: BadgeScale.Bronze, y: BadgeScale.Bronze)
      case 1:
         let BadgeImage = UIImage(named: "Silver_Badge.png")
         Badge.image = BadgeImage
         Badge.transform = CGAffineTransform(scaleX: BadgeScale.Silver, y: BadgeScale.Silver)
      case 0:
         let BadgeImage = UIImage(named: "Gold_Badge.png")
         Badge.image = BadgeImage
         Badge.transform = CGAffineTransform(scaleX: BadgeScale.Gold, y: BadgeScale.Gold)
      default:
         fatalError("一体何が入ってんねん")
      }
      
      self.addSubview(Badge)
   }
   
   private func InitButton(ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      let ClearOfNot = realm.objects(NormalStageClearInfomation.self).filter("Clear == true")
      var LastClearNum: Int = 1
      
      if ClearOfNot.isEmpty == true {
         LastClearNum = 1
      }else{
         if let Last = ClearOfNot.last?.StageNum {
            LastClearNum = Last
         }else{
            fatalError("ステージナンバーnil入ってて笑えない")
         }
      }
      
      print("クリアステージの最大番号は\(String(describing: LastClearNum))")
      
      let PlayerCanPlayMaxStageNum = LastClearNum + 3
      
      for tmp in 1 ...  AllStageNum {
         let ButtonCreateQueue = DispatchQueue.main
         ButtonCreateQueue.async {
            self.InitEachButton(tmp: tmp, PlayerCanPlayMaxStageNum: PlayerCanPlayMaxStageNum, ButtonColor: ButtonColor, ButtonShadowColor: ButtonShadowColor)
         }
      }
   }
   
   //MARK:- 通知を送る関数
   private func GameSerPOSTMotification(StageNum: Int) {
      
      Analytics.logEvent("PlayNormalStage", parameters: nil)
      
      let SentObject: [String : Any] = ["StageNum": StageNum as Int]
      
      print("")
      NotificationCenter.default.post(name: .SellectStage, object: nil, userInfo: SentObject)
   }
   
   private func GameSellectBackPOSTMotification() {
      Analytics.logEvent("BackSellectNormal", parameters: nil)
      NotificationCenter.default.post(name: .SellectBack, object: nil, userInfo: nil)
   }
   
   private func ShowErrorView() {
      
      guard self.TapLockedButton == false else { return }
      TapLockedButton = true
      
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ErrorAlertView = SCLAlertView(appearance: Appearanse)
      ErrorAlertView.addButton("OK"){
         self.Play3DtouchMedium()
         self.TapLockedButton = false
      }
      ErrorAlertView.showWarning(NSLocalizedString("Locked", comment: ""), subTitle: "Clear previous levels to unlock.")
      
   }
   
   @objc func SellectButton (_ sender: StageSellectButton) {
      print("押されたボタン: \(sender.tag)")
      
      if sender.GetCanPlay() == false {
         Play3DtouchError()
         ShowErrorView()
         return
      }
      
      Play3DtouchLight()
      GameSerPOSTMotification(StageNum: sender.tag)
   }
   
   @objc func TapBackButton (_ sender: UIButton) {
      Play3DtouchMedium()
      GameSellectBackPOSTMotification()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func Play3DtouchLight() {
      TapticEngine.impact.feedback(.light)
      return
   }
   
   private func Play3DtouchMedium() {
      TapticEngine.impact.feedback(.medium)
      return
   }
   
   private func Play3DtouchHeavy() {
      TapticEngine.impact.feedback(.heavy)
      return
   }
   
   private func Play3DtouchError() {
      TapticEngine.notification.feedback(.error)
   }
}
