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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationBar()
      InitBackgroundImageView()
   }
   
   //TODO:- ローカライズしてなぁ
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("Pice Shop", comment: "")
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
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
