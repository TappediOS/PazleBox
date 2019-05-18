//
//  NormalCrNatN.swift
//  PazlNBox
//
//  CrNatNd by jun on 2019/03/09.
//  Copyright © 2019 jun. All rights rNsNrvNd.
//

import Foundation

extension Normal {
   
   public func InitN1(){
      N1 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .Out, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .Out, .Out, .In, .In, .In, .In, .Out, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .In, .In, .In]]
   }
   
   public func InitN2(){
      N2 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .Out, .In, .Out, .In, .Out],
            [.Out, .In, .In, .In, .In, .Out, .In, .In, .Out],
            [.Out, .Out, .In, .Out, .In, .In, .Out, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN3(){
      N3 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .Out, .Out, .Out, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .Out, .Out, .Out, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN4(){
      N4 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .Out, .Out, .In, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .Out, .Out, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN5(){
      N5 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitN6(){
      N6 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .Out, .In, .Out],
            [.Out, .In, .In, .Out, .In, .Out, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
            [.Out, .In, .In, .Out, .In, .Out, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .Out, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out]]
   }
   
   public func InitN7(){
      N7 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .Out, .In, .In, .In, .In, .In, .Out, .In],
            [.Out, .In, .Out, .In, .Out, .In, .Out, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .Out, .In, .In, .In, .Out, .In, .Out]]
   }
   
   public func InitN8(){
      N8 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .Out, .In, .Out, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .Out, .In, .Out, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out]]
   }
   
   func InitN9(){
      N9 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .In, .In, .Out, .Out, .Out],
            [.Out, .In, .Out, .Out, .In, .Out, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .Out, .Out, .Out],
            [.Out, .In, .Out, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .Out, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN10(){
      N10 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .Out, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .Out, .In, .Out, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .In, .Out, .In, .Out, .Out, .Out]]
   }
   
   public func InitN11(){
      N11 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .Out, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .Out, .Out, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN12(){
      N12 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .Out, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .In, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN13(){
      N13 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN14(){
      N14 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN15(){
      N15 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .Out, .Out, .Out, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .Out, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .In, .Out, .Out]]
   }
   
   public func InitN16(){
      N16 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .Out, .In, .Out, .Out],
            [.Out, .Out, .Out, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .Out, .Out, .In, .Out],
            [.In, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .Out]]
   }
   
   public func InitN17(){
      N17 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .Out, .In, .Out, .In, .In, .In, .In, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN18(){
      N18 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .In, .In, .In, .Out, .Out, .Out],
            [.Out, .Out, .Out, .In, .Out, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .In, .In, .In, .In, .In],
            [.In, .Out, .In, .Out, .Out, .In, .In, .Out, .In],
            [.In, .In, .In, .In, .In, .In, .In, .In, .In],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN19(){
      N19 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.In, .In, .In, .In, .In, .In, .Out, .Out, .Out],
            [.In, .Out, .In, .In, .In, .In, .In, .In, .Out],
            [.In, .In, .In, .In, .Out, .In, .In, .In, .In],
            [.Out, .In, .Out, .In, .In, .In, .Out, .In, .In],
            [.In, .In, .In, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN20(){
      N20 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
            [.Out, .In, .In, .In, .In, .In, .In, .Out, .Out],
            [.Out, .Out, .Out, .Out, .Out, .In, .Out, .Out, .Out]]
   }
   
   public func InitN21(){
      
      N21 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .Out, .In, .In, .In, .Out],
             [.Out, .Out, .In, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   public func InitN22(){
      N22 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .Out, .In, .In, .Out],
             [.In, .In, .In, .In, .Out, .In, .In, .In, .In],
             [.In, .In, .In, .In, .In, .In, .In, .Out, .Out],
             [.Out, .Out, .Out, .Out, .In, .In, .In, .In, .In],
             [.Out, .Out, .Out, .Out, .Out, .In, .Out, .Out, .Out]]
   }
   
   func InitN23(){
      N23 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out]]
   }
   
   func InitN24(){
      N24 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .In, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.In, .In, .In, .In, .In, .In, .In, .In, .Out],
             [.Out, .In, .In, .In, .In, .In, .Out, .In, .Out],
             [.Out, .Out, .In, .In, .In, .Out, .Out, .Out, .Out]]
   }
   
   func InitN25(){
      N25 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .Out, .Out, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .Out, .Out, .Out, .Out],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .Out, .In, .In, .In, .In],
             [.Out, .In, .In, .In, .In, .In, .In, .In, .In],
             [.Out, .Out, .In, .In, .In, .Out, .Out, .Out, .Out]]
   }
   
   func InitN26(){
      N26 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN27(){
      N27 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN28(){
      N28 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN29(){
      N29 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN30(){
      N30 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN31(){
      
      N31 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN32(){
      N32 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN33(){
      N33 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN34(){
      N34 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN35(){
      N35 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN36(){
      N36 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN37(){
      N37 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN38(){
      N38 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN39(){
      N39 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   func InitN40(){
      N40 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN41(){
      
      N41 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN42(){
      N42 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN43(){
      N43 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN44(){
      N44 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN45(){
      N45 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN46(){
      N46 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN47(){
      N47 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN48(){
      N48 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN49(){
      N49 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
   
   public func InitN50(){
      N50 = [[.Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out, .Out],
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
