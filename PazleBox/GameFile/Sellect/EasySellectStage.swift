//
//  EasySellectStage.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import TapticEngine
import RealmSwift

class SellectStageEasy: UIScrollView {
   
   var ButtonSize: CGFloat = 0
   var Internal: CGFloat = 0
   
   
   var EasyStageClearInfo: [(Clear: Bool, CountOfusedHint: Int)] = []

   let userDefaults = UserDefaults.standard
   
   let AllStageNum = 50

   override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      
      print(Realm.Configuration.defaultConfiguration.fileURL)
      
      InitStageClearArry()
   }
   
   private func FirstInitArry() {
      let SetTapple: (Bool, Int) = (false, 2)
      for tmp in 0 ... AllStageNum - 1 {
         //EasyStageClearInfo[tmp] = SetTapple
         EasyStageClearInfo.append(SetTapple)
      }
      
      
     // userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: <#T##Any#>, requiringSecureCoding: <#T##Bool#>), forKey: "EasyStageClearInfomation")
   }
   
   private func InitStageClearArry() {
      
      if userDefaults.object(forKey: "EasyStageClearInfomation") == nil {
         print("初めて起動したのでEasyStageのクリア情報を初期化します。")
         FirstInitArry()
      }else{
         EasyStageClearInfo = userDefaults.object(forKey: "EasyStageClearInfo") as! [(Clear: Bool, CountOfusedHint: Int)]
      }
   
   }
   
   public func InitView(frame: CGRect) {
      self.frame = frame
      self.contentSize.height = frame.height * 5
      
      
      ButtonSize = frame.width / 5
      Internal = ButtonSize / 5
      
      self.InitBackButton()
      self.InitButton()
   }
   
   private func InitBackButton() {
      let FirstX = Internal
      let FirstY = Internal
      let Frame = CGRect(x: FirstX, y: FirstY, width: ButtonSize, height: ButtonSize / 2)
      let BackB = FUIButton(frame: Frame)
      BackB.setTitle("←", for: UIControl.State.normal)
      BackB.buttonColor = UIColor.greenSea()
      BackB.shadowColor = UIColor.greenSea()
      BackB.shadowHeight = 3.0
      BackB.cornerRadius = 6.0
      BackB.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      BackB.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      BackB.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      BackB.addTarget(self, action: #selector(self.TapBackButton(_:)), for: UIControl.Event.touchUpInside)
      self.addSubview(BackB)
   }
   
   private func InitButton() {
      for tmp in 1 ...  AllStageNum {
         
         let x = (tmp - 1) % 4
         let y = (tmp - 1) / 4
         
         let FirstX = Internal * CGFloat(x + 1) + ButtonSize * CGFloat(x)
         let FirstY = Internal * CGFloat(y + 1) + ButtonSize * CGFloat(y) + ButtonSize
         
         let Frame = CGRect(x: FirstX, y: FirstY, width: ButtonSize, height: ButtonSize)
         
         let EasyNumberButton = EasyButton(frame: Frame)
         EasyNumberButton.Init(Tag: tmp)
         EasyNumberButton.addTarget(self, action: #selector(self.SellectButton(_:)), for: UIControl.Event.touchUpInside)
         
         
         self.addSubview(EasyNumberButton)
      }
   }
   
   //MARK:- 通知を送る関数
   private func GameSerPOSTMotification(StageNum: Int) {
      
      let SentObject: [String : Any] = ["StageNum": StageNum as Int]
      
      print("")
      NotificationCenter.default.post(name: .SellectStage, object: nil, userInfo: SentObject)
   }
   
   private func GameSellectBackPOSTMotification() {
      NotificationCenter.default.post(name: .SellectBack, object: nil, userInfo: nil)
   }
   
   @objc func SellectButton (_ sender: UIButton) {
      print("押されたボタン: \(sender.tag)")
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
}
