//
//  FirebaseLoginViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import FirebaseUI
import UIKit

class FirebaseLoginViewController: UIViewController, FUIAuthDelegate {
   
   var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
   var handle: AuthStateDidChangeListenerHandle!

   let providers: [FUIAuthProvider] = [
      FUIGoogleAuth(),
      FUIEmailAuth()
      //FUIPhoneAuth()
   ]
   
   // Google ログインのフローの結果を処理するハンドラ
   func application(_ app: UIApplication, open url: URL,
                    options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
         return true
      }
      // other URL handling goes here.
      return false
   }
   
   
   
   @IBOutlet weak var OtherProvButton: UIButton!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.authUI.delegate = self
      self.authUI.providers = providers
      

   }
   

   @IBAction func TapOtherProvButton(_ sender: Any) {
      let authViewController = self.authUI.authViewController()
      // FirebaseUIのViewの表示
      self.present(authViewController, animated: true, completion: nil)
   }
   
   //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
   public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
       // 認証に成功した場合
       if error == nil {
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               let alert = UIAlertController(title: "ログインしました。", message: "", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
       } else {
           // キャンセルボタンを押されたときは何も出さないようにしたい。
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               let alert = UIAlertController(title: "認証失敗", message: "ログインに失敗しました。申し訳ございませんが、しばらくたってからし再度お試しください。", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
            }
       }
   }
}
