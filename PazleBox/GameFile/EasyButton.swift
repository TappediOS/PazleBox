//
//  EasyButton.swift
//  PazleBox
//
//  Created by jun on 2019/03/25.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class EasyButton: UIButton {
   
   
   required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   public func Init(Tag: Int) {
      self.tag = Tag
       
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.backgroundColor = UIColor.black
      
   }
}
