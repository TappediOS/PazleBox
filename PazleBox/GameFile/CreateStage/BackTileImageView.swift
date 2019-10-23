//
//  BackTileImageView.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class BackTileImageView: UIView {
   
   var ContentArray: [[Contents]] = Array()
   var BackImageViewArray: [[BackTileImage]] = Array()
   
   var ViewInter: CGFloat = 0

   override init(frame: CGRect) {
      let TileWide = frame.width / 10
      let Inter = TileWide / 10
      
      ViewInter = Inter
      
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
         //からの配列を追加することにより2次元配列として使える
         //これがなかったら Index out of rangeでエラー
         BackImageViewArray.append([])
         for x in 0 ... 8 {
            let ImageView = BackTileImage(TilePosiY: CGFloat(y), TilePosiX: CGFloat(x), ViewX: self.frame.width, ViewY: self.frame.height, Content: Contents.Out)
            ImageView.hero.modifiers = [.fade, .scale(0.45), .delay(Double(y * 10 + x) * 0.0042)]
            BackImageViewArray[y].append(ImageView)
            self.addSubview(ImageView)
         }
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
            BackImageViewArray[y][x].removeFromSuperview()
            let ImageView = BackTileImage(TilePosiY: CGFloat(y), TilePosiX: CGFloat(x), ViewX: self.frame.width, ViewY: self.frame.height, Content: ContentArray[y][x])
            BackImageViewArray[y][x] = ImageView
            ImageView.hero.modifiers = [.fade, .scale(0.45), .delay(Double(y * 10 + x) * 0.0042)]
            self.addSubview(ImageView)
         }
      }
      print("タイルの表示完了")
   }
   
   public func GetRectForScreenshot() -> CGRect {
      let StartY = self.frame.minY - ViewInter
      let Height = self.frame.height + ViewInter
      return CGRect(x: frame.minX, y: StartY, width: frame.width, height: Height)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
