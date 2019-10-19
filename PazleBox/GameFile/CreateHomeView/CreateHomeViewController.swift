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

class CreateHomeViewController: UIViewController {
   
   
   @IBOutlet weak var SellectStageButton: FUIButton!
   @IBOutlet weak var CreateStageButton: FUIButton!
   @IBOutlet weak var BackHomeButton: FUIButton!
   
   var ViewW: CGFloat = 0
   var ViewH: CGFloat = 0
   var FViewW: CGFloat = 0
   var FViewH: CGFloat = 0
   
   var BackGroundImageView: BackGroundImageViews?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitViewSize()
      InitBackgroundImageView()
      InitEachButton()
   }
   
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
   
   private func InitEachButton() {
      InitButton(SellectStageButton)
      InitButton(CreateStageButton)
      InitButton(BackHomeButton)
      SetUpButtonColor()
      SetUpButtonPosition()
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
      CreateStageButton.buttonColor = UIColor.flatTeal()
      CreateStageButton.shadowColor = UIColor.flatTealColorDark()
      BackHomeButton.buttonColor = UIColor.flatCoffee()
      BackHomeButton.shadowColor = UIColor.flatCoffeeColorDark()
   }
   
   private func SetUpButtonPosition() {
      SellectStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 11, width: FViewW * 12, height: FViewH * 3)
      CreateStageButton.frame = CGRect(x: FViewW * 6, y: FViewH * 15, width: FViewW * 12, height: FViewH * 3)
      BackHomeButton.frame = CGRect(x: FViewW * 6, y: FViewH * 19, width: FViewW * 12, height: FViewH * 3)
   }
   
   
   @IBAction func TapBackButton(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
}
