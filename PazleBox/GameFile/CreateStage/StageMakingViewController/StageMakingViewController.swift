//
//  StageMakingViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/18.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import TapticEngine
import ChameleonFramework
import Firebase
import Hero
import SnapKit
import SCLAlertView

class StageMakingViewController: UIViewController{
   @IBOutlet weak var StageMakingButton: FUIButton!
   
   @IBOutlet weak var InfoLabel: UILabel!
   @IBOutlet weak var RemainingLabel: UILabel!
   
   @IBOutlet weak var StageMakingQuestionButton: UIButton!
   
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   let userDefaults = UserDefaults.standard
   
   let MaxRegiStageCount = 18
   var UsersRegiStageCount = 18
   
   var isLockButton = false
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   

   override func viewDidLoad() {
      super.viewDidLoad()
      self.hero.isEnabled = true
      
      InitViewSize()
      InitBackgroundImageView()
      
      InitUsersRegiStageCount()
      InitAccessibilityIdentifires()
      
      InitEachButton()
      InitInfoLabel()
      InitRemainingLabel()
      
      SNPStageMakingButton()
      SNPInfoLabel()
      SNPRemainingLabel()
      
      InitHeroID()
      
      //NOTE:- ここでボタンがタップできるかどうかを判断
      SetUpStageMakingButton()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      InitUsersRegiStageCount()
      InitInfoLabel()
      InitRemainingLabel()
      SetUpStageMakingButton()
   }
   
   //MARK:- 初期化
   private func InitViewSize() {
      ViewW = self.view.frame.width
      ViewH = self.view.frame.height
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func InitUsersRegiStageCount() {
      UsersRegiStageCount = userDefaults.integer(forKey: "CreateStageNum")
   }
   
   private func  InitAccessibilityIdentifires() {
     
   }

   
   private func InitEachButton() {
      InitButton(StageMakingButton)
      SetUpButtonColor()
      SetUpButtonPosition()
      SetUpButtonTitile()
      SetUpButtonAccessibilityIdentifier()
   }
   
   private func SetUpButtonPosition() {
      StageMakingButton.frame = CGRect(x: FViewW * 6, y: FViewH * 13.5, width: FViewW * 12, height: FViewH * 3)
   }
   
   private func SetUpButtonTitile() {
      StageMakingButton.setTitle(NSLocalizedString("StageCreate", comment: ""), for: .normal)
   }
   
   private func InitButton(_ sender: FUIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
      sender.buttonColor = UIColor.turquoise()
      sender.shadowColor = UIColor.greenSea()
      sender.shadowHeight = 3.0
      sender.cornerRadius = 6.0
      sender.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
   }
   
   private func SetUpButtonColor() {
      StageMakingButton.buttonColor = UIColor.flatTeal()
      StageMakingButton.shadowColor = UIColor.flatTealColorDark()
   }
   
   private func SetUpButtonAccessibilityIdentifier() {
      StageMakingButton.accessibilityIdentifier = "StageMakingButton"
   }
   
   
   private func InitInfoLabel() {
      let first = NSLocalizedString("CreateUpToFirst", comment: "")
      let Num = MaxRegiStageCount
      let NumStr = String(Num)
      let last = NSLocalizedString("CreateUpToLast", comment: "")
      let title = first + " " + NumStr + " " + last
      InfoLabel.text = title
      InfoLabel.alpha = 0.9
      InfoLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
      InfoLabel.adjustsFontSizeToFitWidth = true
      InfoLabel.textColor = UIColor.flatBlack()
      InfoLabel.textAlignment = .center
      InfoLabel.sizeToFit()
      InfoLabel.lineBreakMode = .byWordWrapping
      InfoLabel.center.x = StageMakingButton.center.x
   }
   
   private func InitRemainingLabel() {
      let first = NSLocalizedString("RemaingFirst", comment: "")
      let Num = MaxRegiStageCount - UsersRegiStageCount
      let NumStr = String(Num)
      let last = NSLocalizedString("RemaingLast", comment: "")
      let title = first + " " + NumStr + " " + last
      RemainingLabel.text = title
      RemainingLabel.alpha = 0.9
      RemainingLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
      RemainingLabel.adjustsFontSizeToFitWidth = true
      RemainingLabel.textColor = UIColor.flatBlack()
      RemainingLabel.textAlignment = .center
      RemainingLabel.sizeToFit()
      RemainingLabel.lineBreakMode = .byWordWrapping
      RemainingLabel.center.x = StageMakingButton.center.x
   }
   
   private func SNPStageMakingButton() {
      StageMakingButton!.snp.makeConstraints{ make in
         make.width.equalTo(FViewW * 12)
         make.height.equalTo(FViewH * 3)
         make.leading.equalTo(self.view.snp.leading).offset(FViewW * 6)
         make.top.equalTo(self.view.snp.top).offset(FViewH * 13.5)
      }
   }
   
   private func SNPInfoLabel() {
      InfoLabel!.snp.makeConstraints{ make in
         make.top.equalTo(StageMakingButton!.snp.bottom).offset(20)
         make.leading.equalTo(self.view.snp.leading).offset(20)
         make.trailing.equalTo(self.view.snp.trailing).offset(-20)
         make.height.equalTo(23)
      }
   }
   
   private func SNPRemainingLabel() {
      RemainingLabel!.snp.makeConstraints{ make in
         make.top.equalTo(InfoLabel!.snp.bottom).offset(5)
         make.leading.equalTo(self.view.snp.leading).offset(20)
         make.trailing.equalTo(self.view.snp.trailing).offset(-20)
         make.height.equalTo(23)
      }
   }
   
   private func SetUpStageMakingButton() {
      guard UsersRegiStageCount == MaxRegiStageCount else {
         print("まだ作れます。")
         return
      }
      
      print("これ以上ステージ増やせない。")
      print("ボタンのタップを無効にします。")
      self.StageMakingButton.isEnabled = false
   }
   
   private func InitHeroID() {
      StageMakingButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
      InfoLabel.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 6), y: 0, z: 0)]
      RemainingLabel.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 2), y: 0, z: 0)]
   }
   
   //MARK:- チュートリアルVCを開く
   private func showTutorialViewController() {
      print("Tutorialに遷移します。")
      StageMakingButton.hero.id = HeroID.MakingButton_Trash
      InfoLabel.hero.id = HeroID.InfoLabel_Option
      RemainingLabel.hero.id = HeroID.RemainingLabel_Label
      
      let Storybord = UIStoryboard(name: "TutorialViewController", bundle: nil)
      let TutorialVC = Storybord.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialViewController
      TutorialVC.modalPresentationStyle = .fullScreen
      TutorialVC.modalTransitionStyle = .crossDissolve
      self.present(TutorialVC, animated: true, completion: {
         print("TutorialVCにプレゼント終わった")
         self.isLockButton = false
      })
   }
   
   private func ShowAskUserShowTutorialViewControllerWhenTapTutorialButton() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      
      //TODO:- ローカライズ
      ComleateView.addButton(NSLocalizedString("Show Tutorial", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.showTutorialViewController()
         UserDefaults.standard.set(false, forKey: "FirstCreateStage")
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         UserDefaults.standard.set(false, forKey: "FirstCreateStage")
         self.isLockButton = false
      }
      let title = NSLocalizedString("ステージの作りかた", comment: "")
      let subTitle = NSLocalizedString("ステージを作るチュートリアルをしますか？", comment: "")
      ComleateView.showTitle(title, subTitle: subTitle, timeout: .none, completeText: nil, style: .question, colorStyle: 0x007AFF, colorTextButton: nil, circleIconImage: nil, animationStyle: .topToBottom)
   }
   
   
   /// 初めてステージを作ろうとした時に表示されるAleartView
   /// これの場合はCansel押された時にMakingVCを表示させている
   private func ShowAskUserShowTutorialViewControllerWhenUserFirstCreateStage() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      
      //TODO:- ローカライズ
      ComleateView.addButton(NSLocalizedString("Show Tutorial", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.showTutorialViewController()
         UserDefaults.standard.set(false, forKey: "FirstCreateStage")
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         UserDefaults.standard.set(false, forKey: "FirstCreateStage")
         self.isLockButton = false
      }
      let title = NSLocalizedString("初めてのステージつくり🎉", comment: "")
      let subTitle = NSLocalizedString("ステージを作るチュートリアルをしますか？", comment: "")
      ComleateView.showInfo(title, subTitle: subTitle)
   }
   
   private func CheckUserFirstCreatStage() -> Bool {
      if UserDefaults.standard.bool(forKey: "FirstCreateStage") == true {
         return true
      }
      return false
   }
   
   
   //MARK:- Stage Making　ボタンがタップされたときの処理
   @IBAction func TapStageMakingButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      GameSound.PlaySoundsTapButton()
      
      if CheckUserFirstCreatStage() == true {
         ShowAskUserShowTutorialViewControllerWhenUserFirstCreateStage()
         return
      }
      
      
      ShowStageMakingViewController()
   }
   
   //MARK:- Question　ボタンがタップされたときの処理
   @IBAction func TapStageMakingQuestionButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      self.GameSound.PlaySoundsTapButton()
      ShowAskUserShowTutorialViewControllerWhenTapTutorialButton()
   }
   
   //MARK:- Stage Making VCを開く
   private func ShowStageMakingViewController() {
      StageMakingButton.hero.id = HeroID.MakingButton_Trash
      InfoLabel.hero.id = HeroID.InfoLabel_Option
      RemainingLabel.hero.id = HeroID.RemainingLabel_Label
      
      Analytics.logEvent("TapMakingStageButton", parameters: nil)
      
      let CreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateStageVC") as! CleateStageViewController
      CreateStageVC.modalPresentationStyle = .fullScreen
      self.present(CreateStageVC, animated: true, completion: {
         print("CreateStageVCにプレゼント完了")
         self.isLockButton = false
      })
   }
   
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   private func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
}
