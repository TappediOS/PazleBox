//
//  ExTutorialVCInit.swift
//  PazleBox
//
//  Created by jun on 2020/01/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit
import ChameleonFramework

extension TutorialViewController {
   func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   func InitBackTileImageView() {
      BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView!)
   }
    
   func GetStartBackImageViewY() {
      let TileWide = self.view.frame.width / 10
      let Inter = TileWide / 10
      let ViewHeight = 12 * (TileWide + Inter)
      StartBackImageViewY = self.view.frame.height - ViewHeight - TileWide / 2
      print("BackView開始のY座標は　\(StartBackImageViewY)")
   }
    
   func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(PiceUpPiceImageView(notification:)), name: .PickUpPiceImageView, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(MovedPiceCatchNotification(notification:)), name: .PiceMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchStartCatchNotification(notification:)), name: .PiceTouchStarted, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchMovedCatchNotification(notification:)), name: .PiceTouchMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchEndedCatchNotification(notification:)), name: .PiceTouchEnded, object: nil)
      
      NotificationCenter.default.addObserver(self, selector: #selector(ErrSentStageCatchNotification(notification:)), name: .ErrSentStageToFireStore, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(SuccessSentStagePiceTouchEndedCatchNotification(notification:)), name: .SuccessSentStageToFireStore, object: nil)
   }
    
   func InitFinishCreatePuzzleButton() {
      FinishCreatePuzzleButton = FUIButton(frame: CGRect(x: view.frame.width / 20 * 5, y: 150, width: view.frame.width / 20 * 5, height: 50))
      FinishCreatePuzzleButton?.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
      FinishCreatePuzzleButton?.addTarget(self, action: #selector(self.TapFinishiButton), for: .touchUpInside)
      FinishCreatePuzzleButton?.titleLabel?.adjustsFontSizeToFitWidth = true
      FinishCreatePuzzleButton?.titleLabel?.adjustsFontForContentSizeCategory = true
      FinishCreatePuzzleButton?.buttonColor = UIColor.flatLime()
      FinishCreatePuzzleButton?.shadowColor = UIColor.flatLimeColorDark()
      FinishCreatePuzzleButton?.shadowHeight = 3.0
      FinishCreatePuzzleButton?.cornerRadius = 6.0
      FinishCreatePuzzleButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      FinishCreatePuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      FinishCreatePuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      view.addSubview(FinishCreatePuzzleButton!)
   }
    
   func InitFinishChouseResPuzzleButton() {
      FinishChouseResPuzzleButton = FUIButton(frame: CGRect(x: view.frame.width / 20 * 5, y: 150, width: view.frame.width / 20 * 5, height: 50))
      FinishChouseResPuzzleButton?.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
      FinishChouseResPuzzleButton?.addTarget(self, action: #selector(self.TapFinChouseResPuzzleButton), for: .touchUpInside)
      FinishChouseResPuzzleButton?.titleLabel?.adjustsFontSizeToFitWidth = true
      FinishChouseResPuzzleButton?.titleLabel?.adjustsFontForContentSizeCategory = true
      FinishChouseResPuzzleButton?.buttonColor = UIColor.flatBlue()
      FinishChouseResPuzzleButton?.shadowColor = UIColor.flatBlueColorDark()
      FinishChouseResPuzzleButton?.shadowHeight = 3.0
      FinishChouseResPuzzleButton?.cornerRadius = 6.0
      FinishChouseResPuzzleButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      FinishChouseResPuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      FinishChouseResPuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      FinishChouseResPuzzleButton?.isHidden = true
      view.addSubview(FinishChouseResPuzzleButton!)
   }
    
   func InitTrashView() {
      TrashImageView.image = UIImage(named: "Trash_Black128.png")
      
      TrashImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CleateStageViewController.TapTrashView(_:))))
      TrashImageView.isUserInteractionEnabled = true
      view.addSubview(TrashImageView)
       
      TrashImageView.snp.makeConstraints{ make in
         make.height.equalTo(50)
         make.width.equalTo(50)
         make.trailing.equalTo(self.view.snp.trailing).offset(-8)
         if #available(iOS 11, *) {
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(7)
         } else {
            make.top.equalTo(self.view.snp.top).offset(7)
         }
      }
   }
    
   func InitOptionButton() {
      OptionButton.addTarget(self, action: #selector(self.TapOptionButton), for: .touchUpInside)
      let Image = UIImage(named: "Pouse.png")?.ResizeUIImage(width: 128, height: 128)
      OptionButton.setImage(Image, for: .normal)
      view.addSubview(OptionButton)
      OptionButton.isEnabled = false
   }
    
   func InitOnPiceView() {
      let Flame = CGRect(x: view.frame.width / 20, y: 50, width: view.frame.width / 25 * 23, height: 50)
      OnPiceView = UIView(frame: Flame)
      OnPiceView.backgroundColor = UIColor.flatWhite()
      OnPiceView.isHidden = true
      view.addSubview(OnPiceView)
   }
   
   func InitInfoLabel() {
      InfoLabel.adjustsFontSizeToFitWidth = true
      InfoLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
      InfoLabel.text = NSLocalizedString("SelectPice", comment: "")
      InfoLabel.textColor = UIColor.flatBlack()
      InfoLabel.numberOfLines = 0;
      InfoLabel.sizeToFit()
      InfoLabel.lineBreakMode = .byWordWrapping
      view.addSubview(InfoLabel)
   }
   
   func InitHeroID() {
      collectionView.hero.modifiers = [.cascade]
      
      TrashImageView.hero.id = HeroID.MakingButton_Trash
      FinishCreatePuzzleButton?.hero.modifiers = [.fade]
      InfoLabel.hero.id = HeroID.RemainingLabel_Label
      OptionButton.hero.id = HeroID.InfoLabel_Option
   }
   
   func InitAccessibilityIdentifires() {
      collectionView?.accessibilityIdentifier = "CleateStageVC_collectionView"
      TrashImageView.accessibilityIdentifier = "CleateStageVC_TrashImageView"
      FinishCreatePuzzleButton?.accessibilityIdentifier = "CleateStageVC_FinishCreatePuzzleButton"
      FinishChouseResPuzzleButton?.accessibilityIdentifier = "CleateStageVC_FinishChouseResPuzzleButton"
      InfoLabel.accessibilityIdentifier = "CleateStageVC_InfoLabel"
      OptionButton.accessibilityIdentifier = "CleateStageVC_OptionButton"
      BackImageView?.accessibilityIdentifier = "CleateStageVC_BackImageView"
   }
}
