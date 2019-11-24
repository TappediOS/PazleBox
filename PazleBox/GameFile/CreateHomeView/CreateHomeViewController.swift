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
   @IBOutlet weak var CreateStageButton: FUIButton!
   @IBOutlet weak var BackHomeButton: FUIButton!
   @IBOutlet weak var InternetUsersStageButton: FUIButton!
   
   var CominSoonLabel = UILabel()
   
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var isLockButton = false
   
   var handle: AuthStateDidChangeListenerHandle?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      InitViewSize()
      InitBackgroundImageView()
      InitEachButton()
      
      InitComminSoonLabel()
      
      InitHeroID()
      InitAccessibilityIdentifires()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      InitHeroID()
   }
  
   
   private func InitViewSize() {
      ViewW = self.view.frame.width
      ViewH = self.view.frame.height
      FViewW = ViewW / 25
      FViewH = ViewH / 32
   }
   
   private func  InitAccessibilityIdentifires() {
      SellectStageButton?.accessibilityIdentifier = "CreateHomeVC_SellectStageButton"
      CreateStageButton?.accessibilityIdentifier = "CreateHomeVC_CreateStageButton"
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
      InitButton(CreateStageButton)
      InitButton(InternetUsersStageButton)
      InitButton(BackHomeButton)
      InternetUsersStageButton.alpha = 0.385
      SetUpButtonColor()
      SetUpButtonPosition()
      SetUpButtonTitile()
   }
   
   private func SetUpButtonTitile() {
      CreateStageButton.setTitle(NSLocalizedString("Create", comment: ""), for: .normal)
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
   
   private func InitComminSoonLabel() {
      CominSoonLabel = UILabel(frame: CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3))
      CominSoonLabel.text = "Coming Soon"
      CominSoonLabel.alpha = 0.9
      CominSoonLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
      CominSoonLabel.adjustsFontSizeToFitWidth = true
      CominSoonLabel.textColor = UIColor.flatBlack()
      CominSoonLabel.textAlignment = .center
      CominSoonLabel.sizeToFit()
      CominSoonLabel.lineBreakMode = .byWordWrapping
      CominSoonLabel.center.x = InternetUsersStageButton.center.x
      view.addSubview(CominSoonLabel)
   }
   
   private func SetUpButtonColor() {
      SellectStageButton.buttonColor = UIColor.flatPlum()
      SellectStageButton.shadowColor = UIColor.flatPlumColorDark()
      CreateStageButton.buttonColor = UIColor.flatTeal()
      CreateStageButton.shadowColor = UIColor.flatTealColorDark()
      InternetUsersStageButton.buttonColor = UIColor.flatOrange()
      InternetUsersStageButton.shadowColor = UIColor.flatOrangeColorDark()
      BackHomeButton.buttonColor = UIColor.flatMaroonColorDark()
      BackHomeButton.shadowColor = UIColor.flatMaroonColorDark()
   }
   
   private func SetUpButtonPosition() {
      SellectStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      CreateStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      InternetUsersStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
      BackHomeButton.frame = CGRect(x: FViewW * 1, y: FViewH * 2.5, width: FViewW * 5, height: FViewH * 3 / 2)
   }
   
   
   private func InitHeroID() {
      BackHomeButton.hero.id = HeroID.TopTitleAndCreateBack
      CreateStageButton.hero.id = HeroID.TopPlayAndCreateCreate
      SellectStageButton.hero.id = HeroID.TopCreateAndCreateFinCreate
      CreateStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW - FViewW * 6), y: 0, z: 0)]
      SellectStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 2), y: 0, z: 0)]
      InternetUsersStageButton.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
      CominSoonLabel.hero.modifiers = [.arc(), .translate(x: +(ViewW + FViewW * 11), y: 0, z: 0)]
   }
   
   
   @IBAction func TapCreateButton(_ sender: FUIButton) {
      Play3DtouchLight()
      if isLockButton == true { return }
      isLockButton = true
      
      GameSound.PlaySoundsTapButton()
      CreateStageButton?.hero.id = HeroID.CreateCreateAndCreatingTrash
      SellectStageButton?.hero.id = HeroID.CreateFinCreateAndCreatingOption
      InternetUsersStageButton?.hero.id = HeroID.CreateInternetAndCreatingInfoLabel
      BackHomeButton?.hero.id = HeroID.CreateBackAndCreatingFinButton
      
      Analytics.logEvent("TapCreateButton", parameters: nil)
      
      let CreateStageVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateStageVC") as! CleateStageViewController
      CreateStageVC.modalPresentationStyle = .fullScreen
      self.present(CreateStageVC, animated: true, completion: {
         print("CreateStageVCにプレゼント完了")
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
      Play3DtouchError()
      GameSound.PlaySoundsTapButton()
      return
   }
   
   
   @IBAction func TapBackButton(_ sender: Any) {
      BackHomeButton.hero.id = HeroID.TopTitleAndCreateBack
      CreateStageButton.hero.id = HeroID.TopPlayAndCreateCreate
      SellectStageButton.hero.id = HeroID.TopCreateAndCreateFinCreate
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      dismiss(animated: true, completion: nil)
   }
   
   private func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   private func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   private func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   private func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
}
