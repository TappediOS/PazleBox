//
//  LoginViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/09.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseAuth
import Firebase
import SnapKit
import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate {
   
   // Unhashed nonce.
   fileprivate var currentNonce: String?
   
   var OtherLoginButton = UIButton()
   var AppleLoginButton = ASAuthorizationAppleIDButton()
   
   var AuthUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
   let Providers: [FUIAuthProvider] = [
      FUIGoogleAuth(),
      FUIEmailAuth()
   ]
   
   func application(_ app: UIApplication, open url: URL,
                    options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
     if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
       return true
     }
     // other URL handling goes here.
     return false
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitAuthUI()
      InitAppleLoginButton()
      InitOtherLoginButton()
   }
      
   func InitAuthUI() {
      self.AuthUI.delegate = self
      self.AuthUI.providers = Providers
   }
   
   func InitAppleLoginButton() {
      AppleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
      AppleLoginButton.addTarget(self, action: #selector(TapAppleLoginButton(_:)), for: .touchUpInside)
      self.view.addSubview(AppleLoginButton)
      
      AppleLoginButton.snp.makeConstraints { make in
         make.width.equalTo(view.frame.width / 2)
         make.leading.equalTo(view.snp.leading).offset(view.frame.width / 4)
         make.height.equalTo(60)
         make.top.equalTo(view.snp.top).offset(view.frame.height / 3)
      }
   }
   
   func InitOtherLoginButton() {
      OtherLoginButton.titleLabel?.text = "Other"
      OtherLoginButton.setTitle("Other", for: .normal)
      OtherLoginButton.setTitleColor(.black, for: .normal)
      OtherLoginButton.layer.masksToBounds = false
      OtherLoginButton.layer.cornerRadius = 5
      OtherLoginButton.layer.borderWidth = 1
      OtherLoginButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
      
      OtherLoginButton.addTarget(self, action: #selector(self.TapOtherLoginButton(_:)), for: .touchUpInside)
      self.view.addSubview(OtherLoginButton)
      
      OtherLoginButton.snp.makeConstraints { make in
         make.width.equalTo(view.frame.width / 2)
         make.leading.equalTo(view.snp.leading).offset(view.frame.width / 4)
         make.height.equalTo(60)
         make.top.equalTo(self.AppleLoginButton.snp.bottom).offset(30)
      }
   }
   
   
   @objc func TapOtherLoginButton (_ sender: UIButton) {
      print("OtherLogin タップされたよ")
      let AuthViewController = self.AuthUI.authViewController()
      self.present(AuthViewController, animated: true, completion: nil)
   }
   
   //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
   public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
      print("認証画面から離れたときに呼ばれる")
      // 認証に成功した場合
      
   
      
      if error == nil {
         print("認証に成功した場合")

         SaveUserToFirestore(SavedUser: user)
      }
      // エラー時の処理をここに書く
      

   }
   
   private func SaveUserToFirestore(SavedUser: User?) {
      guard let user = SavedUser else { return }
      
      let uid = user.uid
      let userName = user.displayName ?? NSLocalizedString("Guest", comment: "")
      let db = Firestore.firestore()
      
      print("\n------------FireBaseログイン情報--------------")
      print("uid:     \(uid)")
      
      UserDefaults.standard.set(uid, forKey: "UID")
      UserDefaults.standard.register(defaults: ["Logined": false])
      
      if UserDefaults.standard.bool(forKey: "Logined") == true {
         print("\n--- ユーザーはログインしています ---\n")
         db.collection("users").document(uid).updateData([
            "LastLogin": FieldValue.serverTimestamp(),
            ]) { err in
                  if let err = err {
                     print("Error updating document: \(err)")
                  } else {
                     print("Document successfully updated")
                  }
            }
            Analytics.logEvent(AnalyticsEventLogin, parameters: nil)
      }else{
         print("\n--- ユーザーの初めてのFireBaseログイン ---\n")
         db.collection("users").document(uid).setData([
            "name": userName,
            "LastLogin": Timestamp(date: Date()),
            "CreateStageNum": 0,
            "ClearStageCount": 0
         ]) { err in
            if let err = err {
               print("Error writing document: \(err)")
            } else {
               print("Document successfully written!")
               UserDefaults.standard.set(true, forKey: "Logined")
            }
         }
         Analytics.logEvent(AnalyticsEventSignUp, parameters: nil)
         self.ChekUserCreateStageNumFromFireStore(uid: uid)
      }
      print("------------FireBaseログイン情報--------------\n")
   }
   
   //Firestoreに保存されているステージ数を取得してUser Defaultsに反映。
   private func ChekUserCreateStageNumFromFireStore(uid: String) {
      print("UID = \(uid)")
      let db = Firestore.firestore()
      db.collection("Stages").whereField("addUser", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
         } else {
            let createStageNum: Int = querySnapshot!.documents.count
            print("作成されているステージ数は， \(createStageNum) 個")
            UserDefaults.standard.set(createStageNum, forKey: "CreateStageNum")
         }
      }
   }
   
   
   @objc func TapAppleLoginButton(_ sender: ASAuthorizationAppleIDButton) {
      print("sign in with apple タップされたよ")
      requestSignInWithAppleFlow()
   }
   
   func requestSignInWithAppleFlow() {
       let nonce = randomNonceString()
       currentNonce = nonce
       let request = ASAuthorizationAppleIDProvider().createRequest()
       request.requestedScopes = [.fullName, .email]
       request.nonce = sha256(nonce)
       let controller = ASAuthorizationController(authorizationRequests: [request])
       controller.delegate = self
       controller.presentationContextProvider = self
       controller.performRequests()
   }
    
   private func randomNonceString(length: Int = 32) -> String {
     precondition(length > 0)
     let charset: Array<Character> =
         Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
     var result = ""
     var remainingLength = length

     while remainingLength > 0 {
       let randoms: [UInt8] = (0 ..< 16).map { _ in
         var random: UInt8 = 0
         let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
         if errorCode != errSecSuccess {
           fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
         }
         return random
       }

       randoms.forEach { random in
         if length == 0 {
           return
         }

         if random < charset.count {
           result.append(charset[Int(random)])
           remainingLength -= 1
         }
       }
     }

     return result
   }
   
   private func sha256(_ input: String) -> String {
     let inputData = Data(input.utf8)
     let hashedData = SHA256.hash(data: inputData)
     let hashString = hashedData.compactMap {
       return String(format: "%02x", $0)
     }.joined()

     return hashString
   }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
   
   func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      // 認証失敗時
      print("\n----- Sign In With Apple 認証失敗しました -----")
      print(error.localizedDescription)
      print("----- Sign In With Apple 認証失敗しました -----\n")
   }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      print("\n----- Sign In With Apple 成功 -----")
      guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
         print("キャスト失敗。ASPasswordCredential（パスワードは今回要求していないので起きないはず）だと失敗する")
          return
      }
      
      guard let nonce = currentNonce else {
         print("ログインリクエスト失敗")
         fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
         print("ユーザーに関する情報をアプリに伝えるためのJSON Web Tokenの取得に失敗")
         print("Unable to fetch identity token")
         return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
         print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
         print("JWTからトークン(文字列)へのシリアライズに失敗")
         return
      }
      
      
      // Sign In With Appleの認証情報を元にFirebase Authの認証をする
      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                accessToken: nonce)
   
      print(Auth.auth().isSignIn(withEmailLink: "jun13243546@icloud.com"))
      print(Auth.auth().isSignIn(withEmailLink: ""))
   
   
   print(Auth.auth().currentUser?.uid)
      
      // Sign in with Firebase.
      Auth.auth().signIn(with: credential) { (authResult, error) in
         if (error != nil) {
            // Error. If error.code == .MissingOrInvalidNonce, make sure
            // you're sending the SHA256-hashed nonce as a hex string with
            // your request to Apple.
            print("サインインでエラーった.")
            print(error.debugDescription)
            return
         }
         
         print("ここに来れば大成功")
         print("後は関数用意してFirestoreに登録するなりMain TabBar表示させるなりする")
      }
   
   
   }

}


extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
   func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
      // ASAuthorizationControllerPresentationContextProvidingのメソッド
      return view.window!
   }
}
