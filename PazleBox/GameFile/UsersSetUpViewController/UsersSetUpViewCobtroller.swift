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
import FirebaseAuth
import FirebaseFirestore
import CropViewController
import FirebaseStorage
import NVActivityIndicatorView
import SCLAlertView

class UsersSetUpViewCobtroller: UIViewController, UITextFieldDelegate {
   
   
   @IBOutlet weak var RegisterUserInfoLabel: UILabel!
   @IBOutlet weak var UsersProfileButton: UIButton!
   @IBOutlet weak var ChangeProfileButton: UIButton!
   
   var isChangeUsersImage = false
   
   @IBOutlet weak var NameLabel: UILabel!
   @IBOutlet weak var NameTextField: UITextField!
   
   
   @IBOutlet weak var RegisterButton: UIButton!
   
   
   @IBOutlet weak var ReLoadCheckUserExistFireStoreButton: UIButton!
   
   
   
   var UserNameWhenTapRegisterButton: String = ""
   var usersImage = UIImage()
   
   var LoadActivityView: NVActivityIndicatorView?
   
   let usersImageViewWide: CGFloat = 70
   //テキストフィールドに書き込む最大の文字数。
   let maxTextfieldLength = 30
   
   var db: Firestore!
   
   let NoProfileImage = UIImage(named: "NoProfileImage.png")
   
   var isFinishRegistorProfileImageFirebaseStorage = false
   var isFinishRegistorUserInfoFireStore = false
   
   var isFailForUserUidIsNil = false
   var FailForUserUidInNilCount = 0
   
   override func viewDidLoad() {
      InitLoadActivityView()
      SetUpTextField()
      SetUpUsersImageButton()
      SetUpReLoadCheckUserExistFireStoreButton()
      SetUpRegisterUserInfoLabel()
      SetUpRegisterButton()
      SetUpChangeProfileButton()
      SetUpNameLabel()
      SetUpFireStoreSetting()
      
      
      DisableReLoadCheckUserExistFireStoreButton()
      DisableChangeProfileButtonAndTextField()
      
      self.StartLoadingAnimation()
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.45) {
         self.CheckUserFirstLoginOrReDownloadApp()
      }
   }
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 5
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / 2 - (Viewsize / 2)
      let StartY = self.view.frame.height / 2 - (Viewsize / 2)
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
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
      UsersProfileButton.setImage(NoProfileImage, for: .normal)
      UsersProfileButton.layer.borderWidth = 0.5
      UsersProfileButton.layer.cornerRadius = self.usersImageViewWide / 2
      UsersProfileButton.layer.masksToBounds = true
   }
   
   func SetUpReLoadCheckUserExistFireStoreButton() {
      ReLoadCheckUserExistFireStoreButton.layer.borderWidth = 0
      ReLoadCheckUserExistFireStoreButton.layer.cornerRadius = 10
   }
   
   func SetUpRegisterUserInfoLabel() {
      RegisterUserInfoLabel.text = NSLocalizedString("RegiUserInfo", comment: "")
      RegisterUserInfoLabel.adjustsFontSizeToFitWidth = true
   }
   
   func SetUpRegisterButton() {
      let title = NSLocalizedString("Register", comment: "")
      RegisterButton.setTitle(title, for: .normal)
      RegisterButton.titleLabel?.adjustsFontSizeToFitWidth = true
      RegisterButton.titleLabel?.adjustsFontForContentSizeCategory = true
      RegisterButton.setTitleColor(UIColor.clouds(), for: .normal)
      RegisterButton.layer.cornerRadius =  5
      RegisterButton.isEnabled = false
      usersImage = NoProfileImage!
   }
   
   func SetUpChangeProfileButton() {
      let title = NSLocalizedString("SetUpProfilePicture", comment: "")
      ChangeProfileButton.setTitle(title, for: .normal)
      ChangeProfileButton.titleLabel?.adjustsFontSizeToFitWidth = true
   }
   
   func SetUpNameLabel() {
      NameLabel.text = NSLocalizedString("Name", comment: "")
      NameLabel.adjustsFontSizeToFitWidth = true
   }
   
   private func SetUpFireStoreSetting() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
   }

   private func DisableReLoadCheckUserExistFireStoreButton() {
      self.ReLoadCheckUserExistFireStoreButton.isEnabled = false
      self.ReLoadCheckUserExistFireStoreButton.isHidden = true
   }
   
   private func EnableReLoadCheckUserExistFireStoreButton() {
      self.ReLoadCheckUserExistFireStoreButton.isEnabled = true
      self.ReLoadCheckUserExistFireStoreButton.isHidden = false
   }
   
   private func DisableChangeProfileButtonAndTextField() {
      self.UsersProfileButton.isEnabled = false
      self.ChangeProfileButton.isEnabled = false
      self.NameTextField.isEnabled = false
   }
   
   private func EnableChangeProfileButtonAndTextField() {
      self.UsersProfileButton.isEnabled = true
      self.ChangeProfileButton.isEnabled = true
      self.NameTextField.isEnabled = true
   }
   
   private func showErrorAlertViewForUserUidIsNil() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let AlertView = SCLAlertView(appearance: Appearanse)
      
      AlertView.addButton("OK") {
         self.Play3DtouchMedium()
         self.EnableReLoadCheckUserExistFireStoreButton()
      }
           
      let title = NSLocalizedString("err", comment: "")
      let subTitle = NSLocalizedString("checkNet", comment: "")
      AlertView.showError(title, subTitle: subTitle)
   }
   
   //MARK:- 自分のデータがすでにサーバー上にあるかのチェック
   private func CheckUserFirstLoginOrReDownloadApp() {
      
      //UIDがnilのときの処理
      if UserDefaults.standard.string(forKey: "UID") == nil {
         self.isFailForUserUidIsNil = true
         FailForUserUidInNilCount += 1
         self.StopLoadingAnimation()
         self.showErrorAlertViewForUserUidIsNil()
         return
      }
      self.isFailForUserUidIsNil = false
      
      let uid = UserDefaults.standard.string(forKey: "UID")!
      print("--- 初めての登録かアプリ再ダウンロードかの調査開始 ---")
      print("--- UIDがFireStoreの/user/uidにあるか調べる: \(uid) ---")
      db.collection("users").document(uid).getDocument() { document, err in
         self.StopLoadingAnimation() //Stop Animation
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.ShowErrGetUserInfoForCheckUserRegisterAppAlertView()
            return
         }
         
         if let document = document, document.exists {
            print("--- UIDがFireStoreに存在しました! ---")
            print("UserDefaults[Logined]をtrueに変更してMainTabBarを開きます")
            UserDefaults.standard.set(true, forKey: "Logined")
            //mainVCを表示すると同時に既に登録しているステージ数を調査
            self.ChekUserCreateStageNumFromFireStore(uid: uid)
            self.segeMainTabBarController()
         } else {
            print("--- UIDがFireStoreに存在しませんでした ---")
            print("--- ボタンとtextFieldを使用可能にします---")
            self.EnableChangeProfileButtonAndTextField()
         }
      }
   }
   
   //自分のデータがすでにサーバー上にあるかのチェックでエラーした場合のリロードボタンが押されたときの処理
   @IBAction func TapReLoadCheckUserExistFireStoreButton(_ sender: Any) {
      //自身のボタンを無効にする
      self.DisableReLoadCheckUserExistFireStoreButton()
      self.StartLoadingAnimation()
      
      //UID == nil のせいではないエラーの場合は際リロード
      //UID == nil であっても1回目はこっちにはいる
      if self.isFailForUserUidIsNil == false || FailForUserUidInNilCount == 1 {
         self.CheckUserFirstLoginOrReDownloadApp()
         return
      }
      
      //2回以上UID がnilの場合はもう一回匿名ログインさせる
      self.ReSignInAnonymously()
   }
   
   private func ReSignInAnonymously() {
      Auth.auth().signInAnonymously() { (authResult, error) in
         if let error = error {
            print("再ログイン失敗")
            print("Err: \(error.localizedDescription)")
            self.showErrorAlertViewForUserUidIsNil()
            self.StopLoadingAnimation()
            return
         }
         guard let user = authResult?.user else {
            print("userで失敗")
            self.showErrorAlertViewForUserUidIsNil()
            self.StopLoadingAnimation()
            return
         }
         
         let isAnonymous = user.isAnonymous
         let uid = user.uid
         
         print("\n------------FireBaseログイン情報--------------")
         print("匿名認証: \(isAnonymous)")
         print("uid:     \(uid)")
         
         UserDefaults.standard.set(uid, forKey: "UID")
         //ログイン成功したらもう一度調査する
         self.CheckUserFirstLoginOrReDownloadApp()
      }
   }
   
   
   func ShowErrGetUserInfoForCheckUserRegisterAppAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         ComleateView.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.EnableReLoadCheckUserExistFireStoreButton()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errGetDoc = NSLocalizedString("errGetDoc", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errGetDoc + "\n" + checkNet)
   }
   
   //MARK:- ローディングアニメーション再生
   func StartLoadingAnimation() {
      print("ローディングアニメーション再生")
      self.LoadActivityView?.startAnimating()
      return
   }
   
   func StopLoadingAnimation() {
      print("ローディングアニメーション停止")
      if LoadActivityView?.isAnimating == true {
         self.LoadActivityView?.stopAnimating()
      }
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
      let Cancel = NSLocalizedString("Canel", comment: "")
      
      
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
      
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCancelタップされた")
      })
      
      ActionSheet.addAction(TakePhotoAction)
      ActionSheet.addAction(SelectPhotoAction)
      ActionSheet.addAction(DeletePhotoAction)
      ActionSheet.addAction(CancelAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   @IBAction func TapRegisterButton(_ sender: Any) {
      print("登録ボタンタップされた")
      
      let uid = UserDefaults.standard.string(forKey: "UID")!
      let UserName = self.NameTextField.text ?? NSLocalizedString("Guest", comment: "")
      let imageData = usersImage.jpegData(compressionQuality: 0.475) as! NSData
      
      print("登録する名前は\(UserName)")
      print("UID = \(uid)\n")
    
      
      
      
      RegisterUserFirebase(uid: uid, Name: UserName, profileImage: imageData)
      RegisterUserImageFireStorage(uid: uid, imageData: imageData)
    
   }
   
   private func RegisterUserImageFireStorage(uid: String, imageData: NSData) {
      let storage = Storage.storage()
      let storageRef = storage.reference()
      let ref = "UserProfileImage/" + uid + ".png"
      
     
      
      let ProfileImagesRef = storageRef.child(ref)
      
      print("\n---------- プロ画をStorageに保存開始  ----------")
      print("登録するRefは\(ref)")
      let uploadTask = ProfileImagesRef.putData(imageData as Data, metadata: nil) { (metadata, error) in
      
         guard let metadata = metadata else {
            print("---------- プロ画をStorageに保存失敗  ----------\n")
            return
         }
      
         print("---------- プロ画をStorageに保存成功  ----------\n")
         print("\n---------- プロ画のURLを取得開始  ----------")
         ProfileImagesRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
               print("---------- プロ画のURLを取得失敗  ----------\n")
               return
            }
         
            print("---------- プロ画のURLを取得成功  ----------\n")
            self.RegisterProfileURLtoFirestore(uid: uid, downloadURL: downloadURL)
         }
      }
   }
   
   private func RegisterProfileURLtoFirestore(uid: String, downloadURL: URL) {
      print("\n---------- プロ画をのURLをFireStoreに保存開始  ----------")
      let downloadURLStr: String = downloadURL.absoluteString
      print("ダウンロードURL = \(downloadURLStr)")
      db.collection("users").document(uid).setData(
         ["downloadProfileURL": downloadURLStr
      ], merge: true) { err in
         if let err = err {
            print("Error writing document: \(err)")
            print("---------- プロ画をのURLをFireStoreに保存失敗  ----------\n")
         }
         print("---------- プロ画のURLをFireStoreに保存成功  ----------\n")
         self.isFinishRegistorProfileImageFirebaseStorage = true
         if self.isFinishRegistorUserInfoFireStore == true {
            print("firestoreも登録終わってるからMainTabBar表示します")
            self.segeMainTabBarController()
         }
      }
   }
   
   private func RegisterMonitoredUserInfoFirebStore(uid: String, name: String) {
      print("\n---------- MonitoerdUserInfoをFireStoreに保存開始  ----------")
      let EmptyArray = Array<Any>()
      var TimeLineShowListArray = Array<Any>()
      TimeLineShowListArray.append(uid)
      
      let FcmToken = UserDefaults.standard.string(forKey: "UserDefaultFcmToken") ?? ""
     
      print("FcmToken = \(FcmToken)")
      //FcmTokenは別途登録する.appDelegateで。そのタイミングがいつになるかわからんからここではsetData()
      //を使う。ただし，mergeをtrueにする
      //逆に言えば，appDelegateで更新する際もsetData() + mergeをtrue.
      db.collection("users").document(uid).collection("MonitoredUserInfo").document("UserInfo").setData([
         "name": name,
         "usersUID": uid,
         "Block": EmptyArray,
         "Blocked": EmptyArray,
         "Follow": EmptyArray,
         "Follower": EmptyArray,
         "TimeLineShowList": TimeLineShowListArray,
         "FcmToken": FcmToken
      ], merge: true) { err in
         if let err = err {
            print("---------- MonitoerdUserInfoをFireStoreに保存失敗  ----------\n")
            print("Error writing document: \(err)")
         } else {
            print("---------- MonitoerdUserInfoをFireStoreに保存成功  ----------\n")
            print("ログインのUsredefaultsをtrueに変更します")
            UserDefaults.standard.set(true, forKey: "Logined")
            self.isFinishRegistorUserInfoFireStore = true
            if self.isFinishRegistorProfileImageFirebaseStorage == true {
               print("storageも登録終わってるからMainTabBar表示します")
               self.segeMainTabBarController()
            }
         }
      }
   }
   
   private func RegisterUserFirebase(uid: String, Name: String, profileImage: NSData) {
      print("\n---------- ユーザ情報をFireStoreに保存開始  ----------")
      let FcmToken = UserDefaults.standard.string(forKey: "UserDefaultFcmToken") ?? ""
      let Biography: String = ""
      let FollowArray = Array<Any>()
      let FollowerArray = Array<Any>()
      var TimeLineShowList = Array<Any>()
      TimeLineShowList.append(uid)
      db.collection("users").document(uid).setData([
         "name": Name,
         "usersUID": uid,
         "Biography": Biography,
         "isPublished": true,
         "AccountCreatedDay": Timestamp(date: Date()),
         "LastLogin": Timestamp(date: Date()),
         "CreateStageNum": 0,
         "ClearStageCount": 0,
         "Follow": FollowArray,
         "Follower": FollowerArray,
         "TimeLineShowList": TimeLineShowList,
         "downloadProfileURL": "nil",
         "FcmToken": FcmToken
      ]) { err in
         if let err = err {
            print("---------- ユーザ情報をFireStoreに保存失敗  ----------\n")
            print("Error writing document: \(err)")
         } else {
            print("---------- ユーザ情報をFireStoreに保存成功  ----------\n")
            self.RegisterMonitoredUserInfoFirebStore(uid: uid, name: Name)
         }
      }
      Analytics.logEvent(AnalyticsEventSignUp, parameters: nil)
   }
   
   //
   private func ChekUserCreateStageNumFromFireStore(uid: String) {
      print("UID = \(uid)")
      db.collectionGroup("Stages").whereField("addUser", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
         } else {
            let createStageNum: Int = querySnapshot!.documents.count
            print("作成されているステージ数は， \(createStageNum) 個")
            UserDefaults.standard.set(createStageNum, forKey: "CreateStageNum")
            
            if createStageNum != 0 {
               self.UpdateCreateStageNumFirebase(uid: uid, createStageNum: createStageNum)
            }
         }
      }
   }
   
   private func UpdateCreateStageNumFirebase(uid: String, createStageNum: Int) {
      db.collection("users").document(uid).updateData(
         ["CreateStageNum": createStageNum
      ]) { err in
         if let err = err {
            print("作成されているステージ数の再登録エラー")
            print("Error writing document: \(err)")
         }
         print("作成されているステージ数の再登録完了")
      }
   }
   
   //MARK:- MainVCの表示
   private func segeMainTabBarController() {
      print("\n---------- MainVCの表示開始  ----------")
      let sb = UIStoryboard(name: "Main", bundle: nil)
      let tabBarVC = sb.instantiateViewController(withIdentifier: "PuzzleTabBarC") as! PuzzleTabBarController
      
      tabBarVC.modalPresentationStyle = .fullScreen
      
      self.present(tabBarVC, animated: true, completion: {
         print("---------- MainVCの表示完了  ----------\n")
      })
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
      UsersProfileButton.setImage(NoProfileImage, for: .normal)
      usersImage = NoProfileImage!
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
      print("リサイズ後のサイズpng:　\(String(describing: (resizeImage?.pngData() as! NSData).length))")
      print("リサイズ後のサイズjpeg1:　\(String(describing: (resizeImage?.jpegData(compressionQuality: 1) as! NSData).length))")
      print("リサイズ後のサイズjpeg0.9:　\(String(describing: (resizeImage?.jpegData(compressionQuality: 0.9) as! NSData).length))")
      print("リサイズ後のサイズjpeg0.75:　\(String(describing: (resizeImage?.jpegData(compressionQuality: 0.75) as! NSData).length))")
      print("リサイズ後のサイズjpeg0.5:　\(String(describing: (resizeImage?.jpegData(compressionQuality: 0.5) as! NSData).length))")
      print("リサイズ後のサイズjpeg0.25:　\(String(describing: (resizeImage?.jpegData(compressionQuality: 0.25) as! NSData).length))\n")

      usersImage = resizeImage!
      cropViewController.dismiss(animated: true, completion: {
         print("画像を編集して，CropVCを閉じました")
         
      })
   }
}
