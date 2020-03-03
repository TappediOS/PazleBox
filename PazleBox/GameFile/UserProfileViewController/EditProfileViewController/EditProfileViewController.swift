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
   var usersImage = UIImage()
   
   let usersImageViewWide: CGFloat = 70
   //テキストフィールドに書き込む最大の文字数。
   let maxTextfieldLength = 25
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpTextField()
      SetUpNavigationBarItem()
      
      SetUpUsersImageButton()
      
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
      //オブザーバ登録
      NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)),
          name: UITextField.textDidChangeNotification, object: UsersNameTextField)
   }

   //オブザーバの片付けをする。
   deinit {
      NotificationCenter.default.removeObserver(self)
   }
   
   func SetUpNavigationBarItem() {
      let stopItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(TapStopEditProfileButton))
      stopItem.tintColor = .black
      self.navigationItem.leftBarButtonItem = stopItem
      
      let DoneItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(TapSaveEditProfileButton))
      DoneItem.tintColor = .black
      self.navigationItem.rightBarButtonItem = DoneItem
   }
   
   func SetUpUsersImageButton() {
      //EditUserProfileImageButton.setImage(someImage, for: .normal)
      EditUserProfileImageButton.layer.borderWidth = 0.5
      EditUserProfileImageButton.layer.cornerRadius = self.usersImageViewWide / 2
      EditUserProfileImageButton.layer.masksToBounds = true
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
   
   public func getUsersImage(image: UIImage) {
      self.usersImage = image
   }
   
   public func getUsersName(name: String) {
      self.usersName = name
   }
   
   
   @IBAction func TapEditUserProfileImageButton(_ sender: Any) {
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       UsersNameTextField.resignFirstResponder()
       return true
   }
   
   //MARK:- テキストフィールドの処理を記載。
   //制限を超えた場合は，表示されないようにする。
   @objc func textFieldDidChange(notification: NSNotification) {
      let textField = notification.object as! UITextField
      if let text = textField.text {
         if textField.markedTextRange == nil && text.count > maxTextfieldLength {
            textField.text = text.prefix(maxTextfieldLength).description
         }
      }
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
