//
//  EditProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/03.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import Firebase
import FirebaseFirestore

class EditProfileViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet weak var EditUserProfileImageButton: UIButton!
   @IBOutlet weak var NameLabel: UILabel!
   
   @IBOutlet weak var UsersNameTextField: UITextField!
   
   var db: Firestore!
   
   var usersName: String = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpTextField()
      SetUpNavigationBarItem()
      
      SetUpFireStoreSetting()
      //自分の取得する
      GetUserDataFromDataBase()
   }
   
   private func SetUpTextField() {
      //文字入ってない時はdoneを押せないようにする処理
      UsersNameTextField.enablesReturnKeyAutomatically = true
      //doneにする処理
      UsersNameTextField.returnKeyType = .done
      UsersNameTextField.delegate = self
   }
   
   func SetUpNavigationBarItem() {
      let stopItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(TapStopEditProfileButton))
      stopItem.tintColor = .black
      self.navigationItem.leftBarButtonItem = stopItem
      
      let DoneItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(TapSaveEditProfileButton))
      DoneItem.tintColor = .black
      self.navigationItem.rightBarButtonItem = DoneItem
   }
   
   private func SetUpFireStoreSetting() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
     }
   
   private func FSSetUpLabelText(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         UsersNameTextField.text = userName
         usersName = userName
      }
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
   }
   
   //MARK:- NaviBarでバツボタン押されたときの処理
   @objc func TapStopEditProfileButton() {
      print("キャンセルボタンタップされた")
      self.dismiss(animated: true, completion: {
         print("EditProfileVCのdismiss完了")
      })
   }
   
   @objc func TapSaveEditProfileButton() {
      print("Saveボタンタップされた")
      self.dismiss(animated: true, completion: {
         print("EditProfileVCのdismiss完了")
      })
   }
   
   
   @IBAction func TapEditUserProfileImageButton(_ sender: Any) {
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
