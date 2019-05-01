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
import TapticEngine
import Firebase


class GameClearView: UIView, GADBannerViewDelegate {
   
   var StarView1 = AnimationView(name: "StarStar")
   var StarView2 = AnimationView(name: "StarStar")
   var StarView3 = AnimationView(name: "StarStar")
   
   var KiraView1 = AnimationView(name: "KiraKira")
   var KiraView2 = AnimationView(name: "KiraKira")
   var KiraView3 = AnimationView(name: "KiraKira")
   
   var ConfView1 = AnimationView(name: "Confe")
   var ConfView2 = AnimationView(name: "Confe")
   var ConfView3 = AnimationView(name: "Confe")
   
   var ConfAniSpi: CGFloat = 1.02
   var KiraAniSpi: CGFloat = 1.2
   
   var StarViewWide: CGFloat = 1
   var StarViewIntarnal: CGFloat = 1
   
   //2こめのやつで何倍かできる!
   var ConfiViewSize: CGFloat?
   var ConfiViewSizeSet: CGFloat = 1.14
   
   var KiraViewSize: CGFloat?
   var KiraViewSizeSet: CGFloat = 1.34
   
   var NextButton: FUIButton?
   var GoHomeButton: FUIButton?
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   
   var GameClearLabel: UILabel?
   var CountOfNextADLabel : UILabel?
   
   let NextADString = "Until Next AD : "
   
   let GameClearBannerView = GADBannerView()
   let BannerViewReqest = GADRequest()
   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/4049149088"
   
   
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
      
      KiraViewSize = (ViewW / 2) * KiraViewSizeSet
      
      InitKiraView1()
      InitKiraView2()
      InitKiraView3()
      
      ConfiViewSize = ViewW * ConfiViewSizeSet
      
      InitConfeView1()
      InitConfeView2()
      InitConfeView3()
      
      InitGameClearLabel()
      InitCountOfNextADLabel()
      
      InitBannerView()
   }
   
   //MARK:- 初期化
   
   private func InitGameClearLabel() {
      
      let StartX = ViewW / 16
      let StartY = ViewH / 5 * 2 - StarViewWide
      
      let LabelW = ViewW / 8 * 7
      let LabelH = StarViewWide * 1.2
      
      let Frame = CGRect(x: StartX, y: StartY, width: LabelW, height: LabelH)
      
      GameClearLabel = UILabel(frame: Frame)
      GameClearLabel?.text = "Stage Clear"
      GameClearLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 100)
      GameClearLabel?.textAlignment = .center
      GameClearLabel?.adjustsFontSizeToFitWidth = true
      GameClearLabel?.adjustsFontForContentSizeCategory = true
      
      self.addSubview(GameClearLabel!)
   }
   
   private func InitCountOfNextADLabel() {
      let StartX = ViewW / 8
      let StartY = ViewH / 8 * 4
      
      let LabelW = ViewW / 4 * 3
      let LabelH = ViewH / 16
      
      let Frame = CGRect(x: StartX, y: StartY, width: LabelW, height: LabelH)
      
      CountOfNextADLabel = UILabel(frame: Frame)
      CountOfNextADLabel?.text = "Next AD: "
      CountOfNextADLabel?.textColor = UIColor.flatWhiteColorDark()
      CountOfNextADLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 25)
      CountOfNextADLabel?.textAlignment = .center
      CountOfNextADLabel?.adjustsFontSizeToFitWidth = true
      CountOfNextADLabel?.adjustsFontForContentSizeCategory = true
      
      self.addSubview(CountOfNextADLabel!)
   }
   
   public func SetCountOfNextADLabel(NextCount: Int) {
      
      if NextCount == 0 {
         self.CountOfNextADLabel?.text = "Ad Flow"
         return
      }
      
      self.CountOfNextADLabel?.text = NextADString + String(NextCount)
   }
   
   private func InitBannerView() {
      #if DEBUG
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         GameClearBannerView.adUnitID = BANNER_VIEW_ID
         BannerViewReqest.testDevices = ["9d012329e337de42666c706e842b7819"];
         print("バナー広告：テスト環境\n\n")
      #else
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         BannerView.adUnitID = BANNER_VIEW_ID
         print("バナー広告：本番環境")
      #endif
      
      //GameClearBannerView.backgroundColor = .black
      GameClearBannerView.frame = CGRect(x: 0, y: ViewH - 55, width: ViewW, height: 50)
      self.addSubview(GameClearBannerView)
      self.bringSubviewToFront(GameClearBannerView)
      
      GameClearBannerView.delegate = self
   }
   
   public func InitBannerViewGetRootViewController(SelfViewCon: UIViewController) {
      print("バナービューにルートビューつけた")
      self.GameClearBannerView.rootViewController = SelfViewCon
   }
   
   public func InitBannerViewRequest() {
      GameClearBannerView.load(BannerViewReqest)
   }
   
   private func IniiNextButton(frame: CGRect) {
      
      let StartX = ViewW / 8
      let StartY = ViewH / 8 * 4 + ViewH / 16
      
      let ButtonW = ViewW / 4 * 3
      let ButtonH = ViewH / 8
      
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
      let StartX = ViewW / 8
      let StartY = ViewH / 8 * 6
      
      
      let ButtonW = ViewW / 4 * 3
      let ButtonH = ViewH / 8
      
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
      
      ConfView1.frame = CGRect(x: StartPosi, y: StartY, width: ConfiViewSize!, height: ConfiViewSize!)
      ConfView1.center.x = GetConfiViewXPoint()
      ConfView1.center.y = GetConfiViewYPoint()
      ConfView1.contentMode = .scaleAspectFit
      ConfView1.animationSpeed = ConfAniSpi
      //ConfView1.loopMode = .loop
      ConfView1.isUserInteractionEnabled = false
   }
   
   private func InitConfeView2() {
      
      let StartPosi = StarViewIntarnal
      let StartY = ViewH / 2
      
      ConfView2.frame = CGRect(x: StartPosi, y: StartY, width: ConfiViewSize! , height: ConfiViewSize!)
      ConfView2.center.x = GetConfiViewXPoint()
      ConfView2.center.y = GetConfiViewYPoint()
      ConfView2.contentMode = .scaleAspectFit
      ConfView2.animationSpeed = ConfAniSpi
      //ConfView2.loopMode = .loop
      ConfView2.isUserInteractionEnabled = false
   }
   
   private func InitConfeView3() {
      
      let StartPosi = StarViewIntarnal * 3 + StarViewWide * 2
      let StartY = ViewH / 8 * 7
      
      ConfView3.frame = CGRect(x: StartPosi, y: StartY, width: ConfiViewSize!, height: ConfiViewSize!)
      ConfView3.center.x = GetConfiViewXPoint()
      ConfView3.center.y = GetConfiViewYPoint()
      ConfView3.contentMode = .scaleAspectFit
      ConfView3.animationSpeed = ConfAniSpi
      //ConfView3.loopMode = .loop
      ConfView3.isUserInteractionEnabled = false

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
   
   private func InitKiraView1() {
      
      let StartPosi = StarViewIntarnal
      let StartY = ViewH / 5 * 1
      
      KiraView1.frame = CGRect(x: StartPosi, y: StartY, width: KiraViewSize!, height: KiraViewSize!)
      KiraView1.center.x = ViewW / 4
      KiraView1.center.y = StartY
      KiraView1.contentMode = .scaleAspectFit
      KiraView1.animationSpeed = KiraAniSpi
      KiraView1.loopMode = .loop
      KiraView1.isUserInteractionEnabled = false
   }
   
   private func InitKiraView2() {
      
      let StartPosi = StarViewIntarnal * 2 + StarViewWide
      let StartY = ViewH / 5 * 1 - StarViewWide / 2
      
      KiraView2.frame = CGRect(x: StartPosi, y: StartY, width: KiraViewSize!, height: KiraViewSize!)
      KiraView2.center.x = ViewW / 4  * 2
      KiraView2.center.y = StartY
      KiraView2.contentMode = .scaleAspectFit
      KiraView2.animationSpeed = KiraAniSpi
      KiraView2.loopMode = .loop
      KiraView2.isUserInteractionEnabled = false
   }
   
   private func InitKiraView3() {
      
      let StartPosi = StarViewIntarnal * 3 + StarViewWide * 2
      let StartY = ViewH / 5 * 1
      
      KiraView3.frame = CGRect(x: StartPosi, y: StartY, width: KiraViewSize!, height: KiraViewSize!)
      KiraView3.center.x = ViewW / 4 * 3
      KiraView3.center.y = StartY
      KiraView3.contentMode = .scaleAspectFit
      KiraView3.animationSpeed = KiraAniSpi
      KiraView3.loopMode = .loop
      KiraView3.isUserInteractionEnabled = false
   }
   
   //MARK:- タッチイベント
   @objc func TapNextButton (_ sender: UIButton) {
      print("Tap NextButton")
      Play3DtouchMedium()
      NotificationCenter.default.post(name: .TapNext, object: nil, userInfo: nil)
   }
   
   @objc func TapGoHomeButton (_ sender: UIButton) {
      print("Tap GoHomeButton")
      Play3DtouchMedium()
      NotificationCenter.default.post(name: .TapHome, object: nil, userInfo: nil)
   }
   
   //MARK:- コンフィの座標取得
   private func GetConfiViewXPoint() -> CGFloat {
      return CGFloat.random(in: 0 ... ViewW)
   }
   private func GetConfiViewYPoint() -> CGFloat {
      return CGFloat.random(in: 0 ... ViewH)
   }
   
   //MARK:- AddSubView
   public func AddStarView1() {
      self.addSubview(StarView1)
   }
   
   public func AddStarView2() {
      self.addSubview(StarView2)
   }
   
   public func AddStarView3() {
      self.addSubview(StarView3)
   }
   
   public func AddKiraView1() {
      self.addSubview(KiraView1)
   }
   
   public func AddKiraView2() {
      self.addSubview(KiraView2)
   }
   
   public func AddKiraView3() {
      self.addSubview(KiraView3)
   }
   
   public func AddConfiView1() {
      self.addSubview(ConfView1)
   }
   
   public func AddConfiView2() {
      self.addSubview(ConfView2)
   }
   
   public func AddConfiView3() {
      self.addSubview(ConfView3)
   }
   
   //MARK:- スタートアニメーション
   public func StartAnimationView1() {
      StarView1.play()
      KiraView1.play()
      Play3DtouchHeavy()
   }
   
   public func StartAnimationView2() {
      StarView2.play()
      KiraView2.play()
      Play3DtouchHeavy()
   }
   
   public func StartAnimationView3() {
      StarView3.play()
      KiraView3.play()
      Play3DtouchHeavy()
   }
   
   
   public func StartConfe1() {
      ConfView1.play() { (finished) in
         self.ConfView1.center.x = self.GetConfiViewXPoint()
         self.ConfView1.center.y = self.GetConfiViewYPoint()
         //self.StartConfe1()
      }
   }
   
   public func StartConfe2() {
      ConfView2.play(){ (finished) in
         self.ConfView2.center.x = self.GetConfiViewXPoint()
         self.ConfView2.center.y = self.GetConfiViewYPoint()
         //self.StartConfe2()
      }
      
   }
   
   public func StartConfe3() {
      ConfView3.play(){ (finished) in
         self.ConfView3.center.x = self.GetConfiViewXPoint()
         self.ConfView3.center.y = self.GetConfiViewYPoint()
        // self.StartConfe3()
      }
   }
   
   public func StartAnimation3() {
      StarView1.play() { (finished) in
         self.StarView2.play() { (finished) in
            self.StarView3.play()
         }
      }
      
      KiraView1.play() { (finished) in
         self.KiraView2.play() { (finished) in
            self.KiraView3.play()
         }
      }
   }
   
   //MARK:- ストップアニメーション
   public func StopConfi() {
      self.ConfView1.stop()
      self.ConfView2.stop()
      self.ConfView3.stop()
   }
   
   public func StopStar() {
      self.StarView1.stop()
      self.KiraView1.stop()
      self.StarView2.stop()
      self.KiraView2.stop()
      self.StarView3.stop()
      self.KiraView3.stop()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
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
   
   
   
   
   
   //MARK:- ADMOB
   /// Tells the delegate an ad request loaded an ad.
   func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("広告(banner)のロードが完了しました。")
   }
   
   /// Tells the delegate an ad request failed.
   func adView(_ bannerView: GADBannerView,
               didFailToReceiveAdWithError error: GADRequestError) {
      print("広告(banner)のロードに失敗しました。: \(error.localizedDescription)")
   }
   
   /// Tells the delegate that a full-screen view will be presented in response
   /// to the user clicking on an ad.
   func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
   }
   
   /// Tells the delegate that the full-screen view will be dismissed.
   func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
   }
   
   /// Tells the delegate that the full-screen view has been dismissed.
   func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
   }
   
   /// Tells the delegate that a user click will open another app (such as
   /// the App Store), backgrounding the current app.
   func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
   }
}
