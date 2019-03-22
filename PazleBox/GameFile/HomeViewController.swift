//
//  HomeViewController.swift
//  PazleBox
//
//  Created by jun on 2019/03/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
   
   @IBAction func NextViewWithNum(_ sender: UIButton) {
      
      //遷移先のインスタンス
      //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController
      
      //ViewController2のtextにtextFieldのテキストを代入
      print("Button.tag = \(sender.tag)")
      vc2.StageNum = sender.tag
      
      //NavigationControllerを継承したViewControllerを遷移
       present(vc2, animated: true, completion: nil)
   }
   
 
   
   override func viewDidLoad() {
      super.viewDidLoad()

   }

}


