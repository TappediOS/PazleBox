//
//  ShoppingPiceViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


enum PiceSetNum {
   case set1
   case set2
   case set3
   case set4
}


class ShoppingPiceViewController: UIViewController {
   var BackGroundImageView: BackGroundImageViews?
   
   
   @IBOutlet weak var PiceSetOneButton: UIButton!
   @IBOutlet weak var PiceSetTwoButton: UIButton!
   @IBOutlet weak var PiceSetThreeButton: UIButton!
   @IBOutlet weak var PiceSetFourButton: UIButton!
   
   let PiceOneImageViewLeft23 = UIImageView()
   let PiceOneImageViewRight23 = UIImageView()
   
   let PiceTwoImageViewLeft33 = UIImageView()
   let PiceTwoImageViewRight33 = UIImageView()
   
   let PiceThreeImageViewLeft33 = UIImageView()
   let PiceThreeImageViewRight33 = UIImageView()
   
   let PiceFourImageViewLeft43 = UIImageView()
   let PiceFourImageViewRight43 = UIImageView()
   
   let PiceImageMargin = 12
   let PiceBaseWidth = 50
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationBar()
      InitBackgroundImageView()
      
      SetUpPiceSetOneButton()
      SetUpPiceSetTwoButton()
      SetUpPiceSetThreeButton()
      SetUpPiceSetFourButton()
      
      ButtonSetUp(button: PiceSetOneButton)
      ButtonSetUp(button: PiceSetTwoButton)
      ButtonSetUp(button: PiceSetThreeButton)
      ButtonSetUp(button: PiceSetFourButton)
      
      SetUpPiceImageViewImage()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      NSPPiceOneImageView()
      NSPPiceTwoImageView()
      NSPPiceThreeImageView()
      NSPPiceFourImageView()
      
   }
   
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("PiceShop", comment: "")
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   private func SetUpPiceSetOneButton() {
      let title = NSLocalizedString("PiceSet", comment: "") + "1"
      PiceSetOneButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetTwoButton() {
      let title = NSLocalizedString("PiceSet", comment: "") + "2"
      PiceSetTwoButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetThreeButton() {
      let title = NSLocalizedString("PiceSet", comment: "") + "3"
      PiceSetThreeButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetFourButton() {
      let title = NSLocalizedString("PiceSet", comment: "") + "4"
      PiceSetFourButton.setTitle(title, for: .normal)
      
   }
   
   private func ButtonSetUp(button: UIButton) {
      button.backgroundColor = .white
      button.layer.cornerRadius = 7
      button.layer.borderWidth = 0.75
      button.layer.borderColor = UIColor.black.cgColor
      
      button.layer.shadowOpacity = 0.4
      button.layer.shadowRadius = 1.85
      button.layer.shadowColor = UIColor.black.cgColor
      button.layer.shadowOffset = CGSize(width: 2, height: 2)
      
      button.titleLabel?.adjustsFontSizeToFitWidth = true
      button.titleLabel?.minimumScaleFactor = 0.8
      
      let font = UIFont(name: "Helvetica", size: 22)
      button.titleLabel?.font = font
      button.setTitleColor(.black, for: .normal)
   }
   
   private func getImageRandomNameFromArray(NameArray: [String], ColorArray: [String], PiceSet: PiceSetNum) -> String {
      guard let randomName = NameArray.randomElement(), let randomColor = ColorArray.randomElement() else {
         switch PiceSet {
         case .set1:
            return "23p4Blue"
         case .set2:
            return "33p44Green"
         case .set3:
            return "33p29Red"
         case .set4:
            return "43p27Green"
         }
      }
      return randomName + randomColor
   }
   
   private func SetUpPiceImageViewImage() {
      let PiceSet1ImageNames = ["23p1", "23p4", "23p6", "23p8", "23p9", "23p10", "23p14"]
      let PiceSet2ImageNames = ["33p44", "33p43", "33p27", "33p8", "33p10", "33p13", "33p22"]
      let PiceSet3ImageNames = ["33p29", "33p30", "33p31", "33p32", "33p33", "33p34", "33p35", "33p36", "33p38"]
      let PiceSet4ImageNames = ["43p27", "43p28", "43p29", "43p30", "43p31", "43p32", "43p33", "43p34", "43p35", "43p36", "43p37", "43p38" ,"43p39"]
      let PiceSetColors      = ["Red", "Green", "Blue"]
      
      let PiceOneImageLImageName   = getImageRandomNameFromArray(NameArray: PiceSet1ImageNames, ColorArray: PiceSetColors, PiceSet: .set1)
      let PiceOneImageRmageName    = getImageRandomNameFromArray(NameArray: PiceSet1ImageNames, ColorArray: PiceSetColors, PiceSet: .set1)
      let PiceTwoImageLImageName   = getImageRandomNameFromArray(NameArray: PiceSet2ImageNames, ColorArray: PiceSetColors, PiceSet: .set2)
      let PiceTwoImageRImageName   = getImageRandomNameFromArray(NameArray: PiceSet2ImageNames, ColorArray: PiceSetColors, PiceSet: .set2)
      let PiceThreeImageLImageName = getImageRandomNameFromArray(NameArray: PiceSet3ImageNames, ColorArray: PiceSetColors, PiceSet: .set3)
      let PiceThreeImageRImageName = getImageRandomNameFromArray(NameArray: PiceSet3ImageNames, ColorArray: PiceSetColors, PiceSet: .set3)
      let PiceFourImageLImageName  = getImageRandomNameFromArray(NameArray: PiceSet4ImageNames, ColorArray: PiceSetColors, PiceSet: .set4)
      let PiceFourImageRImageName  = getImageRandomNameFromArray(NameArray: PiceSet4ImageNames, ColorArray: PiceSetColors, PiceSet: .set4)
      
      let PiceOneImageL   = UIImage(named: PiceOneImageLImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceOneImageR   = UIImage(named: PiceOneImageRmageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceTowImageL   = UIImage(named: PiceTwoImageLImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceTowImageR   = UIImage(named: PiceTwoImageRImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceThreeImageL = UIImage(named: PiceThreeImageLImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceThreeImageR = UIImage(named: PiceThreeImageRImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceFourImageL  = UIImage(named: PiceFourImageLImageName)?.ResizeUIImage(width: 124, height: 124)
      let PiceFourImageR  = UIImage(named: PiceFourImageRImageName)?.ResizeUIImage(width: 124, height: 124)
      
      
      PiceOneImageViewLeft23.image    = PiceOneImageL
      PiceOneImageViewRight23.image   = PiceOneImageR
      PiceTwoImageViewLeft33.image    = PiceTowImageL
      PiceTwoImageViewRight33.image   = PiceTowImageR
      PiceThreeImageViewLeft33.image  = PiceThreeImageL
      PiceThreeImageViewRight33.image = PiceThreeImageR
      PiceFourImageViewLeft43.image   = PiceFourImageL
      PiceFourImageViewRight43.image  = PiceFourImageR
      
      
      self.PiceSetOneButton.addSubview(PiceOneImageViewLeft23)
      self.PiceSetOneButton.addSubview(PiceOneImageViewRight23)
      self.PiceSetTwoButton.addSubview(PiceTwoImageViewLeft33)
      self.PiceSetTwoButton.addSubview(PiceTwoImageViewRight33)
      self.PiceSetThreeButton.addSubview(PiceThreeImageViewLeft33)
      self.PiceSetThreeButton.addSubview(PiceThreeImageViewRight33)
      self.PiceSetFourButton.addSubview(PiceFourImageViewLeft43)
      self.PiceSetFourButton.addSubview(PiceFourImageViewRight43)
   }
   
   private func NSPPiceOneImageView() {
      self.PiceOneImageViewLeft23.snp.makeConstraints { make in
         make.leading.equalTo(PiceSetOneButton.snp.leading).offset(PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth * 3 / 2)
         make.centerY.equalTo(PiceSetOneButton.snp.centerY)
      }
      
      self.PiceOneImageViewRight23.snp.makeConstraints { make in
         make.trailing.equalTo(PiceSetOneButton.snp.trailing).offset(-PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth * 3 / 2)
         make.centerY.equalTo(PiceSetOneButton.snp.centerY)
      }
   }
   
   
   private func NSPPiceTwoImageView() {
      self.PiceTwoImageViewLeft33.snp.makeConstraints { make in
         make.leading.equalTo(PiceSetTwoButton.snp.leading).offset(PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth)
         make.centerY.equalTo(PiceSetTwoButton.snp.centerY)
      }
      
      self.PiceTwoImageViewRight33.snp.makeConstraints { make in
         make.trailing.equalTo(PiceSetTwoButton.snp.trailing).offset(-PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth)
         make.centerY.equalTo(PiceSetTwoButton.snp.centerY)
      }
   }
   
   
   private func NSPPiceThreeImageView() {
      self.PiceThreeImageViewLeft33.snp.makeConstraints { make in
         make.leading.equalTo(PiceSetThreeButton.snp.leading).offset(PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth)
         make.centerY.equalTo(PiceSetThreeButton.snp.centerY)
      }
      
      self.PiceThreeImageViewRight33.snp.makeConstraints { make in
         make.trailing.equalTo(PiceSetThreeButton.snp.trailing).offset(-PiceImageMargin)
         make.width.equalTo(PiceBaseWidth)
         make.height.equalTo(PiceBaseWidth)
         make.centerY.equalTo(PiceSetThreeButton.snp.centerY)
      }
   }
   
   
   private func NSPPiceFourImageView() {
      self.PiceFourImageViewLeft43.snp.makeConstraints { make in
         make.leading.equalTo(PiceSetFourButton.snp.leading).offset(PiceImageMargin)
         make.width.equalTo(50)
         make.height.equalTo(50 * 3 / 4)
         make.centerY.equalTo(PiceSetFourButton.snp.centerY)
      }
      
      self.PiceFourImageViewRight43.snp.makeConstraints { make in
         make.trailing.equalTo(PiceSetFourButton.snp.trailing).offset(-PiceImageMargin)
         make.width.equalTo(50)
         make.height.equalTo(50 * 3 / 4)
         make.centerY.equalTo(PiceSetFourButton.snp.centerY)
      }
   }
   
   
   //MARK:- ボタンがタップされた
   @IBAction func TapShoppingPiceButton(_ sender: UIButton) {
      let tag = sender.tag
      print("タップされたボタンは\(tag)番目のボタンです")
      
      let PiceShopEachVCSB = UIStoryboard(name: "PiceShopEachViewControllerSB", bundle: nil)
      let PiceShopEachCV = PiceShopEachVCSB.instantiateViewController(withIdentifier: "PiceShopEachVC") as! PiceShopEachViewController
      
      PiceShopEachCV.getPiceShopTag(tag: tag)
      self.navigationController?.pushViewController(PiceShopEachCV, animated: true)
      
   }
}
