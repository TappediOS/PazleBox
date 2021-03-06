//
//  SettingTableViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/30.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import Firebase
import GameKit
import TapticEngine

class SettingTableViewController: UITableViewController, GKGameCenterControllerDelegate {
   
   let IAP_PRO_ID = "NO_ADS"
   let SECRET_CODE = "c8bf5f01b42f4f80ad32ffd00349d92d"
   
   @IBOutlet weak var UserInfoLabel: UILabel!
   @IBOutlet weak var GameCenterLabel: UILabel!
   
   
   
   @IBOutlet weak var NoAdsLabel: UILabel!
   @IBOutlet weak var RestoreLabel: UILabel!
   
   @IBOutlet weak var ReviewAppLabel: UILabel!
   @IBOutlet weak var ContactUsLabel: UILabel!
   @IBOutlet weak var CreditLabel: UILabel!
   
   
   let numOfSection = 3
   let firstNumberOfRowsInSection = 2
   let secondNumberOfRowsInSection = 2
   let thirdNumberOfRowsInSection = 3
   
   var LockPurchasButton = false
   
   let GameSound = GameSounds()

   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationController()
      SetUpView()
      
      SetUpLabelText()
      CheckIAPInfomation()
      
   }
   
   private func SetUpNavigationController() {
      let stopItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(TapStopSettingVC))
      stopItem.tintColor = .black
      self.navigationItem.leftBarButtonItem = stopItem
      self.navigationItem.title = NSLocalizedString("Setting", comment: "")
   }
   
   //MARK:- NaviBarでバツボタン押されたときの処理
   @objc func TapStopSettingVC() {
      print("閉じるボタンタップされた")
      self.dismiss(animated: true, completion: {
         print("SettingVCのdismiss完了")
      })
   }
   
   private func SetUpView() {

   }
   
   private func SetUpLabelText() {
      UserInfoLabel.text = NSLocalizedString("UserInfo", comment: "")
      
      NoAdsLabel.text = NSLocalizedString("No Ads", comment: "")
      RestoreLabel.text = NSLocalizedString("Restore", comment: "")
      
      ReviewAppLabel.text = NSLocalizedString("AppReview", comment: "")
      ContactUsLabel.text = NSLocalizedString("Contact us", comment: "")
      CreditLabel.text = NSLocalizedString("AboutPuzzleMaker", comment: "")
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
      case 1:
         return secondNumberOfRowsInSection
      case 2:
         return thirdNumberOfRowsInSection
      default:
         return 0
      }
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      print("section 番号: \(indexPath.section)")
      print("index   番号: \(indexPath.row)")
      
      switch indexPath.section {
      case 0:
         TapUserInfo(rowNum: indexPath.row)
      case 1:
         TapNoAds(rowNum: indexPath.row)
      case 2:
         TapOther(rowNum: indexPath.row)
      default:
         print("ここにはこない")
         return
      }
      
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
   
   
   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
