//
//  UserProfileHeaderView.swift
//  PazleBox
//
//  Created by jun on 2020/02/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserProfileHeaderView: UIView {
   
   
   
   
   override init(frame: CGRect){
      super.init(frame: frame)
      loadNib()
   }
   
   required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      loadNib()
   }
   
   func loadNib(){
      let view = Bundle.main.loadNibNamed("UserProfileHeaderView", owner: self, options: nil)?.first as! UIView
      view.frame = self.bounds
      self.addSubview(view)
   }
}
