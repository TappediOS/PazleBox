//
//  ShoppingPiceViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class ShoppingPiceViewController: UIViewController {
   var BackGroundImageView: BackGroundImageViews?
   
   
   @IBOutlet weak var PiceSetOneButton: UIButton!
   @IBOutlet weak var PiceSetTwoButton: UIButton!
   @IBOutlet weak var PiceSetThreeButton: UIButton!
   @IBOutlet weak var PiceSetFourButton: UIButton!
   
   
   
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
   }
   
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("PiceShop", comment: "")
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   //TODO:- ローカライズ
   private func SetUpPiceSetOneButton() {
      let title = NSLocalizedString("ピースセット1", comment: "")
      PiceSetOneButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetTwoButton() {
      let title = NSLocalizedString("ピースセット2", comment: "")
      PiceSetTwoButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetThreeButton() {
      let title = NSLocalizedString("ピースセット3", comment: "")
      PiceSetThreeButton.setTitle(title, for: .normal)
   }
   private func SetUpPiceSetFourButton() {
      let title = NSLocalizedString("ピースセット4", comment: "")
      PiceSetFourButton.setTitle(title, for: .normal)
      
   }
   
   private func ButtonSetUp(button: UIButton) {
      button.backgroundColor = .white
      button.layer.cornerRadius = 15
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
   
   
   
   @IBAction func TapShoppingPiceButton(_ sender: UIButton) {
      let tag = sender.tag
      print("タップされたボタンは\(tag)番目のボタンです")
      
      let PiceShopEachVCSB = UIStoryboard(name: "PiceShopEachViewControllerSB", bundle: nil)
      let PiceShopEachCV = PiceShopEachVCSB.instantiateViewController(withIdentifier: "PiceShopEachVC") as! PiceShopEachViewController
      
      PiceShopEachCV.getPiceShopTag(tag: tag)
      self.navigationController?.pushViewController(PiceShopEachCV, animated: true)
      
   }
}
