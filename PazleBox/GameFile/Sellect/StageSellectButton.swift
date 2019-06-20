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

class StageSellectButton: FUIButton {
   
   var CanPlay: Bool = true
   
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   public func Init(Tag: Int, PlayerCanPlayMaxStageNum: Int, ButtonColor: UIColor, ButtonShadowColor: UIColor) {
      self.tag = Tag
      
      if Tag <= PlayerCanPlayMaxStageNum  {
         setTitle("Stage\(Tag)", for: UIControl.State.normal)
         buttonColor = ButtonColor
         shadowColor = ButtonShadowColor
         shadowHeight = 3.0
         cornerRadius = 6.0
         titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
         setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
         setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
         
         CanPlay = true
         return
      }
      
      setTitle("Stage\(Tag)", for: UIControl.State.normal)
      buttonColor = ButtonShadowColor
      shadowColor = ButtonShadowColor
      titleLabel?.adjustsFontSizeToFitWidth = true
      shadowHeight = 3.0
      cornerRadius = 6.0
      titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      
      CanPlay = false
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
