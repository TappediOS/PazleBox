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

      print("ステージレベルの送信開始")
      switch sender.tag {
      case 1:
         vc2.StageLevel = .Easy
      case 2:
         vc2.StageLevel = .Normal
      case 3:
         vc2.StageLevel = .Hard
      default:
         fatalError()
      }
      print("ステージレベルの送信完了(\(vc2.StageLevel))")
      
      
      //NavigationControllerを継承したViewControllerを遷移
      print("GameViewControllerを表示します")
       present(vc2, animated: true, completion: nil)
   }
   
 
   
   override func viewDidLoad() {
      super.viewDidLoad()

   }

}


