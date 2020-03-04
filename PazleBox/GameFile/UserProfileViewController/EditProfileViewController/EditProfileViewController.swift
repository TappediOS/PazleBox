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
   let maxTextfieldLength = 30
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpTextField()
      SetUpNavigationController()
      SetUpNavigationBarItem()
      
      SetUpUsersImageButton()
      
      SetUpFireStoreSetting()
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
   
   func SetUpNavigationController() {
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("Edit Profile", comment: "")
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
   
   //MARK:- NaviBarでバツボタン押されたときの処理
   @objc func TapStopEditProfileButton() {
      print("キャンセルボタンタップされた")
      self.dismiss(animated: true, completion: {
         print("EditProfileVCのdismiss完了")
      })
   }
   
   //TODO: ここでデータをセーブする処理を行う
   @objc func TapSaveEditProfileButton() {
      print("Saveボタンタップされた")

   }
   
   public func getUsersImage(image: UIImage) {
      self.usersImage = image
   }
   
   public func getUsersName(name: String) {
      self.usersName = name
   }
   
   func TapTakePhotoAction() {
      
   }
   
   func TapSelectPhotoAction() {
      
   }
   
   func TapDeletePhotoAction() {
      
   }
   
   
   //MARK:- 画像を変更する処理をする画面を表示する
   @IBAction func TapEditUserProfileImageButton(_ sender: Any) {
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let TakePhoto = NSLocalizedString("Take Photo", comment: "")
      let SelectPhoto = NSLocalizedString("Select Photo", comment: "")
      let DeletePhoto = NSLocalizedString("Delete Photo", comment: "")
      let Cansel = NSLocalizedString("Cansel", comment: "")
      
      
      let TakePhotoAction = UIAlertAction(title: TakePhoto, style: .default, handler: { (action: UIAlertAction!) in
         print("Take押されたよ")
         self.TapTakePhotoAction()
      })
      
      let SelectPhotoAction = UIAlertAction(title: SelectPhoto, style: .default, handler: { (action: UIAlertAction!) in
         print("Select押されたよ")
         self.TapSelectPhotoAction()
      })
      
      let DeletePhotoAction = UIAlertAction(title: DeletePhoto, style: .destructive, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapDeletePhotoAction()
      })
      
      let CanselAction = UIAlertAction(title: Cansel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCanselタップされた")
      })
      
      ActionSheet.addAction(TakePhotoAction)
      ActionSheet.addAction(SelectPhotoAction)
      ActionSheet.addAction(DeletePhotoAction)
      ActionSheet.addAction(CanselAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
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
