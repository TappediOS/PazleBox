//
//  BackTileImageView.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackTileImageView:UIView {
   
   var ContentArray: [[Contents]] = Array()
   var BackImageViewArray: [[BackTileImage]] = Array()

   override init(frame: CGRect) {
      let TileWide = frame.width / 10
      let Inter = TileWide / 10
      
      let ViewHeight = 12 * (TileWide + Inter)
      //もし　- TileWide / 2　をしないと，一番したのば画像がすれすれになるから，
      //画像の半分だけ上に上げてる。
      //もしここの部分を変更するなら，GetPiceposition.swfitにある
      //同じ部分も同様に変更する必要がある。
      let ViewStartY = frame.height - ViewHeight - TileWide / 2
      
      print("StartY = \(ViewStartY)")
      
      let Frame = CGRect(x: 0, y: ViewStartY, width: frame.width, height: ViewHeight)
      super.init(frame: Frame)
      
      InitBackTileImage()
   }
   
   func InitBackTileImage() {
      print("タイルの表示開始")
      for y in 0 ... 11 {
         for x in 0 ... 8 {
            let ImageView = BackTileImage(TilePosiY: CGFloat(y), TilePosiX: CGFloat(x), ViewX: self.frame.width, ViewY: self.frame.height, Content: Contents.Out)
            BackImageViewArray[x].append(ImageView)
            self.addSubview(ImageView)
         }
         //からの配列を追加することにより2次元配列として使える
         //これがなかったら Index out of rangeでエラー
         BackImageViewArray.append([])
      }
      print("タイルの表示完了")
   }
   
   public func GetContentArray(GetContentsArry: [[Contents]]) {
      ContentArray = GetContentsArry
   }
   
   public func ReSetUpBackTileImage() {
      print("タイルの表示開始")
      for y in 0 ... 11 {
         for x in 0 ... 8 {
            BackImageViewArray[x][y].removeFromSuperview()
            let ImageView = BackTileImage(TilePosiY: CGFloat(y), TilePosiX: CGFloat(x), ViewX: self.frame.width, ViewY: self.frame.height, Content: ContentArray[x][y])
            BackImageViewArray[x][y] = ImageView
            self.addSubview(ImageView)
         }
      }
      print("タイルの表示完了")
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
