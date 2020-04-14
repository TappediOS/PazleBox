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
import FirebaseAuth
import SCLAlertView

class UsersSettingTableViewController: UITableViewController, UITextFieldDelegate {
   
   let numOfSection = 2
   let firstNumberOfRowsInSection = 1
   let secondNumberOfRowsInSection = 1
   
   var db: Firestore!
   
   var numOfStagePlayed = 0
   
   var usersName: String = NSLocalizedString("Guest", comment: "")
   
   let leaderBords = ManageLeadearBoards()
   let GameSound = GameSounds()
   
   
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
      BlockAccountsLabel.text = NSLocalizedString("BlockedAccounts", comment: "")
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
      ShowNoteAlertViewForDeleteAccount()
   }
   
   private func ShowNoteAlertViewForDeleteAccount() {
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let AlertView = SCLAlertView(appearance: Appearanse)

      AlertView.addButton(NSLocalizedString("DeleteAccount", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.ShowWorningAlertViewForDeleteAccount()
      }
      AlertView.addButton(NSLocalizedString("Cancel", comment: "")) {
         self.Play3DtouchLight()
         self.GameSound.PlaySoundsTapButton()
      }
      
      let title = NSLocalizedString("DeleteAccount", comment: "")
      let subTitle = NSLocalizedString("DeleteInfo", comment: "")
      AlertView.showInfo(title, subTitle: subTitle)
   }
   
   private func ShowWorningAlertViewForDeleteAccount() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let AlertView = SCLAlertView(appearance: Appearanse)

      AlertView.addButton(NSLocalizedString("DeleteAccount", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.DeleteAccount()
      }
      
      AlertView.addButton(NSLocalizedString("Cancel", comment: "")) {
         self.Play3DtouchLight()
         self.GameSound.PlaySoundsTapButton()
      }
      
      let title = NSLocalizedString("Warning", comment: "")
      let subTitle = NSLocalizedString("WarningInfo", comment: "")
      AlertView.showWarning(title, subTitle: subTitle)
   }
   
   
   private func DeleteAccount() {
      let user = Auth.auth().currentUser
      
      user?.delete { err in
         if let err = err {
            print("アカウントの削除でエラー発生")
            print("Error: \(err.localizedDescription)")
            self.ShowErrorAlertForDeleteAccount()
            return
         }
         
         print("アカウントの削除成功")
         
         UserDefaults.standard.set(true, forKey: "FirstCreateStage")
         UserDefaults.standard.set(0, forKey: "CreateStageNum")
         UserDefaults.standard.set(false, forKey: "Logined")
         UserDefaults.standard.set("", forKey: "UID")
         UserDefaults.standard.set("", forKey: "UserDefaultFcmToken")
         
         self.ShowSeeYouAlertView()
      }
   }
   
   private func ShowSeeYouAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let AlertView = SCLAlertView(appearance: Appearanse)

      AlertView.addButton(NSLocalizedString("SeeYou", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         fatalError("Delete Account And Kill App.")
      }
           
      let title = NSLocalizedString("AccountDeleteComplete", comment: "")
      let subTitle = NSLocalizedString("ThankYouUsingThisApp", comment: "")
      AlertView.showSuccess(title, subTitle: subTitle)
   }
   
   private func ShowErrorAlertForDeleteAccount() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: true)
      let AlertView = SCLAlertView(appearance: Appearanse)
           
      let title = NSLocalizedString("AccountDeleteFailure", comment: "")
      let subTitle = NSLocalizedString("checkNet", comment: "")
      AlertView.showError(title, subTitle: subTitle)
   }

   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
