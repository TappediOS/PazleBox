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

class EasyButton: FUIButton {
   
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   public func Init(Tag: Int) {
      self.tag = Tag
      
      setTitle("Stage\(Tag)", for: UIControl.State.normal)
      buttonColor = UIColor.turquoise()
      shadowColor = UIColor.greenSea()
      shadowHeight = 3.0
      cornerRadius = 6.0
      titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      
       
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      //self.backgroundColor = UIColor.black
      
   }
}
