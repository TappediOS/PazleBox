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
import ViewAnimator
import Hero
import NVActivityIndicatorView

class GameClearView: UIView, GADBannerViewDelegate, UITextViewDelegate {
   
   var StarView1 = AnimationView(name: "StarStar")
   var StarView2 = AnimationView(name: "StarStar")
   var StarView3 = AnimationView(name: "StarStar")
   
   var KiraView1 = AnimationView(name: "KiraKira")
   var KiraView2 = AnimationView(name: "KiraKira")
   var KiraView3 = AnimationView(name: "KiraKira")
   
   var ConfView1 = AnimationView(name: "Confe")
   var ConfView2 = AnimationView(name: "Confe")
   var ConfView3 = AnimationView(name: "Confe")
   
   var ConfAniSpi: CGFloat = 1.3
   var KiraAniSpi: CGFloat = 1.245
   
   var StarViewWide: CGFloat = 1
   var StarViewIntarnal: CGFloat = 1
   
   //2こめのやつで何倍かできる!
   var ConfiViewSize: CGFloat?
   var ConfiViewSizeSet: CGFloat = 1.17
   
   var KiraViewSize: CGFloat?
   var KiraViewSizeSet: CGFloat = 1.45
   
   var NextButton: FUIButton?
   var GoHomeButton: FUIButton?
   
   var isLockedNextButton: Bool = false
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   
   //FoundViewWはVuewW / 8
   //FoundViewWは (VuewH - 55) / 8
   var FoundViewW: CGFloat = 0
   var FoundViewH: CGFloat = 0
   
   var GameClearLabel: UILabel?
   var CountOfNextADLabel : UILabel?
   var TapToCommentButton = UIButton()
   
   let NextADString = NSLocalizedString("UntilNextAd", comment: "")
   
   let GameClearBannerView = GADBannerView()
   let BannerViewReqest = GADRequest()
   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/4049149088"
   
   let GameSound = GameSounds()
   
   var ReviewedView: ReviewView?
   
   var NoAdButton: NoAdsButton?
   
   let AniManager = AnimationTimeManager()
   
   let HeroID = HeroIDs()
   var BackGroundImageView: BackGroundImageViews?
   
   var LoadActivityView: NVActivityIndicatorView?
   
   var CommentTextView = UITextView()
   var isRegisterComment = false
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      self.isUserInteractionEnabled = true
      self.alpha = 0.05
   
      InitViewSize()
      
      InitBackgroundImageView()
      InitNotificationCenter()
      
      InitReviewView(frame: frame)
      
      IniiNextButton(frame: frame)
      InitGoHomeButton(frame: frame)
      InitNoAdsButton(frame: frame)
      
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
      
      //ClearLabelの代わりに，コメントをつけるボタンを追加した
      //InitGameClearLabel()
      InitAddACommentButton()
      InitCountOfNextADLabel()
      InitCommentTextView()
      
      InitLoadActivityView(frame: frame)
      
      InitAllADCheck()
      
      SetUpForAnimatiomToHideEachViewAndButton()
   }
   
   private func InitViewSize() {
      StarViewWide = frame.width / 4
      StarViewIntarnal = StarViewWide / 4
      
      ViewW = frame.width
      ViewH = frame.height
      
      FoundViewH = (ViewH - 55) / 8
      FoundViewW = ViewW / 8
   }
   
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(CompleateBuyNoAdsInClearView(notification:)), name: .BuyNoAdsInClearView, object: nil)
   }
   
   //MARK:- バックグラウンドimage を設定
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.frame)
      self.addSubview(BackGroundImageView!)
      self.sendSubviewToBack(BackGroundImageView!)
   }
   
   //MARK:- 初期化
   //Clearってラベルは表示しない。
   private func InitGameClearLabel() {
      let StartX = ViewW / 16
      let StartY = ViewH / 5 * 2 - StarViewWide - 5
      let LabelW = ViewW / 8 * 7
      let LabelH = StarViewWide * 1.2
      
      let Frame = CGRect(x: StartX, y: StartY, width: LabelW, height: LabelH)
      
      GameClearLabel = UILabel(frame: Frame)
      GameClearLabel?.text = "Clear"
      GameClearLabel?.textColor = UIColor.flatBlack()
      GameClearLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 48)
      GameClearLabel?.textAlignment = .center
      GameClearLabel?.adjustsFontSizeToFitWidth = true
      GameClearLabel?.adjustsFontForContentSizeCategory = true
      GameClearLabel?.hero.id = HeroID.ClearLabelAndHomeViewLabel
      
      //self.addSubview(GameClearLabel!)
   }
   
   func InitAddACommentButton() {
      let ButtonW = ViewW / 6 * 4
      let ButtonH = StarViewWide * 0.5
      let startX = ViewW / 6
      let startY = ViewH / 5 * 2 - StarViewWide + ButtonH * 0.75
      
      let ButtonFrame = CGRect(x: startX, y: startY, width: ButtonW, height: ButtonH)
      
      TapToCommentButton = UIButton(frame: ButtonFrame)
      //TODO:- ローカライズすることp
      TapToCommentButton.setTitle("Add a Comment", for: .normal)
      TapToCommentButton.titleLabel?.adjustsFontSizeToFitWidth = true
      TapToCommentButton.layer.cornerRadius = ButtonFrame.height / 2
      TapToCommentButton.backgroundColor = .systemTeal
      TapToCommentButton.addTarget(self, action: #selector(self.TapAddACommentButton(sender:)), for: .touchUpInside)
      
      self.addSubview(TapToCommentButton)
   }
   
   //MARK:- コメントを書くボタンがタップされた
   @objc func TapAddACommentButton(sender: UIButton) {
      print("コメント追加ボタンタップされたよ")
      
      if isRegisterComment == true {
         print("既にコメントを登録しています")
         return
      }
      
      GameSound.PlaySoundsTapButton()
      // TextViewをViewに追加する.
      TapToCommentButton.isEnabled = false
      CommentTextView.isHidden = false
      self.CommentTextView.becomeFirstResponder()
      self.bringSubviewToFront(CommentTextView)
   }
   
   private func InitReviewView(frame: CGRect) {
      let ReviewViewFrame = CGRect(x: FoundViewW, y: FoundViewH * 3 + FoundViewH / 2, width: FoundViewW * 6, height: FoundViewH * 2)
      self.ReviewedView = ReviewView(frame: ReviewViewFrame)
      self.addSubview(ReviewedView!)
   }
   
   private func InitCommentTextView() {
      let StartX = ViewW / 7
      let StartY = ViewH / 5 * 2 - StarViewWide * 1.5
      let TextViewW = ViewW / 7 * 5
      let TextViewH = TextViewW * 0.6
      let Frame = CGRect(x: StartX, y: StartY, width: TextViewW, height: TextViewH)
      
      self.CommentTextView = UITextView(frame: Frame)
      self.CommentTextView.backgroundColor = .white
          
      // 角に丸みをつける.
      self.CommentTextView.layer.masksToBounds = true
      self.CommentTextView.layer.cornerRadius = 10   // 丸みのサイズ
      self.CommentTextView.layer.borderWidth = 1   // 枠線の太さ
      self.CommentTextView.layer.borderColor = UIColor.black.cgColor    // 枠線の色
      self.CommentTextView.font = UIFont(name: "HiraMaruProN-W4", size: 14)   // フォントの設定をする.
      self.CommentTextView.textColor = UIColor.black  // フォントの色の設定をする.
      self.CommentTextView.textAlignment = .left   // 左詰めの設定をする.
      self.CommentTextView.layer.shadowOpacity = 0.1  // 影の濃さを設定する.
      self.CommentTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
      self.CommentTextView.layer.shadowRadius = 10
      self.CommentTextView.layer.shadowColor = UIColor.black.cgColor
      
      self.CommentTextView.isEditable = true
      self.CommentTextView.isHidden = true
      
      let CommentInputAccessroryView = getInputAccessoryView()
      self.CommentTextView.inputAccessoryView = CommentInputAccessroryView
      self.CommentTextView.delegate = self
      
      self.addSubview(self.CommentTextView)
   }
   
   private func getInputAccessoryView() -> UIView {
      let InputAccessoryViewH: CGFloat = 50
      let InputAccessoryView = UIView()
      InputAccessoryView.frame.size.height = InputAccessoryViewH
      InputAccessoryView.backgroundColor = .secondarySystemBackground
      
      let CloseButton = UIButton(frame: CGRect(x: 4, y: 4, width: 50, height: 50 - 8))
      CloseButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
      CloseButton.imageView?.tintColor = .systemRed
      CloseButton.addTarget(self, action: #selector(TapCloseCommentTextView(_:)), for: .touchUpInside)
      
      let PaperPlaneButton = UIButton(frame: CGRect(x: ViewW - 50 - 4, y: 4, width: 50, height: 50 - 8))
      PaperPlaneButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
      PaperPlaneButton.imageView?.tintColor = .systemIndigo
      PaperPlaneButton.addTarget(self, action: #selector(TapSentCommentTextView(_:)), for: .touchUpInside)
      
      InputAccessoryView.addSubview(CloseButton)
      InputAccessoryView.addSubview(PaperPlaneButton)
      
      return InputAccessoryView
   }
   
   @objc func TapCloseCommentTextView(_ sender: UIButton) {
      print("コメントTextView閉じるボタンタップされたよ")
      CommentTextView.resignFirstResponder()
      CommentTextView.text = ""
      CommentTextView.isHidden = true
      TapToCommentButton.isEnabled = true
   }
   
   //MARK:- コメントTextView送るボタンタップされた
   @objc func TapSentCommentTextView(_ sender: UIButton) {
      print("コメントTextView送るボタンタップされたよ")
      let SentComment = CommentTextView.text ?? ""
      CommentTextView.resignFirstResponder()
      CommentTextView.isHidden = true
      TapToCommentButton.isEnabled = true
      
      if SentComment == "" {
         print("からコメントは送りません")
         return
      }
      
      print("\n---- 登録するコメント ----")
      print(SentComment)
      print("---- 登録するコメント ----\n")
      
      isRegisterComment = true
      //TODO:- ローカライズしてね。
      TapToCommentButton.setTitle("送信済み", for: .normal)
      TapToCommentButton.alpha = 0.85
   }
   
   //Ad Check
   private func InitAllADCheck() {
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         InitBannerView()
      }else{
         print("課金をしているので広告の初期化は行いません")
      }
   }
   
   
   
   private func InitCountOfNextADLabel() {
      let StartX = FoundViewW * 2
      let StartY = FoundViewH * 5
      
      let LabelW = FoundViewW * 4
      let LabelH = FoundViewH / 2
      
      let Frame = CGRect(x: StartX, y: StartY, width: LabelW, height: LabelH)
      
      CountOfNextADLabel = UILabel(frame: Frame)
      CountOfNextADLabel?.text = NSLocalizedString("UntilNextAd", comment: "")
      CountOfNextADLabel?.textColor = UIColor.flatWhiteColorDark()
      CountOfNextADLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 25)
      CountOfNextADLabel?.textAlignment = .center
      CountOfNextADLabel?.adjustsFontSizeToFitWidth = true
      CountOfNextADLabel?.adjustsFontForContentSizeCategory = true
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true{
         CountOfNextADLabel?.text = NSLocalizedString("AdNotFlow", comment: "")
      }
      
      self.addSubview(CountOfNextADLabel!)
   }
   
   public func SetCountOfNextADLabel(NextCount: Int) {
      
      if NextCount == 0 {
         self.CountOfNextADLabel?.text = NSLocalizedString("Ad Flo", comment: "")
         return
      }
      
      self.CountOfNextADLabel?.text = NextADString + String(NextCount)
   }
   
   private func InitBannerView() {
      #if DEBUG
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         self.GameClearBannerView.adUnitID = BANNER_VIEW_TEST_ID
         self.BannerViewReqest.testDevices = ["9d012329e337de42666c706e842b7819"];
         print("バナー広告：テスト環境\n\n")
      #else
         print("\n\n--------INFO ADMOB--------------\n")
         print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
         self.GameClearBannerView.adUnitID = BANNER_VIEW_ID
         print("バナー広告：本番環境")
      #endif
      
      //GameClearBannerView.backgroundColor = .black
      GameClearBannerView.frame = CGRect(x: 0, y: ViewH - 52.5, width: ViewW, height: 50)
      self.addSubview(GameClearBannerView)
      self.bringSubviewToFront(GameClearBannerView)
      
      GameClearBannerView.delegate = self
   }
   
   public func InitBannerViewGetRootViewController(SelfViewCon: UIViewController) {
      print("バナービューにルートビューつけた")
      self.GameClearBannerView.rootViewController = SelfViewCon
   }
   
   public func InitBannerViewRequest() {
      print("バナービューのロードを行います")
      GameClearBannerView.load(BannerViewReqest)
   }
   
   private func IniiNextButton(frame: CGRect) {
      let StartY = FoundViewH * 6
      let ButtonH = FoundViewH
      
      var StartX: CGFloat = 0
      var ButtonW: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         ButtonW = ViewW / 4
         StartX = ViewW / 16
      }else{
         ButtonW = FoundViewW * 3
         StartX = ViewW / 16
      }
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      
      
      NextButton = FUIButton(frame: Frame)
      
      NextButton!.setTitle(NSLocalizedString("Next", comment: ""), for: UIControl.State.normal)
      NextButton!.buttonColor = UIColor.turquoise()
      NextButton!.shadowColor = UIColor.greenSea()
      NextButton!.shadowHeight = 3.0
      NextButton!.cornerRadius = 6.0
      NextButton!.titleLabel?.adjustsFontSizeToFitWidth = true
      NextButton!.titleLabel?.font = UIFont.boldFlatFont(ofSize: 50)
      NextButton!.titleLabel?.adjustsFontSizeToFitWidth = true
      NextButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      NextButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      NextButton!.addTarget(self, action: #selector(self.TapNextButton(_:)), for: UIControl.Event.touchUpInside)
      NextButton!.isHidden = true
      NextButton!.hero.id = HeroID.BackEasyStage
      self.addSubview(NextButton!)
   }
   
   public func ChangeNextButtonNameForUsersGameClearView() {
      NextButton!.setTitle(NSLocalizedString("PlayAgain", comment: ""), for: UIControl.State.normal)
   }
   
   private func InitGoHomeButton(frame: CGRect) {
      var StartX: CGFloat = 0
      let StartY = FoundViewH * 6
      
      var ButtonW: CGFloat = 0
      let ButtonH = FoundViewH
      
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false{
         ButtonW = ViewW / 4
         StartX = ViewW / 16 + ViewW / 4 + ViewW / 16
      }else{
         ButtonW = FoundViewW * 3
         StartX = FoundViewW * 4.5
      }
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      
      
      GoHomeButton = FUIButton(frame: Frame)
      
      GoHomeButton!.setTitle(NSLocalizedString("Home", comment: ""), for: UIControl.State.normal)
      GoHomeButton!.buttonColor = UIColor.turquoise()
      GoHomeButton!.shadowColor = UIColor.greenSea()
      GoHomeButton!.shadowHeight = 3.0
      GoHomeButton!.cornerRadius = 6.0
      GoHomeButton!.titleLabel?.adjustsFontSizeToFitWidth = true
      GoHomeButton!.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      GoHomeButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      GoHomeButton!.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      GoHomeButton!.addTarget(self, action: #selector(self.TapGoHomeButton(_:)), for: UIControl.Event.touchUpInside)
      GoHomeButton!.isHidden = true
      GoHomeButton!.hero.id = HeroID.BackNormalStage
      self.addSubview(GoHomeButton!)
   }
   
   
   private func InitLoadActivityView(frame: CGRect) {
      let Viewsize = frame.width / 10
      let StartX = frame.width / 10 * 9 - Viewsize / 2
      let StartY = frame.height - 55 - Viewsize * 1.5
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.addSubview(LoadActivityView!)
   }
   
   //MARK:- ローディングアニメーション再生
   private func StartLoadingAnimation() {
      print("ローディングアニメーション再生")
      self.LoadActivityView?.startAnimating()
      return
   }
   
   public func StopLoadingAnimation() {
      if LoadActivityView?.isAnimating == true {
         self.LoadActivityView?.stopAnimating()
      }
   }
   
   //MARK:- アニメーションスタート
   public func StartClearViewAnimation() {
      ShowEachObjectForAnimation()

      //GameClearLabel?.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.ClearLabelAnimationTime)
      TapToCommentButton.animate(animations: [AniManager.BigToSmalAnimation], delay: AniManager.ClearLabelAnimationTime, completion:  {
         self.TapToCommentButton.isEnabled = true
      })
      ReviewedView!.StartReviewViewAnimation()
      CountOfNextADLabel?.animate(animations: [AniManager.SmalToBigAnimation], delay: AniManager.ADInfoLabelAnimationTime)
      GoHomeButton?.animate(animations: [AniManager.SmalToBigAnimation], delay: AniManager.HomeButtonAnimationTime, completion: {
         self.GoHomeButton?.isEnabled = true
      })
      NextButton?.animate(animations: [AniManager.SmalToBigAnimation], delay: AniManager.NextButtonAnimationTime, completion: {
         self.NextButton?.isEnabled = true
      })
      if let AdButton = NoAdButton {
         AdButton.animate(animations: [AniManager.SmalToBigAnimation], delay: AniManager.NoAdButtonAnimaitonTime, completion: {
            self.NoAdButton?.isEnabled = true
         })
      }
   }
   
   //
   private func ShowEachObjectForAnimation() {
      TapToCommentButton.isHidden = false
      //GameClearLabel!.isHidden = false
      ReviewedView!.ShowEachObjectForAnimation()
      CountOfNextADLabel!.isHidden = false
      GoHomeButton!.isHidden = false
      NextButton!.isHidden = false
      if let AdButton = NoAdButton {
         AdButton.isHidden = false
      }
   }
   
   //見えないようにする
   public func SetUpForAnimatiomToHideEachViewAndButton() {
      TapToCommentButton.isHidden = true
      //GameClearLabel!.isHidden = true
      ReviewedView!.SetUpForAnimatiomToHideEachLabelAndImage()
      CountOfNextADLabel!.isHidden = true
      GoHomeButton!.isHidden = true
      NextButton!.isHidden = true
      if let AdButton = NoAdButton {
         AdButton.isHidden = true
      }
      //touchでない
      TapToCommentButton.isEnabled = false
      GoHomeButton!.isEnabled = false
      NextButton!.isEnabled = false
      if let AdButton = NoAdButton {
         AdButton.isEnabled = false
      }
   }
   
   private func InitNoAdsButton(frame: CGRect) {
      guard UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false else{
         return
      }
      
      let StartX = ViewW / 16 + ViewW / 4 + ViewW / 16 + ViewW / 4 + ViewW / 16
      let StartY = FoundViewH * 6
      
      let ButtonW = ViewW / 4
      let ButtonH = FoundViewH
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      
      NoAdButton = NoAdsButton(frame: Frame)
      NoAdButton!.hero.id = HeroID.BackHardStage
      self.addSubview(NoAdButton!)
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
   
   //MARK:- 広告作フォした
   @objc func CompleateBuyNoAdsInClearView(notification: Notification) -> Void {
      if let NoAdsButton = NoAdButton {
         NoAdsButton.removeFromSuperview()
         CountOfNextADLabel?.text = NSLocalizedString("AdNotFlow", comment: "")
         ResetBextButtonPosi()
         ResetGoHomeButtonPosi()
         GameClearBannerView.removeFromSuperview()
      }
   }
   
   private func ResetBextButtonPosi() {
      let StartY = FoundViewH * 6
      let ButtonH = FoundViewH
      
      var StartX: CGFloat = 0
      var ButtonW: CGFloat = 0
      
      ButtonW = FoundViewW * 3
      StartX = ViewW / 16
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)

      NextButton?.frame = Frame
   }
   
   private func ResetGoHomeButtonPosi() {
      var StartX: CGFloat = 0
      let StartY = FoundViewH * 6
      
      var ButtonW: CGFloat = 0
      let ButtonH = FoundViewH
   
      ButtonW = FoundViewW * 3
      StartX = FoundViewW * 4.5
      
      let Frame = CGRect(x: StartX, y: StartY, width: ButtonW, height: ButtonH)
      GoHomeButton?.frame = Frame
   }
   
   
   //レビューしたハートの数の取得
   public func GetReView() -> Int { return ReviewedView!.GetUserSellectReviewNum() }
   
   //レビューのリセット
   public func ReSetReView() {
      self.ReviewedView!.ResetReviewView()
   }
   
   public func UnLockisLocedNextButton() {
      print("NextButtonがアンロックされました.")
      self.isLockedNextButton = false
   }
   
   //MARK:- タッチイベント開始
   @objc func TapNextButton (_ sender: UIButton) {
      print("Tap NextButton")
      guard isLockedNextButton == false else {
         print("ボタンはロックされています。")
         return
      }
      isLockedNextButton = true
      
      self.StartLoadingAnimation()
      self.Play3DtouchMedium()
      Analytics.logEvent("TapNextGameButton", parameters: nil)
      NotificationCenter.default.post(name: .TapNext, object: nil, userInfo: nil)
   }
   
   @objc func TapGoHomeButton (_ sender: UIButton) {
      print("Tap GoHomeButton")
      Play3DtouchMedium()
      Analytics.logEvent("TapGoHomeInClearView", parameters: nil)
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
      GameSound.PlaySoundsStarSound()
      Play3DtouchHeavy()
   }
   
   public func StartAnimationView2() {
      StarView2.play()
      KiraView2.play()
      GameSound.PlaySoundsStarSound()
      Play3DtouchHeavy()
   }
   
   public func StartAnimationView3() {
      StarView3.play()
      KiraView3.play()
      GameSound.PlaySoundsStarSound()
      Play3DtouchHeavy()
   }
   
   public func PlayGameClseraSounds() {
      GameSound.PlayGameClearSound()
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
