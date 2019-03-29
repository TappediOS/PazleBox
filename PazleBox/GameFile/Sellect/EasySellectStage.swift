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

class SellectStageEasy: UIScrollView {
   
   var ButtonSize: CGFloat = 0
   var Internal: CGFloat = 0
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
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
      for tmp in 1 ...  20 {
         
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
      GameSerPOSTMotification(StageNum: sender.tag)
   }
   
   @objc func TapBackButton (_ sender: UIButton) {
      GameSellectBackPOSTMotification()
   }
   
   
   public func InitView(frame: CGRect) {
      self.frame = frame
      self.contentSize.height = 1000
      self.backgroundColor = UIColor.white
      
      ButtonSize = frame.width / 5
      Internal = ButtonSize / 5
      
      self.InitBackButton()
      self.InitButton()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
