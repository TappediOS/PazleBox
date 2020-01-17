//
//  TutorialViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import TapticEngine
import FlatUIKit
import SnapKit
import SCLAlertView
import Firebase
import NVActivityIndicatorView

class TutorialViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
  
   var OnPiceView = UIView()
     
   var BackImageView: BackTileImageView?
     
   var FinishCreatePuzzleButton: FUIButton?
   var FinishChouseResPuzzleButton: FUIButton?
     
   var TrashImageView = UIImageView()
   var OptionButton = UIButton()
     
   var InfoLabel = UILabel()
     
     var StartBackImageViewY: CGFloat = 0
   
   var GreenFlame = CGRect()
   var RedFlame = CGRect()
   var BlueFlame = CGRect()
     
   var RedFlame1_1 = CGRect()
   var GreenFlame1_1 = CGRect()
   var BlueFlame1_1 = CGRect()
     
   var RedFlame2_3 = CGRect()
   var GreenFlame2_3 = CGRect()
   var BlueFlame2_3 = CGRect()
     
   var RedFlame3_2 = CGRect()
   var GreenFlame3_2 = CGRect()
   var BlueFlame3_2 = CGRect()
     
   var RedFlame4_3 = CGRect()
   var GreenFlame4_3 = CGRect()
   var BlueFlame4_3 = CGRect()
     
   var MochUserSellectedImageView = UIImageView()
     
   var WorkPlacePiceImageArray: [PiceImageView] = Array()
   var PiceImageArray: [PiceImageView] = Array()
   
   //Piceがかぶってないかをチェックする配列
   var CheckedStage: [[Contents]] = Array()
   let CleanCheckedStage = CleanCheckStage()
     
   var FillContentsArray: [[Contents]] = Array()
     
   var DontMoveNodeNum = 0
   var ShouldMoveNodeNum = 0
     
   //くるくる回るview
   var LoadActivityView: NVActivityIndicatorView?
     
     
   //いま対応してるのは，23,32,33,43,
   let photos = ["33p7Red", "33p21Blue","23p13Green","43p10Red","23p5Red",
   "23p14Green","43p19Red","33p34Red","23p12Green","23p11Red",
   "43p26Blue", "33p8Green","43p8Green","33p25Blue","33p28Green",
   "32p12Blue","32p3Red","43p32Blue","33p33Red","32p5Red",
   "33p3Blue", "33p23Green","43p21Green","43p26Blue","43p28Blue",
   "33p34Red","43p35Green","23p4Red","33p1Blue","32p13Green",
   "33p16Blue", "33p11Red","33p38Red","23p7Green","32p3Red",
   "43p34Blue","32p2Green","32p10Red","23p12Blue","43p14Green"]
     
   let sectionInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: -17)
   let itemsPerRow: CGFloat = 1 //Cellを横に何個入れるか
   
   var CanUseAreaHeight: CGFloat = 0
   
   var isLockColleViewANDTrashPice = false
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var BackGroundImageView: BackGroundImageViews?
   
   //MARK:- Piceがおける最大値
   let MaxCanPutPiceNum = 7
   var isMaxPutPice = false
        
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      InitBackgroundImageView()
      InitBackTileImageView()
      GetStartBackImageViewY()
      
      InitNotification()
      
      InitFinishCreatePuzzleButton()
      InitFinishChouseResPuzzleButton()
      InitTrashView()
      InitOptionButton()
      InitInfoLabel()
      
      InitLoadActivityView()
      
      InitOnPiceView()
      
      CrearCheckedStage()
      
      
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
      collectionView.delegate = self
      collectionView.dataSource = self
        
      collectionView.collectionViewLayout.invalidateLayout()
        
      collectionView.hero.modifiers = [.cascade]
      collectionView.backgroundColor = UIColor.flatWhite().withAlphaComponent(0.5)
        
      InitHeroID()
      InitAccessibilityIdentifires()
   }
     
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
        
      ReSetUpOnPiceView()
        
      SNPOptionButton()
      SNPFinishCreatePuzzleButton()
      SNPFinishChouseResPuzzleButton()
      SNPFInfoLabel()
        
      InitRedFlame1_1()
      InitGreenFlame1_1()
      InitBlueFlame1_1()
        
      InitRedFlame2_3()
      InitGreenFlame2_3()
      InitBlueFlame2_3()
        
      InitRedFlame3_2()
      InitGreenFlame3_2()
      InitBlueFlame3_2()
        
      InitRedFlame4_3()
      InitGreenFlame4_3()
      InitBlueFlame4_3()
   }
     
   override func viewDidAppear(_ animated: Bool) {
      
   }
     
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)

   }
}
