//
//  EasySellectStage.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class SellectStageEasy: UIScrollView {
   
   var ButtonSize: CGFloat = 0
   var Internal: CGFloat = 0
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   private func InitButton() {
      for tmp in 1 ...  20 {
         
         let x = (tmp - 1) % 4
         let y = (tmp - 1) / 4
         
         let FirstX = Internal * CGFloat(x + 1) + ButtonSize * CGFloat(x)
         let FirstY = Internal * CGFloat(y + 1) + ButtonSize * CGFloat(y)
         
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
   
   @objc func SellectButton (_ sender: UIButton) {
      print("押されたボタン: \(sender.tag)")
      GameSerPOSTMotification(StageNum: sender.tag)
   }
   
   
   public func InitView(frame: CGRect) {
      self.frame = frame
      self.contentSize.height = 1000
      self.backgroundColor = UIColor.white
      
      ButtonSize = frame.width / 5
      Internal = ButtonSize / 5
      
      self.InitButton()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
