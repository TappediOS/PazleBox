//
//  HardCreate.swift
//  PazleBox
//
//  Created by jun on 2019/03/09.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

extension Hard {
   
   public func InitH1(){
      
      H1 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out],
            [.Out, .Out,  .In,  .In,  .In,  .In,  .In,  .Out,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .Out,  .In,  .In,  .In,  .In,  .In,  .Out,  .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH2(){
      H2 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out],
            [.Out, .Out,  .Out,  .In,  .In,  .In,  .Out,  .Out,  .Out],
            [.Out, .Out,  .In,  .In,  .In,  .In,  .In,  .Out,  .Out],
            [.Out, .In,  .In,  .In,  .Out,  .In,  .In,  .In,  .Out],
            [.Out, .Out,  .In,  .In,  .In,  .In,  .In,  .Out,  .Out],
            [.Out, .Out,  .Out,  .In,  .In,  .In,  .Out,  .Out,  .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out]]
   }
   
   func InitH3(){
      H3 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH4(){
      
      H4 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .In],
            [.In, .In,  .In,  .In,  .Out,  .In,  .In,  .In,  .In],
            [.In, .In,  .In,  .In,  .Out,  .In,  .In,  .In,  .In],
            [.In, .In,  .In,  .In,  .Out,  .In,  .In,  .In,  .In],
            [.In, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .In]]
   }
   
   public func InitH5(){
      H5 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .Out,  .In,  .In,  .Out,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .Out,  .In,  .In,  .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH6(){
      H6 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .In,  .In,  .In,  .In,  .In,  .In,  .In,  .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
      
   }
   
   public func InitH7(){
      
      H7 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH8(){
      H8 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH9(){
      H9 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH10(){
      
      H10 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH11(){
      
      H11 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH12(){
      H12 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH13(){
      H13 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH14(){
      
      H14 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH15(){
      H15 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH16(){
      H16 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH17(){
      
      H17 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH18(){
      H18 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH19(){
      H19 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH20(){
      
      H20 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   
   
   
}

