//
//  Puzzle.swift
//  PazleBox
//
//  Created by jun on 2019/03/10.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation


class puzzle {

   
   var pAllPosi: [[Int]] = Array()
   
   init(PazzleX: Int, PazzleY: Int){
      
      for x in 0 ... PazzleX - 1{
         for y in 0 ... PazzleY - 1 {
            pAllPosi[x][y] = 0
         }
      }
      
   }
   
   
}
