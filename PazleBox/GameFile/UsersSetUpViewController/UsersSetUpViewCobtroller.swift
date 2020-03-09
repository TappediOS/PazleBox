//
//  UsersSetUpViewCobtroller.swift
//  PazleBox
//
//  Created by jun on 2020/03/09.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import Firebase
import FirebaseFirestore
import CropViewController


class UsersSetUpViewCobtroller: UIViewController, UITextFieldDelegate {
   
   
   @IBOutlet weak var UsersProfileButton: UIButton!
   @IBOutlet weak var ChangeProfileButton: UIButton!
   
   var isChangeUsersImage = false
   
   @IBOutlet weak var NameLabel: UILabel!
   @IBOutlet weak var NameTextField: UITextField!
   
   
   @IBOutlet weak var RegisterButton: UIButton!
   
   var UserNameWhenTapRegisterButton: String = ""
   var usersImage = UIImage()
   
   let usersImageViewWide: CGFloat = 70
   //テキストフィールドに書き込む最大の文字数。
   let maxTextfieldLength = 30
   
   var db: Firestore!
   
   override func viewDidLoad() {
      SetUpTextField()
      
      SetUpUsersImageButton()
      SetUpRegisterButton()
      SetUpFireStoreSetting()
   }
   
   
   private func SetUpTextField() {
      //文字入ってない時はdoneを押せないようにする処理
      NameTextField.enablesReturnKeyAutomatically = true
      //doneにする処理
      NameTextField.returnKeyType = .done
      NameTextField.delegate = self
      //オブザーバ登録
      NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)),
          name: UITextField.textDidChangeNotification, object: NameTextField)
   }

   //オブザーバの片付けをする。
   deinit {
      NotificationCenter.default.removeObserver(self)
   }
   
   func SetUpUsersImageButton() {
      let NoProfileImage = UIImage(named: "NoProfileImage.png")
      UsersProfileButton.setImage(NoProfileImage, for: .normal)
      UsersProfileButton.layer.borderWidth = 0.5
      UsersProfileButton.layer.cornerRadius = self.usersImageViewWide / 2
      UsersProfileButton.layer.masksToBounds = true
   }
   
   func SetUpRegisterButton() {
      let title = NSLocalizedString("Play", comment: "")
      RegisterButton.setTitle(title, for: .normal)
      RegisterButton.titleLabel?.adjustsFontSizeToFitWidth = true
      RegisterButton.titleLabel?.adjustsFontForContentSizeCategory = true
      RegisterButton.setTitleColor(UIColor.clouds(), for: .normal)
      RegisterButton.layer.cornerRadius =  5
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
   
   @IBAction func TapChangeProfileButton(_ sender: Any) {
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
   
   @IBAction func TapRegisterButton(_ sender: Any) {
      print("登録ボタンタップされた")
      UserNameWhenTapRegisterButton = self.NameTextField.text ?? NSLocalizedString("Guest", comment: "")
      
    
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
      let NoProfileImage = UIImage(named: "NoProfileImage.png")
      UsersProfileButton.setImage(NoProfileImage, for: .normal)
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       NameTextField.resignFirstResponder()
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
         if text.count > 0 {
            RegisterButton.isEnabled = true
            RegisterButton.alpha = 1
         }
         
         if text.count == 0 {
            RegisterButton.isEnabled = false
            RegisterButton.alpha = 0.85
         }
      }
   }
   
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}


extension UsersSetUpViewCobtroller: UINavigationControllerDelegate, UIImagePickerControllerDelegate,  CropViewControllerDelegate {
   
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
      
      let resizeImage = image.ResizeUIImage(width: usersImageViewWide, height: usersImageViewWide)
      
      //トリミングした画像をimageViewのimageに代入する。
      self.UsersProfileButton.setImage(resizeImage, for: .normal)
      
      print("\n元のサイズ:        \((image.pngData()! as NSData).length)")
      print("リサイズ後のサイズ:　\(String(describing: (resizeImage?.pngData() as! NSData).length))\n")

      //画像を変化させたフラグを立てる
      isChangeUsersImage = true
      cropViewController.dismiss(animated: true, completion: {
         print("画像を編集して，CropVCを閉じました")
         
      })
   }
}
