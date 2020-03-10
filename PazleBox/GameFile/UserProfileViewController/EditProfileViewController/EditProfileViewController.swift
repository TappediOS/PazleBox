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
import CropViewController

class EditProfileViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet weak var EditUserProfileImageButton: UIButton!
   @IBOutlet weak var NameLabel: UILabel!
   
   var isChangeUsersImage = false
   
   @IBOutlet weak var UsersNameTextField: UITextField!
   
   var db: Firestore!
   
   var UserNameWhenShowThisVC: String = ""
   var UserNameWhenDismissThisVC: String = ""
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
   
   private func DismissEditProfileVC() {
      self.dismiss(animated: true, completion: {
         print("EditProfileVCのdismiss完了")
      })
   }
   
   //MARK:- NaviBarでバツボタン押されたときの処理
   @objc func TapStopEditProfileButton() {
      print("キャンセルボタンタップされた")
      DismissEditProfileVC()
   }
   
   //TODO: ここでデータをセーブする処理を行う
   @objc func TapSaveEditProfileButton() {
      print("Saveボタンタップされた")
      UserNameWhenDismissThisVC = self.UsersNameTextField.text ?? NSLocalizedString("Guest", comment: "")
      
      if (UserNameWhenDismissThisVC == UserNameWhenShowThisVC) && !isChangeUsersImage {
         print("名前も画像も変更されていない!")
         DismissEditProfileVC()
         return
      }
      
      if UserNameWhenDismissThisVC != UserNameWhenShowThisVC {
         print("名前が変更されているので保存する")
         
      }
      
      if isChangeUsersImage {
         print("画像が変更されているので保存する")
      }

   }
   
   public func getUsersImage(image: UIImage) {
      self.usersImage = image
   }
   
   public func getUsersName(name: String) {
      self.UserNameWhenShowThisVC = name
   }
   
   func TapTakePhotoAction() {
      let PhotoPickerVC = UIImagePickerController()
      PhotoPickerVC.sourceType = .camera
      PhotoPickerVC.delegate = self
      present(PhotoPickerVC, animated: true, completion: {
         print("Photo Pickekrが表示されました")
      })
   }
   
   func TapSelectPhotoAction() {
      let PhotoPickerVC = UIImagePickerController()
      PhotoPickerVC.sourceType = .photoLibrary
      PhotoPickerVC.delegate = self
      present(PhotoPickerVC, animated: true, completion: {
         print("Photo Pickekrが表示されました")
      })
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
         print("Delete押されたよ")
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

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate,  CropViewControllerDelegate {
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      // キャンセルボタンを押された時に呼ばれる
      print("イメージピッカーでキャンセル押された")
      picker.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

      guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }

      //CropViewControllerを初期化する。pickerImageを指定する。
      let cropController = CropViewController(croppingStyle: .circular, image: pickerImage)

      
      //AspectRatioのサイズをimageViewのサイズに合わせる。
      //cropController.customAspectRatio = EditUserProfileImageButton.frame.size
      cropController.aspectRatioPreset = .presetSquare
      
      cropController.aspectRatioPickerButtonHidden = true  //アスペクトボタン
      cropController.resetAspectRatioEnabled = false  //リセットボタン
      cropController.rotateButtonsHidden = false      //回転ボタン

      cropController.cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
      cropController.doneButtonTitle = NSLocalizedString("Done", comment: "")
      
      //cropBoxのサイズを固定する。
      cropController.cropView.cropBoxResizeEnabled = false
      
      cropController.delegate = self
      
      //cropController.modalPresentationStyle = .fullScreen

      //pickerを閉じたら、cropControllerを表示する。
      picker.dismiss(animated: true) {
         self.present(cropController, animated: true, completion: nil)
      }
   }
   
   func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
      print("Crop VCでキャンセル押されました")
      cropViewController.dismiss(animated: true, completion: nil)
   }

   func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
      //トリミング編集が終えたら、呼び出される。
      print("トリミング編集が終えた")
      updateImageViewWithImage(image, fromCropViewController: cropViewController)
   }

   func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
      print("トリミングした画像をimageViewのimageに代入する。")
      
      let resizeImage = image.ResizeUIImage(width: usersImageViewWide * 0.8, height: usersImageViewWide * 0.8)
      
      //トリミングした画像をimageViewのimageに代入する。
      self.EditUserProfileImageButton.setImage(resizeImage, for: .normal)
      
      
      let imageDataSize = Double((resizeImage?.pngData() as! NSData).length)
      print("\n-------- 保存する画像の容量 ----------")
      print(" Byte:  \(imageDataSize)")
      print("KByte:  \(imageDataSize * 0.001)")
      print("MByte:  \(imageDataSize * 0.001 * 0.001)")
      print("GByte:  \(imageDataSize * 0.001 * 0.001 * 0.001)")
      print("-------- 保存する画像の容量 ----------\n")

      //画像を変化させたフラグを立てる
      isChangeUsersImage = true
      cropViewController.dismiss(animated: true, completion: {
         print("画像を編集して，CropVCを閉じました")
         
      })
   }
}
