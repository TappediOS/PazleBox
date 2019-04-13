//
//  GameClearView.swift
//  PazleBox
//
//  Created by jun on 2019/03/31.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import Lottie
import UIKit
import FlatUIKit

class GameClearView: UIView {
   
   var StarView1 = AnimationView(name: "StarStar")
   var StarView2 = AnimationView(name: "StarStar")
   var StarView3 = AnimationView(name: "StarStar")
   
   var ConfView1 = AnimationView(name: "Confe")
   var ConfView2 = AnimationView(name: "Confe")
   var ConfView3 = AnimationView(name: "Confe")
   
   var StarViewWide: CGFloat = 1
   var StarViewIntarnal: CGFloat = 1
   
   var NextButton: FUIButton?
   var GoHomeButton: FUIButton?
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      self.isUserInteractionEnabled = true
      self.alpha = 0.05
      
      StarViewWide = frame.width / 4
      StarViewIntarnal = StarViewWide / 4
      
      ViewW = frame.width
      ViewH = frame.height
      
      IniiNextButton(frame: frame)
      InitGoHomeButton(frame: frame)
      
      InitStarView1()
      InitStarView2()
      InitStarView3()
      
      InitConfeView1()
      InitConfeView2()
      InitConfeView3()
      
      
   }
   
   
   @objc func TapNextButton (_ sender: UIButton) {
      print("Tap NextButton")

      NotificationCenter.default.post(name: .TapNext, object: nil, userInfo: nil)
   }
   
   @objc func TapGoHomeButton (_ sender: UIButton) {
      print("Tap GoHomeButton")
      
      NotificationCenter.default.post(name: .TapHome, object: nil, userInfo: nil)
      
   }

   
   private func IniiNextButton(frame: CGRect) {
      
      let StartX = ViewW / 16
      let StartY = ViewH / 5 * 2 + StarViewWide / 2
      
      let ButtonW = ViewW / 8 * 7
      let ButtonH = StarViewWide
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      
      
      NextButton = FUIButton(frame: Frame)
      
      NextButton!.setTitle("Next", for: UIControl.State.normal)
      NextButton!.buttonColor = UIColor.turquoise()
      NextButton!.shadowColor = UIColor.greenSea()
      NextButton!.shadowHeight = 3.0
      NextButton!.cornerRadius = 6.0
      NextButton!.titleLabel?.font = UIFont.boldFlatFont(ofSize: 50)
      NextButton!.titleLabel?.adjustsFontSizeToFitWidth = true
      NextButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      NextButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      NextButton!.addTarget(self, action: #selector(self.TapNextButton(_:)), for: UIControl.Event.touchUpInside)
   
      
      self.addSubview(NextButton!)
   }
   
   private func InitGoHomeButton(frame: CGRect) {
      let StartX = ViewW / 16
      let StartY = ViewH / 5 * 2 + StarViewWide / 2 + StarViewWide * 1.2
      
      let ButtonW = ViewW / 8 * 7
      let ButtonH = StarViewWide
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      
      
      GoHomeButton = FUIButton(frame: Frame)
      
      GoHomeButton!.setTitle("Go Home", for: UIControl.State.normal)
      GoHomeButton!.buttonColor = UIColor.turquoise()
      GoHomeButton!.shadowColor = UIColor.greenSea()
      GoHomeButton!.shadowHeight = 3.0
      GoHomeButton!.cornerRadius = 6.0
      GoHomeButton!.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      GoHomeButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      GoHomeButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      GoHomeButton!.addTarget(self, action: #selector(self.TapGoHomeButton(_:)), for: UIControl.Event.touchUpInside)
      
      self.addSubview(GoHomeButton!)
   }
   
   private func InitConfeView1() {

      let StartPosi = StarViewIntarnal * 3 + StarViewWide * 2
      let StartY = ViewH / 3
      
      ConfView1.frame = CGRect(x: StartPosi, y: StartY, width: ViewW, height: ViewW)
      ConfView1.center.x = ViewW / 4 * 3
      ConfView1.center.y = StartY
      ConfView1.contentMode = .scaleAspectFit
      ConfView1.animationSpeed = 0.6
      ConfView1.isUserInteractionEnabled = false
      self.addSubview(ConfView1)
 
   }
   
   private func InitConfeView2() {
      
      let StartPosi = StarViewIntarnal * 3 + StarViewWide * 2
      let StartY = ViewH / 8 * 7
      
      ConfView2.frame = CGRect(x: StartPosi, y: StartY, width: ViewW, height: ViewW)
      ConfView2.center.x = ViewW / 4 * 3
      ConfView2.center.y = StartY
      ConfView2.contentMode = .scaleAspectFit
      ConfView2.animationSpeed = 0.6
      ConfView2.isUserInteractionEnabled = false
      self.addSubview(ConfView2)
      
   }
   
   private func InitConfeView3() {
      
      let StartPosi = StarViewIntarnal
      let StartY = ViewH / 2
      
      ConfView3.frame = CGRect(x: StartPosi, y: StartY, width: ViewW, height: ViewW)
      ConfView3.center.x = ViewW / 4
      ConfView3.center.y = StartY
      ConfView3.contentMode = .scaleAspectFit
      ConfView3.animationSpeed = 0.6
      ConfView3.isUserInteractionEnabled = false
      self.addSubview(ConfView3)
      
   }
   
   private func InitStarView1() {
      
      let StartPosi = StarViewIntarnal
      let StartY = ViewH / 5 * 1
      
      StarView1.frame = CGRect(x: StartPosi, y: StartY, width: ViewW / 2, height: ViewW / 2)
      StarView1.center.x = ViewW / 4
      StarView1.center.y = StartY
      StarView1.contentMode = .scaleAspectFit
      StarView1.animationSpeed = 1
      StarView1.isUserInteractionEnabled = false
   }
   
   private func InitStarView2() {
      
      let StartPosi = StarViewIntarnal * 2 + StarViewWide
      let StartY = ViewH / 5 * 1 - StarViewWide / 2
      
      StarView2.frame = CGRect(x: StartPosi, y: StartY, width: ViewW / 2, height: ViewW / 2)
      StarView2.center.x = ViewW / 4  * 2
      StarView2.center.y = StartY
      StarView2.contentMode = .scaleAspectFit
      StarView2.animationSpeed = 1
      StarView2.isUserInteractionEnabled = false
   }
   
   private func InitStarView3() {
      
      let StartPosi = StarViewIntarnal * 3 + StarViewWide * 2
      let StartY = ViewH / 5 * 1
      
      StarView3.frame = CGRect(x: StartPosi, y: StartY, width: ViewW / 2, height: ViewW / 2)
      StarView3.center.x = ViewW / 4 * 3
      StarView3.center.y = StartY
      StarView3.contentMode = .scaleAspectFit
      StarView3.animationSpeed = 1
      StarView3.isUserInteractionEnabled = false
      

   }
   
   public func AddStarView1() {
      self.addSubview(StarView1)
      
      
   }
   
   public func AddStarView2() {
      self.addSubview(StarView2)
   }
   
   public func AddStarView3() {
      self.addSubview(StarView3)
   }
   
   public func StartAnimationView1() {
      StarView1.play()
   }
   
   public func StartAnimationView2() {
      StarView2.play()
   }
   
   public func StartAnimationView3() {
      StarView3.play()
   }
   
   public func StartConfe1() {
      ConfView1.play()
   }
   
   public func StartConfe2() {
      ConfView2.play()
   }
   
   public func StartConfe3() {
      ConfView3.play()
   }
   
   
   public func StartAnimation3() {
      StarView1.play() { (finished) in
         self.StarView2.play() { (finished) in
            self.StarView3.play()
         }
      }
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
