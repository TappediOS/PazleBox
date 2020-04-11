//
//  UsersSettingTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import Firebase
import FirebaseFirestore

class UsersSettingTableViewController: UITableViewController, UITextFieldDelegate {
   
   let numOfSection = 2
   let firstNumberOfRowsInSection = 1
   let secondNumberOfRowsInSection = 1
   
   var db: Firestore!
   
   var numOfStagePlayed = 0
   
   var usersName: String = NSLocalizedString("Guest", comment: "")
   
   let leaderBords = ManageLeadearBoards()
   
   
   @IBOutlet weak var BlockAccountsLabel: UILabel!
   @IBOutlet weak var DeleteAcountLabel: UILabel!
   
   
   //テキストフィールドに書き込む最大の文字数。
   let maxTextfieldLength = 6
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpView()
      SetUpNavigationBar()
      SetUpLabelStr()
   }
   
   //NOTE: viewWillDisappearにすると，Pagesheetを下げた瞬間に呼ばれる。
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(true)

      
   }
   
   private func SetUpView() {

   }
   
   private func SetUpNavigationBar() {
      self.navigationItem.title = NSLocalizedString("Account", comment: "")
   }
   
   private func SetUpLabelStr() {
      DeleteAcountLabel.text = NSLocalizedString("BlockedAccounts", comment: "")
      DeleteAcountLabel.text = NSLocalizedString("DeleteAccount", comment: "")
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
      default:
         print("設定ミスってるぞ！！！")
         return 0
      }
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      print("section 番号: \(indexPath.section)")
      print("index   番号: \(indexPath.row)")
      
      switch indexPath.section {
      case 0:
         TapBlockAccounts()
         print("")
      case 1:
         TapDeleteAccount()
         print("")
      case 2:
         //TapOther(rowNum: indexPath.row)
         print("")
      default:
         print("設定ミスってるぞ！！！")
         return
      }
      
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   private func PresentSomeUsersListVC(ListType: UsersListType) {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      let SomeUsersListSB = UIStoryboard(name: "SomeUsersListViewControllerSB", bundle: nil)
      let SomeUsersListVC = SomeUsersListSB.instantiateViewController(withIdentifier: "SomeUsersListVC") as! SomeUsersListViewController
      
      SomeUsersListVC.setListType(type: ListType)
      SomeUsersListVC.setShowUsersUID(uid: uid)
      
      SomeUsersListVC.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(SomeUsersListVC, animated: true)
   }
   
   func TapBlockAccounts() {
      print("Block Accounts Listを表示します")
      PresentSomeUsersListVC(ListType: .Block)
   }
   
   func TapDeleteAccount() {
      print("アカウント削除タップされた")
   }
   
   
   
   

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


   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
