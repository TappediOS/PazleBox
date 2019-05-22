//
//  HardCrHatH.swift
//  PazlHBox
//
//  CrHatHd by jun on 2019/03/09.
//  Copyright © 2019 jun. All rights rHsHrvHd.
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
            [.In, .In, .In, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .In, .In, .Out, .Out, .Out, .In, .In, .In],
            [.In, .In, .In, .In, .In, .In, .In, .In, .In],
            [.In, .In, .In, .In, .Out, .Out, .In, .In, .In],
            [.In, .In, .In, .In, .In, .In, .Out, .In, .In],
            [.Out, .Out, .In, .In, .In, .In, .Out, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .Out, .In, .In]]
      
   }
   
   public func InitH7(){
      
      H7 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .Out, .Out, .Out, .Out],
            [.In, .In, .In, .Out, .In, .In, .Out, .In, .In],
            [.In, .Out, .In, .In, .In, .In, .In, .Out, .In],
            [.In, .In, .In, .Out, .In, .In, .Out, .In, .In],
            [.In, .Out, .In, .In, .In, .In, .In, .Out, .In],
            [.Out, .In, .In, .Out, .In, .In, .Out, .In, .In],
            [.In, .Out, .In, .In, .In, .Out, .In, .In, .Out]]
   }
   
   public func InitH8(){
      H8 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitH9(){
      H9 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .Out, .Out, .Out, .Out, .Out, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out]]
   }
   
   public func InitH10(){
      
      H10 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH11(){
      
      H11 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .In, .Out, .In, .In, .In, .Out]]
   }
   
   public func InitH12(){
      H12 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .Out, .Out, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .Out, .In, .Out],
            [.Out, .Out, .In, .In, .Out, .Out, .In, .In, .Out],
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
            [.In, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .In, .In, .In, .In, .Out]]
   }
   
   public func InitH14(){
      
      H14 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .Out, .In, .In, .Out, .Out, .Out],
            [.Out, .In, .Out, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH15(){
      H15 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .Out, .In, .In],
            [.In, .In, .In, .In, .In, .Out, .Out, .In, .In]]
   }
   
   func InitH16(){
      H16 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .In, .Out],
            [.Out, .Out, .Out, .In, .In, .Out, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH17(){
      
      H17 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .In, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .In],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .Out, .Out, .Out],
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
            [.In, .In, .In, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
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
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
            [.In, .In, .In, .In, .In, .In, .Out, .Out, .Out]]
   }
   
   public func InitH20(){
      
      H20 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .In, .In, .Out, .In, .Out, .In, .In, .Out],
            [.In, .In, .In, .Out, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .Out, .In, .In, .Out]]
   }
   
   public func InitH21(){
      
      H21 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .In, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
             [.In, .In, .In, .In, .In, .Out, .Out, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .Out, .In, .In, .Out, .In, .Out, .In, .Out]]
   }
   
   public func InitH22(){
      H22 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .Out, .In, .In, .Out, .In, .In]]
   }
   
   public func InitH23(){
      H23 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .Out, .In, .Out]]
   }
   
   public func InitH24(){
      H24 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .Out, .In, .Out, .Out, .Out, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .Out, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .Out, .In]]
   }
   
   public func InitH25(){
      H25 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .Out, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .Out, .In, .In, .In, .Out, .Out, .Out]]
   }
   
   public func InitH26(){
      H26 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .Out, .Out, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .Out, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .Out, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .In]]
   }
   
   public func InitH27(){
      H27 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .In, .In, .In, .In, .Out, .Out, .Out],
             [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
             [.In, .In, .In, .Out, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .Out, .Out, .In, .In, .Out, .In, .Out]]
   }
   
   public func InitH28(){
      H28 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .Out, .In, .In, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH29(){
      H29 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .Out, .Out, .Out],
             [.In, .In, .Out, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .Out, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .Out, .Out, .Out],
             [.Out, .Out, .Out, .In, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH30(){
      H30 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .In, .In, .In, .Out, .Out, .Out],
             [.In, .In, .Out, .In, .In, .In, .In, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH31(){
      
      H31 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH32(){
      H32 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .In, .Out, .Out],
             [.In, .In, .Out, .In, .Out, .In, .In, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .Out, .In, .In, .In],
             [.Out, .Out, .Out, .In, .In, .In, .Out, .In, .Out]]
   }
   
   public func InitH33(){
      H33 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .Out, .Out, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitH34(){
      H34 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .Out, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .Out, .In, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .In, .In, .In, .Out]]
   }
   
   public func InitH35(){
      H35 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .Out, .Out, .Out, .In, .Out, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .Out, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .Out, .In, .In, .In, .In, .In, .In],
             [.In, .Out, .In, .In, .Out, .In, .Out, .In, .In],
             [.Out, .Out, .Out, .Out, .In, .In, .In, .In, .Out]]
   }
   
   public func InitH36(){
      H36 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .In, .Out, .In, .In, .Out, .Out, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .Out, .Out, .In],
             [.In, .In, .Out, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .Out, .In, .In],
             [.Out, .Out, .Out, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH37(){
      H37 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .Out, .Out, .Out, .In, .In, .In],
             [.In, .In, .Out, .Out, .In, .Out, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .Out, .In, .In, .In, .In],
             [.Out, .Out, .Out, .Out, .Out, .In, .In, .In, .In]]
   }
   
   public func InitH38(){
      H38 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .Out, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .Out, .In, .Out, .In, .In],
             [.In, .Out, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .Out, .Out, .In, .Out, .In, .In, .In, .In]]
   }
   
   public func InitH39(){
      H39 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .Out, .Out, .In, .In],
             [.Out, .Out, .In, .In, .Out, .Out, .Out, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out]]
   }
   
   public func InitH40(){
      H40 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .Out, .In, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .Out, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .Out, .In, .Out, .In, .In, .In]]
   }
   
   public func InitH41(){
      
      H41 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .In],
             [.In, .In, .In, .In, .In, .Out, .In, .Out, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .Out, .Out, .In, .In, .In, .In, .In]]
   }
   
   public func InitH42(){
      H42 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .Out, .Out, .In, .Out, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .Out, .In],
             [.In, .In, .In, .Out, .In, .In, .In, .In, .Out]]
   }
   
   public func InitH43(){
      H43 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .Out, .In, .In, .Out, .In, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .Out, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH44(){
      H44 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .In, .Out, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .Out, .In],
             [.In, .In, .In, .Out, .Out, .Out, .In, .In, .Out]]
   }
   
   public func InitH45(){
      H45 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .Out, .In, .In],
             [.In, .In, .In, .In, .In, .In, .Out, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out]]
   }
   
   public func InitH46(){
      H46 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH47(){
      H47 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH48(){
      H48 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH49(){
      H49 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   public func InitH50(){
      H50 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In]]
   }
   
   
   
   
}

