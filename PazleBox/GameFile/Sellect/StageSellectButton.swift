//
//  EasyButton.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit

class StageSellectButton: UIButton {
   
   var CanPlay: Bool = true
   
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   public func Init(Tag: Int, PlayerCanPlayMaxStageNum: Int, ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      self.tag = Tag
      self.setTitle("\(Tag)", for: .normal)
      self.titleLabel?.font = UIFont(name: "Helvetica", size: 28)
      self.titleLabel?.adjustsFontSizeToFitWidth = true
      self.layer.cornerRadius = 6.0
      
      //プレイが可能なステージのボタンの処理
      if Tag <= PlayerCanPlayMaxStageNum  {
         self.setTitle("\(Tag)", for: .normal)
         self.backgroundColor = ButtonColor
         self.CanPlay = true
         return
      }
      
      //クリアしてないステージの処理
      self.setTitle("\(Tag)", for: .normal)
      self.backgroundColor = ButtonShadowColor
      self.CanPlay = false
      return
   }
   
   public func GetCanPlay() -> Bool {
      return self.CanPlay
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      //self.backgroundColor = UIColor.black
      
   }
}
