//
//  PuzzleMakerTapToPlayViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine

class PuzzleMakerTapToPlayViewController: UIViewController, UIGestureRecognizerDelegate {
   let GameSound = GameSounds()
   var BackGroundImageView: BackGroundImageViews?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      InitTapGesture()
      InitBackgroundImageView()
   }
   
   private func InitTapGesture() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TappedView(_:)))
      tapGesture.delegate = self
      self.view.addGestureRecognizer(tapGesture)
   }
   
   private func InitBackgroundImageView() {
      BackGroundImageView = BackGroundImageViews(frame: self.view.frame)
      self.view.addSubview(BackGroundImageView!)
      self.view.sendSubviewToBack(BackGroundImageView!)
   }
   
   @objc func TappedView(_ sender: UITapGestureRecognizer) {
      let PuzzleTabBar = self.storyboard?.instantiateViewController(withIdentifier: "PuzzleTabBarC") as! PuzzleTabBarController

      Play3DtouchMedium()
      GameSound.PlaySoundsTapButton()
      
      self.view.fadeOut(type: .Normal, completed: {
         PuzzleTabBar.modalPresentationStyle = .fullScreen
         self.present(PuzzleTabBar, animated: false, completion: {
            print("プレゼント終わった")
         })
      })

      
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
