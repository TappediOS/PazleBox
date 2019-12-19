//
//  CreateHomeViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FlatUIKit
import TapticEngine
import Firebase

class CreateHomeViewController: UIViewController {
   
   @IBOutlet weak var SellectStageButton: FUIButton!
   @IBOutlet weak var StageAuthCreateButton: FUIButton!
   @IBOutlet weak var BackHomeButton: FUIButton!
   @IBOutlet weak var InternetUsersStageButton: FUIButton!
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var isLockButton = false
      
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      InitViewSize()
      InitBackgroundImageView()
      InitEachButton()
      
      InitHeroID()
      InitAccessibilityIdentifires()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      InitHeroID()
   }
  
   //MARK:- 初期化
   private func InitViewSize() {
      ViewW = self.view.frame.width
      ViewH = self.view.frame.height
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   
   private func  InitAccessibilityIdentifires() {
      SellectStageButton?.accessibilityIdentifier = "CreateHomeVC_SellectStageButton"
      StageAuthCreateButton?.accessibilityIdentifier = "CreateHomeVC_StageAuthCreateButton"
      BackHomeButton?.accessibilityIdentifier = "CreateHomeVC_BackHomeButton"
      InternetUsersStageButton?.accessibilityIdentifier = "CreateHomeVC_InternetUsersStageButton"
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func InitEachButton() {
      InitButton(SellectStageButton)
      InitButton(StageAuthCreateButton)
      InitButton(InternetUsersStageButton)
      InitButton(BackHomeButton)
      SetUpButtonColor()
      SetUpButtonPosition()
      SetUpButtonTitile()
   }
   
   private func SetUpButtonTitile() {
      StageAuthCreateButton.setTitle(NSLocalizedString("StageCreatormade", comment: ""), for: .normal)
      SellectStageButton.setTitle(NSLocalizedString("StageYouMade", comment: ""), for: .normal)
      InternetUsersStageButton.setTitle(NSLocalizedString("StageInTheWorld", comment: ""), for: .normal)
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
      SellectStageButton.buttonColor = UIColor.flatPlum()
      SellectStageButton.shadowColor = UIColor.flatPlumColorDark()
      StageAuthCreateButton.buttonColor = UIColor.flatTeal()
      StageAuthCreateButton.shadowColor = UIColor.flatTealColorDark()
      InternetUsersStageButton.buttonColor = UIColor.flatOrange()
      InternetUsersStageButton.shadowColor = UIColor.flatOrangeColorDark()
      BackHomeButton.buttonColor = UIColor.flatMaroonColorDark()
      BackHomeButton.shadowColor = UIColor.flatMaroonColorDark()
   }
   
   private func SetUpButtonPosition() {

      SellectStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      InternetUsersStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      StageAuthCreateButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
      
      BackHomeButton.frame = CGRect(x: FViewW * 1, y: FViewH * 2.5, width: FViewW * 5, height: FViewH * 3 / 2)
   }
   
   
   private func InitHeroID() {
      BackHomeButton.hero.id = HeroID.TopTitleAndCreateBack
      StageAuthCreateButton.hero.id = HeroID.TopPlayAndCreateCreate
      SellectStageButton.hero.id = HeroID.TopCreateAndCreateFinCreate
      StageAuthCreateButton.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 6), y: 0, z: 0)]
      SellectStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 2), y: 0, z: 0)]
      InternetUsersStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
   }
   
   //MARK:-　各ボタンをタップした時の動作
   @IBAction func TapStageAuthCreateButton(_ sender: FUIButton) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      
      GameSound.PlaySoundsTapButton()
      StageAuthCreateButton?.hero.id = HeroID.CreateCreateAndCreatingTrash
      SellectStageButton?.hero.id = HeroID.CreateFinCreateAndCreatingOption
      InternetUsersStageButton?.hero.id = HeroID.CreateInternetAndCreatingInfoLabel
      BackHomeButton?.hero.id = HeroID.CreateBackAndCreatingFinButton
      
      Analytics.logEvent("TapStageAuthCreateButton", parameters: nil)
      
      let Storybord = UIStoryboard(name: "Main", bundle: nil)
      let HomeVC = Storybord.instantiateViewController(withIdentifier: "HomeView")
      HomeVC.modalPresentationStyle = .fullScreen

      self.present(HomeVC, animated: true, completion: {
         print("Home VCにプレゼント完了")
         self.isLockButton = false
      })
   }
   
   
   @IBAction func TapSellectStageButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      GameSound.PlaySoundsTapButton()
      SellectStageButton.hero.id = HeroID.CreateFinCreateAndSellectBack
      
      Analytics.logEvent("TapSellectStageButton", parameters: nil)
      
      let SellectCreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "SellectCreateStageVC") as! SellectCreateStageViewController
      SellectCreateStageVC.modalPresentationStyle = .fullScreen
      self.present(SellectCreateStageVC, animated: true, completion: {
         print("SellectCreateStageVCにプレゼント完了")
         self.isLockButton = false
      })
   }
   
   @IBAction func TapInterNetButton(_ sender: Any) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      GameSound.PlaySoundsTapButton()
      SellectStageButton.hero.id = HeroID.CreateFinCreateAndSellectBack
      
      Analytics.logEvent("TapSellectStageButton", parameters: nil)
      
      let SellectCreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "SellectIntarnetStageVC") as! SellectInternetStageViewController
      SellectCreateStageVC.modalPresentationStyle = .fullScreen
      self.present(SellectCreateStageVC, animated: true, completion: {
         print("SellectIntarnetStageVCにプレゼント完了")
         self.isLockButton = false
      })
   }
   
   
   @IBAction func TapBackButton(_ sender: Any) {
      BackHomeButton.hero.id = HeroID.TopTitleAndCreateBack
      StageAuthCreateButton.hero.id = HeroID.TopPlayAndCreateCreate
      SellectStageButton.hero.id = HeroID.TopCreateAndCreateFinCreate
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      dismiss(animated: true, completion: nil)
   }
   
   //   //COMING SOON LABELの初期化　使ってない。けどまた使うかもしれないから残しとく。
   //   //消すべきであるとは思う。
   //   private func InitComminSoonLabel() {
   //      CominSoonLabel = UILabel(frame: CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3))
   //      CominSoonLabel.text = "Coming Soon"
   //      CominSoonLabel.alpha = 0.9
   //      CominSoonLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
   //      CominSoonLabel.adjustsFontSizeToFitWidth = true
   //      CominSoonLabel.textColor = UIColor.flatBlack()
   //      CominSoonLabel.textAlignment = .center
   //      CominSoonLabel.sizeToFit()
   //      CominSoonLabel.lineBreakMode = .byWordWrapping
   //      CominSoonLabel.center.x = InternetUsersStageButton.center.x
   //      view.addSubview(CominSoonLabel)
   //   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   private func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
}
