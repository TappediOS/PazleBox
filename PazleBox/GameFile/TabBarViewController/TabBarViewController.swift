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
   override func viewDidLoad() {
      super.viewDidLoad()
   }
    
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        
      let Storybord = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let PlayVC = Storybord.instantiateViewController(withIdentifier: "SellectCreateStageViewController")
      PlayVC.modalPresentationStyle = .fullScreen
      PlayVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: "あそぶ",
                                           image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"), tag: 1)
      PlayVC.title = "あそぶ"
      
      
      let CreateVC = Storybord.instantiateViewController(withIdentifier: "StageMakingVC")
      CreateVC.modalPresentationStyle = .fullScreen
      CreateVC.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: "作る",
                                               image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"), tag: 2)
      CreateVC.title = "作る"
      
        
      let SettingVC = UIStoryboard(name: "Third", bundle: nil).instantiateInitialViewController()
      SettingVC?.tabBarItem = ESTabBarItem.init(TabBarBasicContentView(), title: "設定",
                                                image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"), tag: 3)
      SettingVC?.title = "設定"
        
      
        
      self.viewControllers = [PlayVC, CreateVC, CreateVC]
   }
}
