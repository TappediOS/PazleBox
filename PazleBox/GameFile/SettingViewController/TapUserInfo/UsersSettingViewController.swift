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
   let secondNumberOfRowsInSection = 2
   
   
   @IBOutlet weak var NicNameTextField: UITextField!
   
   @IBOutlet weak var PlayCountLabel: UILabel!
   @IBOutlet weak var PlayCountNumLabel: UILabel!
   @IBOutlet weak var PlaiedCountLabel: UILabel!
   @IBOutlet weak var PlayedCountNumLabel: UILabel!
   
   var db: Firestore!
   
   var numOfStagePlayed = 0
   
   var usersName: String = NSLocalizedString("Guest", comment: "")
   
   let maxTextfieldLength = 9
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpView()
      SetUpTextField()
      SetUpLabelText()
      SetUpFireStoreSetting()
      //自分の取得する
      GetUserDataFromDataBase()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillAppear(true)
      print("表示時　のニックネーム： \(self.usersName)")
      print("閉じる時のニックネーム： \(String(describing: self.NicNameTextField.text))")
      
      //nilはだめ。
      guard let newName = self.NicNameTextField.text else { return }
      
      //変わってない場合
      guard newName != usersName else {
         print("ニックネーム変わってないよね。")
         return
      }
      
      //空白文字の場合
      guard newName != "" else { return }
      
      
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(uid).updateData([
         "name": newName
      ]) { err in
         if let err = err {
            print("\nニックネームアップデートエラー: \(err)")
         } else {
            print("\nニックネームアップデート成功!")
         }
      }
      
   }
   
   private func SetUpView() {
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
   }
   
   private func SetUpTextField() {
      NicNameTextField.returnKeyType = .done
      NicNameTextField.delegate = self
      NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)),
                                             name: UITextField.textDidChangeNotification, object: NicNameTextField)
   }

   deinit {
      NotificationCenter.default.removeObserver(self)
   }
   
   private func SetUpLabelText() {
      NicNameTextField.text = NSLocalizedString("Guest", comment: "")
      
      PlayCountLabel.text = NSLocalizedString("PlayCount", comment: "")
      PlayCountNumLabel.text = "nil"
      
      PlaiedCountLabel.text = NSLocalizedString("NumberOfStagesPlayed", comment: "")
      PlayedCountNumLabel.text = "nil"

   }
   
   private func FSSetUpLabelText(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         NicNameTextField.text = userName
         usersName = userName
      }
      
      if let ClearStageCount = document.data()?["ClearStageCount"] as? Int {
         PlayCountNumLabel.text = String(ClearStageCount)
      }
   }
   
   private func FSSetUPlayedCountNumLabelText() {
      PlayedCountNumLabel.text = String(numOfStagePlayed)
   }
   
   private func documentPlayCount(document: DocumentSnapshot) -> Int {
      if let playCount = document["PlayCount"] as? Int {
         return playCount
      }
      print("documentからプレイ回数が取得できてない。")
      print("documentId = \(document.documentID)")
      return 0
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   //MARK:-  ユーザデータ取得
   private func GetUserDataFromDataBase() {
      print("自分のデータの取得開始")
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      print("UID = \(uid)")
      db.collection("users").document(uid).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            self.FSSetUpLabelText(document: document)
         } else {
            print("Document does not exist")
            
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
      
      db.collection("Stages").whereField("addUser", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         } else {
            self.Play3DtouchSuccess()
            for document in querySnapshot!.documents {
               self.numOfStagePlayed += self.documentPlayCount(document: document)
            }
            self.FSSetUPlayedCountNumLabelText()
         }
         print("作ったステージのプレイされた回数の取得完了")
         print("合計は \(self.numOfStagePlayed)")
      }
   }
   
   //MARK:- テキストフィールドの処理を記載。
   //制限を超えた場合は，表示されないようにする。
   @objc func textFieldDidChange(notification: NSNotification) {
      guard let text = NicNameTextField.text else { return }
      NicNameTextField.text = String(text.prefix(maxTextfieldLength))
      
      if text.count == 0 {
         NicNameTextField.isEnabled = false
      } else {
         NicNameTextField.isEnabled = true
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       NicNameTextField.resignFirstResponder()
       return true
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
         TapNicName()
         print("")
      case 1:
         TapUserInfo(rowNum: indexPath.row)
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
   
   
   func TapNicName() {
      
   }
   
   func TapUserInfo(rowNum: Int) {
      
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
