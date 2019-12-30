//
//  TabBarViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class PuzzleTabBarController: ESTabBarController {
   
   var image = UIImage()
   var selectedImage = UIImage()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
    
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      
      image = getPlayImage()
      selectedImage = getPlayFillImage()
      
      var title = NSLocalizedString("Play", comment: "")
      let Storybord = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let PlayVC = Storybord.instantiateViewController(withIdentifier: "SellectCreateStageViewController")
      PlayVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                           image: image, selectedImage: selectedImage, tag: 1)

      
      image = getCreateImage()
      selectedImage = getCreateFillImage()
      title = NSLocalizedString("Create", comment: "")
      let CreateVC = Storybord.instantiateViewController(withIdentifier: "StageMakingVC")
      CreateVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                              image: image, selectedImage: selectedImage, tag: 2)
      
      
      image = getSettingImage()
      selectedImage = getSettingFillImage()
      title = NSLocalizedString("Setting", comment: "")
      //TODO: ここのVCを作ってせっていしよう
      //TODO: staticTableViewがいいかなー
      let SettingVC = Storybord.instantiateViewController(withIdentifier: "StageMakingVC")
      SettingVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: title,
                                                image: image, selectedImage: selectedImage, tag: 3)
        
      
        
      self.viewControllers = [PlayVC, CreateVC, SettingVC]
   }
   
   private func getPlayImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "play.circle")!
      }else{
         return UIImage(named: "play.png")!
      }
   }
   
   private func getPlayFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "play.circle.fill")!
      }else{
         return UIImage(named: "play_fill.png")!
      }
   }
   
   private func getCreateImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "hammer")!
      }else{
         return UIImage(named: "hammer.png")!
      }
   }
   
   private func getCreateFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "hammer.fill")!
      }else{
         return UIImage(named: "hammer_fill.png")!
      }
   }
   
   private func getSettingImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "person")!
      }else{
         return UIImage(named: "person.png")!
      }
   }
   
   private func getSettingFillImage() -> UIImage {
      if #available(iOS 13, *) {
         return UIImage(systemName: "person.fill")!
      }else{
         return UIImage(named: "person_fill.png")!
      }
   }
}
