//
//  HomeViewController.swift
//  PazleBox
//
//  Created by jun on 2019/03/22.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import Lottie
import TapticEngine

class HomeViewController: UIViewController {
   
   
   private let GameSound = GameSounds()
   
   
   @IBOutlet weak var EasyButton: UIButton!
   
   @IBOutlet weak var NormalButton: UIButton!
   
   @IBOutlet weak var HardButton: UIButton!
   
   private func InitButton() {
      EasyButton.backgroundColor = UIColor.flatLime()
      NormalButton.backgroundColor = UIColor.flatLime()
      HardButton.backgroundColor = UIColor.flatLime()
      
      EasyButton.setTitleColor(UIColor.flatWhite(), for: .normal)
      NormalButton.setTitleColor(UIColor.flatWhite(), for: .normal)
      HardButton.setTitleColor(UIColor.flatWhite(), for: .normal)
   }
   
   
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
      
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      
      
      //NavigationControllerを継承したViewControllerを遷移
      print("GameViewControllerを表示します")
      self.view.fadeOut(type: .Normal){ [weak self] in
         self?.present(vc2, animated: false, completion: nil)
         self?.view.fadeIn(type: .Normal)
      }
   }
   
 
   
   override func viewDidLoad() {
      super.viewDidLoad()
         self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      InitButton()
   }
   
   private func Play3DtouchLight() {
      TapticEngine.impact.feedback(.light)
      return
   }
   
   private func Play3DtouchMedium() {
      TapticEngine.impact.feedback(.medium)
      return
   }
   
   private func Play3DtouchHeavy() {
      TapticEngine.impact.feedback(.heavy)
      return
   }

}


