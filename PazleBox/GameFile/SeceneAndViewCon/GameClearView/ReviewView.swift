//
//  ReviewView.swift
//  PazleBox
//
//  Created by jun on 2019/05/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import Hero
import TapticEngine

class ReviewView : UIView {
   
   
   var FirstHart: UIImageView?
   var SecontHart: UIImageView?
   var ThirdHart: UIImageView?
   var ForthHart: UIImageView?
   var FifthHart: UIImageView?
   
   var ReveiwLabel: UILabel?
   
   var FillHart = UIImage(named: "SellectReview.png")
   var NotFillHart = UIImage(named: "NotSellectReview.png")
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   
   var HartViewLength: CGFloat = 0
   var HartViweInter: CGFloat = 0
   
   var HartViewStartY: CGFloat = 0
   
   public var UserSellectReviewNum = 0
   
   let AniManager = AnimationTimeManager()
   let HeroID = HeroIDs()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   
      self.backgroundColor = UIColor.white.withAlphaComponent(0)
      
      InitViewSize()
      
      InitLabel()
      
      InitFirstHart()
      InitSecontHart()
      InitThirdHart()
      InitForthHart()
      InitFifthHart()
   }
   
   private func InitViewSize() {
      ViewW = self.frame.width
      ViewH = self.frame.height
      
      HartViewLength = ViewW / 6
      HartViweInter = HartViewLength / 6
      
      HartViewStartY = ViewH / 3
   }
   
   private func InitLabel() {
      
      let LabelFrame = CGRect(x: 0, y: 0, width: ViewW, height: ViewH / 3)
      
      ReveiwLabel = UILabel(frame: LabelFrame)
      ReveiwLabel?.text = NSLocalizedString("Stage review", comment: "")
      ReveiwLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 25)
      ReveiwLabel?.textAlignment = .center
      ReveiwLabel?.adjustsFontSizeToFitWidth = true
      ReveiwLabel?.adjustsFontForContentSizeCategory = true
      self.addSubview(ReveiwLabel!)
   }
   
   private func InitFirstHart() {
      FirstHart = UIImageView()
      FirstHart!.frame = CGRect(x: HartViweInter, y: HartViewStartY, width: HartViewLength, height: HartViewLength)
      FirstHart?.image = NotFillHart
      FirstHart!.backgroundColor = UIColor.white.withAlphaComponent(0)
      FirstHart!.isUserInteractionEnabled = true
      FirstHart!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TapFirstView(_:))))
      FirstHart?.hero.id = HeroID.ClearHart1ToHomeView
      self.addSubview(FirstHart!)
   }
   
   private func InitSecontHart() {
      SecontHart = UIImageView()
      SecontHart!.frame = CGRect(x: HartViweInter * 2 + HartViewLength, y: HartViewStartY, width: HartViewLength, height: HartViewLength)
      SecontHart?.image = NotFillHart
      SecontHart!.backgroundColor = UIColor.white.withAlphaComponent(0)
      SecontHart!.isUserInteractionEnabled = true
      SecontHart!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TapSecondView(_:))))
      SecontHart?.hero.id = HeroID.ClearHart2ToHomeView
      self.addSubview(SecontHart!)
   }
   
   private func InitThirdHart() {
      ThirdHart = UIImageView()
      ThirdHart!.frame = CGRect(x: HartViweInter * 3 + HartViewLength * 2, y: HartViewStartY, width: HartViewLength, height: HartViewLength)
      ThirdHart?.image = NotFillHart
      ThirdHart!.backgroundColor = UIColor.white.withAlphaComponent(0)
      ThirdHart!.isUserInteractionEnabled = true
      ThirdHart!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TapThirdView(_:))))
      ThirdHart?.hero.id = HeroID.ClearHart3ToHomeView
      self.addSubview(ThirdHart!)
   }
   
   private func InitForthHart() {
      ForthHart = UIImageView()
      ForthHart!.frame = CGRect(x: HartViweInter * 4 + HartViewLength * 3, y: HartViewStartY, width: HartViewLength, height: HartViewLength)
      ForthHart?.image = NotFillHart
      ForthHart!.backgroundColor = UIColor.white.withAlphaComponent(0)
      ForthHart!.isUserInteractionEnabled = true
      ForthHart!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TapForthView(_:))))
      ForthHart?.hero.id = HeroID.ClearHart4ToHomeView
      self.addSubview(ForthHart!)
   }
   
   private func InitFifthHart() {
      FifthHart = UIImageView()
      FifthHart!.frame = CGRect(x: HartViweInter * 5 + HartViewLength * 4, y: HartViewStartY, width: HartViewLength, height: HartViewLength)
      FifthHart?.image = NotFillHart
      FifthHart!.backgroundColor = UIColor.white.withAlphaComponent(0)
      FifthHart!.isUserInteractionEnabled = true
      FifthHart!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TapFifthView(_:))))
      self.addSubview(FifthHart!)
   }
   
   //MARK:- アニメーションスタート
   public func StartReviewViewAnimation() {
      ShowEachObjectForAnimation()
   
      ReveiwLabel?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.StageReviewLabelAnimationTime)
      FirstHart?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.HartAnimationTime1)
      SecontHart?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.HartAnimationTime2)
      ThirdHart?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.HartAnimationTime3)
      ForthHart?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.HartAnimationTime4)
      FifthHart?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.HartAnimationTime5)
   }
   
   //見えるようにする
   public func ShowEachObjectForAnimation(){
      ReveiwLabel!.isHidden = false
      FirstHart!.isHidden = false
      SecontHart!.isHidden = false
      ThirdHart!.isHidden = false
      ForthHart!.isHidden = false
      FifthHart!.isHidden = false
   }
   
   //見えないようにする。
   public func SetUpForAnimatiomToHideEachLabelAndImage() {
      ReveiwLabel!.isHidden = true
      FirstHart!.isHidden = true
      SecontHart!.isHidden = true
      ThirdHart!.isHidden = true
      ForthHart!.isHidden = true
      FifthHart!.isHidden = true
   }
   
   public func GetUserSellectReviewNum() -> Int {
      return self.UserSellectReviewNum
   }
   
   
   public func ResetReviewView() {
      self.UserSellectReviewNum = 0
      Change1NotHart()
      Change2NotHart()
      Change3NotHart()
      Change4NotHart()
      Change5NotHart()
   }
   
   
   
   private func Change1FillHart() { FirstHart?.image = FillHart }
   
   private func Change2FillHart() { SecontHart?.image = FillHart }
   
   private func Change3FillHart() { ThirdHart?.image = FillHart }
   
   private func Change4FillHart() { ForthHart?.image = FillHart }
   
   private func Change5FillHart() { FifthHart?.image = FillHart }
   
   private func Change1NotHart() { FirstHart?.image = NotFillHart }
   
   private func Change2NotHart() { SecontHart?.image = NotFillHart }
   
   private func Change3NotHart() { ThirdHart?.image = NotFillHart }
   
   private func Change4NotHart() { ForthHart?.image = NotFillHart }
   
   private func Change5NotHart() { FifthHart?.image = NotFillHart }
   
   @objc func TapFirstView(_ sender: UITapGestureRecognizer) {
      Play3DtouchLight()
      UserSellectReviewNum = 1
      Change1FillHart()
      
      Change2NotHart()
      Change3NotHart()
      Change4NotHart()
      Change5NotHart()
   }
   
   @objc func TapSecondView(_ sender: UITapGestureRecognizer) {
      Play3DtouchMedium()
      UserSellectReviewNum = 2
      Change1FillHart()
      Change2FillHart()
      
      Change3NotHart()
      Change4NotHart()
      Change5NotHart()
   }
   
   @objc func TapThirdView(_ sender: UITapGestureRecognizer) {
      Play3DtouchMedium()
      UserSellectReviewNum = 3
      Change1FillHart()
      Change2FillHart()
      Change3FillHart()
      
      Change4NotHart()
      Change5NotHart()
   }
   
   @objc func TapForthView(_ sender: UITapGestureRecognizer) {
      Play3DtouchHeavy()
      UserSellectReviewNum = 4
      Change1FillHart()
      Change2FillHart()
      Change3FillHart()
      Change4FillHart()
      
      Change5NotHart()
   }
   
   @objc func TapFifthView(_ sender: UITapGestureRecognizer) {
      Play3DtouchHeavy()
      UserSellectReviewNum = 5
      Change1FillHart()
      Change2FillHart()
      Change3FillHart()
      Change4FillHart()
      Change5FillHart()
   }
   
   private func Play3DtouchLight() {
      TapticEngine.impact.feedback(.light)
   }
   
   private func Play3DtouchMedium() {
      TapticEngine.impact.feedback(.medium)
   }
   
   private func Play3DtouchHeavy() {
      TapticEngine.impact.feedback(.heavy)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
