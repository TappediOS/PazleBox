//
//  AboutPazzleMakerTableviewController.swift
//  PazleBox
//
//  Created by jun on 2020/04/05.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine

class AboutPazzleMakerTableviewController: UITableViewController {
   
   let numOfSection = 1
   let firstNumberOfRowsInSection = 3

   let GameSound = GameSounds()

   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationController()
      SetUpLabelText()
   }
      
   private func SetUpNavigationController() {
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("About Puzzle Maker", comment: "")
   }
   
   private func SetUpLabelText() {
      //UserInfoLabel.text = NSLocalizedString("UserInfo", comment: "")
      
   }
      
   
   // MARK: - Table view data source
   // セクションの数を返します
   override func numberOfSections(in tableView: UITableView) -> Int {
         // #warning Incomplete implementation, return the number of sections
      return numOfSection
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
      switch section {
      case 0:
         return firstNumberOfRowsInSection
      default:
         return 0
      }
   }
      
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("section 番号: \(indexPath.section)")
      print("index   番号: \(indexPath.row)")
         
//      switch indexPath.section {
//      case 0:
//         //TapUserInfo(rowNum: indexPath.row)
//      case 1:
//         //TapNoAds(rowNum: indexPath.row)
//      case 2:
//         //TapOther(rowNum: indexPath.row)
//      default:
//         print("ここにはこない")
//         return
//      }
      
     // if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
      //   UIApplication.shared.open(url, options: [:], completionHandler: nil)
     // }
      
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
   
}
