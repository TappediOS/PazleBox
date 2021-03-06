//
//  AppDelegate.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import FirebaseMessaging
import FirebaseFirestore
import FirebaseAuth
import Firebase
import AVFoundation
import Crashlytics
import SwiftyStoreKit
import GameKit
import UserNotifications
import COSTouchVisualizer
import ChameleonFramework
import AuthenticationServices
import FirebaseAnalytics
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, COSTouchVisualizerWindowDelegate {

   //MARK:- もしタップジェスチャー表示したかったら，importとDelegateとこれにする
//   lazy var window: UIWindow? = {
//      var customWindow = COSTouchVisualizerWindow(frame: UIScreen.main.bounds)
//      //これか確実にいるよね
//      customWindow.touchVisualizerWindowDelegate = self
//      //タッチカラーの設定
////      customWindow.fillColor = UIColor.flatWatermelon()
////      customWindow.strokeColor = UIColor.flatRed()
//      customWindow.touchAlpha = 0.5
//      //Ripple(さざ波)の設定
//      customWindow.rippleFillColor = UIColor.flatPurple()
//      //customWindow.rippleStrokeColor = UIColor.flatRed()
//      customWindow.rippleAlpha = 0.5
//      return customWindow
//   }()
   
   var window: UIWindow?
   
   //MARK:- もし使わんねんやったら消す
   func touchVisualizerWindowShouldAlwaysShowFingertip(_ window: COSTouchVisualizerWindow!) -> Bool {
      return true
   }
   
   func touchVisualizerWindowShouldShowFingertip(_ window: COSTouchVisualizerWindow!) -> Bool {
      return true
   }
   
   
   //var window: UIWindow?

   
   
   //windowのrootViewControllerでFireStoreを使おうとしたら，
   //FirebaseApp.configure()を呼び出せって怒られるからこの初期化関数ないでfirebaseを初期化してる。
   override init() {
      //--------------------FIREBASE-----------------------//
      print("firebaseにアクセス")
      let fileName = "GoogleService-Info"
      let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")
      let fileopts = FirebaseOptions(contentsOfFile: filePath!)
      FirebaseApp.configure(options: fileopts!)
      //--------------------FIREBASE-----------------------//
   }
   
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      
      var isFirestLogin = false
      
      //--------------------UITESTの処理 (1/2)-----------------------//
      var isUITesting = false
      if CommandLine.arguments.contains("--uitesting") {
         print("---UITest--- 利用規約にAcceptしてるようにします")
         UserDefaults.standard.set(true, forKey: "AcceptAgreement")
         isUITesting = true
      }
      if CommandLine.arguments.contains("--uitestingUserAgreement") {
         print("---UITest--- 利用規約にAcceptしてないようにします")
         UserDefaults.standard.set(false, forKey: "AcceptAgreement")
         isUITesting = true
      }
      //--------------------UITESTの処理 (1/2)-----------------------//

      
      
      //--------------------利用規約VC-----------------------//
//      UserDefaults.standard.register(defaults: ["AcceptAgreement": false])
//      if UserDefaults.standard.bool(forKey: "AcceptAgreement") == false {
//         print("------------利用規約画面を表示する処理をします。--------------\n")
//         let storyboard = UIStoryboard(name: "UserAgreementViewController", bundle: nil)
//         let AgreementVC = storyboard.instantiateViewController(withIdentifier: "UserAgreementVC") as! UserAgreementViewController
//         self.window = UIWindow(frame: UIScreen.main.bounds)
//         self.window?.rootViewController = AgreementVC
//      } else {
//         print("\n利用規約Acceptしてるよ。")
//      }
      //--------------------利用規約VC-----------------------//
      
      
      //-----------バックグラウンドでの音の再生を許可------------//
      //try! AVAudioSession.sharedInstance().setCategory(.ambient)
      try! AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
      //-----------バックグラウンドでの音の再生を許可------------//
      
      //--------------------ADMOB-----------------------//
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      //--------------------ADMOB-----------------------//
      
      
      //--------------------STORE KIT-----------------------//
      SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
         for purchase in purchases {
            switch purchase.transaction.transactionState {
            case .purchased, .restored:
               if purchase.needsFinishTransaction {
                  SwiftyStoreKit.finishTransaction(purchase.transaction)
               }
            // Unlock content
            case .failed, .purchasing, .deferred:
               break // do nothing
            }
         }
      }
      //--------------------STORE KIT-----------------------//
      
      //-------------------User First Open-----------------//
      //-------------------Init Ad Flag On Users Devise-------------------//
      UserDefaults.standard.register(defaults: ["BuyRemoveAd": false])
      UserDefaults.standard.register(defaults: ["BuyPiceSet1": false])
      UserDefaults.standard.register(defaults: ["BuyPiceSet2": false])
      UserDefaults.standard.register(defaults: ["BuyPiceSet3": false])
      UserDefaults.standard.register(defaults: ["BuyPiceSet4": false])
      UserDefaults.standard.register(defaults: ["FirstCreateStage": true])
      UserDefaults.standard.register(defaults: ["CreateStageNum": 0])
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true {
         print("\n--- ユーザーは広告削除の課金をしています ---\n")
      }else{
         print("\n ---ユーザーは広告削除の課金をしてない. ---\n")
      }
      let defaults = UserDefaults.standard
      let DefaultsKey = "BuyPiceSet"
      print("--------- Userの課金状況 ------------")
      print("　広告削除の購入: \(defaults.bool(forKey: "BuyRemoveAd"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "1"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "2"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "3"))")
      print("PiceSet1の購入: \(defaults.bool(forKey: DefaultsKey + "4"))")
      print("--------- Userの課金状況 ------------")
      let CreateStageNum = UserDefaults.standard.integer(forKey: "CreateStageNum")
      print("---ユーザの登録ステージ数:　\(CreateStageNum) 個----\n")
      //-------------------User First Open-----------------//
      //-------------------Init Ad Flag On Users Devise-------------------//
      
      
      //--------------------UITESTの処理 (2/2)-----------------------//
      if isUITesting == true {
         print("UITestなのでプッシュ通知のDelegateとかはONにしません。")
         return true
      }
      //--------------------UITESTの処理 (2/2)-----------------------//
      
      
      
      
      
      //--------------------FireBaseログイン-----------------------//
      UserDefaults.standard.register(defaults: ["Logined": false])
      Auth.auth().signInAnonymously() { (authResult, error) in
         guard let user = authResult?.user else { return }
         let isAnonymous = user.isAnonymous
         let uid = user.uid
         let db = Firestore.firestore()
         print("\n------------FireBaseログイン情報--------------")
         print("匿名認証: \(isAnonymous)")
         print("uid:     \(uid)")
         
         UserDefaults.standard.set(uid, forKey: "UID")
         
         
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
            
         }
         print("------------FireBaseログイン情報--------------\n")
      }
      //--------------------FireBaseログイン-----------------------//
      
      //------------------- プッシュ通知-----------------//
      // [START set_messaging_delegate]
      Messaging.messaging().delegate = self
      // [END set_messaging_delegate]
      if #available(iOS 10.0, *) {
         // For iOS 10 display notification (sent via APNS)
         UNUserNotificationCenter.current().delegate = self
         
         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
      } else {
         let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
         application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()
      //------------------- プッシュ通知-----------------//
      
      //------------------- プッシュ通知の赤いやつ消す-----------------//
      UIApplication.shared.applicationIconBadgeNumber = 0
      //------------------- プッシュ通知の赤いやつ消す-----------------//
      
      
      if UserDefaults.standard.bool(forKey: "Logined") == false {
         print("------------SetUp画面を表示する処理をします。--------------\n")
         let SetUpSB = UIStoryboard(name: "UsersSetUpViewControllerSB", bundle: nil)
         let SetUpVC = SetUpSB.instantiateViewController(withIdentifier: "UsersSetUpVC") as! UsersSetUpViewCobtroller
         self.window = UIWindow(frame: UIScreen.main.bounds)
         self.window?.rootViewController = SetUpVC
         isFirestLogin = true
      }
      
      
      
      //-------------------Game Center-----------------//
      if isFirestLogin == true {
         print("初めてのログインなのでゲームセンターはオープンしません")
         return true
      }
      
      print("\n------------Game Center--------------")
      if let rootView = self.window?.rootViewController {
         let player = GKLocalPlayer.local
         
         player.authenticateHandler = {(viewController, error) -> Void in
            if player.isAuthenticated {
               //geme center login
               print("ゲームセンターの認証完了")
               Analytics.logEvent("LoginGameCenter", parameters: nil)
               
            } else if viewController != nil {
               //game center not login. login page open
               print("ゲームセンターにログインしていません。ログインページを表示します。")
               Analytics.logEvent("UserDontLoginGCenter", parameters: nil)
               rootView.present(viewController!, animated: true, completion: nil)
               
            } else {
               if error != nil {
                  //game center login error
                  print("ゲームセンターのログインでエラーが発生しました")
                  Analytics.logEvent("LoginGameCenterError", parameters: nil)
               }
            }
         }
      }
      print("------------Game Center--------------\n")
      //------------------- Game Center-----------------//
      
      InstanceID.instanceID().instanceID { (result, error) in
         if let error = error {
            print("Error fetching remote instance ID: \(error)")
         } else if let result = result {
            print("Remote instance ID token: \(result.token)")
            self.updateFcmToken(FcmToken: result.token)
         }
      }
      
      return true
   }
   
   private func updateFcmToken(FcmToken: String) {
      let UserUID = UserDefaults.standard.string(forKey: "UID")
      if UserUID == nil || UserUID == "" {
         print("多分最初にアプリを起動した(UserUID == nil)")
         return
      }
      
      let isLogined = UserDefaults.standard.bool(forKey: "Logined")
      if isLogined == false {
         print("isLoginedがfalse")
         return
      }
      
      UserDefaults.standard.register(defaults: ["UserDefaultFcmToken": ""])
      let UserDefaultFcmToken = UserDefaults.standard.string(forKey: "UserDefaultFcmToken") ?? ""
      
      //FCMTokenを保存しておいて，それと一致してたらreturnする。そうでなかったら書き込む。これで書き込みが増えるのを防ぐ
      if FcmToken == UserDefaultFcmToken {
         print("FcmTokenは既に保存されてるのと同じなのでFireStoreに書き込みません")
         return
      }
      
      
      if let uid = UserUID {
         let db = Firestore.firestore()
         db.collection("users").document(uid).setData(["FcmToken": FcmToken,], merge: true) { err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(user/に対し)エラー発生し失敗------\n")
            } else {
               print("------ FcmTokenのUpdate(user/に対し)成功しました ------\n")
               print("新しいFCM TokenをUserDefaultsに保存します")
               UserDefaults.standard.set(FcmToken, forKey: "UserDefaultFcmToken")
            }
         }
         
         db.collection("users").document(uid).collection("MonitoredUserInfo").document("UserInfo").setData(["FcmToken": FcmToken,], merge: true) { err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(MonitoredUserInfo/に対し)エラー発生し失敗------\n")
            } else {
               print("------ FcmTokenのUpdate(MonitoredUserInfo/に対し)成功しました ------\n")
            }
         }
         
         db.collectionGroup("Stages").whereField("addUser", isEqualTo: uid).getDocuments() { documentSnapshot, err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(Stage/に対し)エラー発生し失敗------\n")
               return
            }
            
            for doc in documentSnapshot!.documents {
               doc.reference.updateData(["FcmToken": FcmToken])
            }
            print("------ FcmTokenのUpdate(Stage/に対し)成功しました------\n")
         }
         
      }
   }
   


   //MARK:- 元々あったやつ
   func applicationWillResignActive(_ application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(_ application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }
   //MARK: 元々あったやつここまで -
   
   //MARK: 通知のデリゲート
   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      //アプリがバックグラウンドにある間に通知メッセージを受信した場合
      //このコールバックは、ユーザーがアプリケーションを起動する通知をタップするまで起動されません。
      // TODO: 通知データを扱う
      
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      
      // Print message ID.
      if let messageID = userInfo["gcm.message_id"] {
         print("Message ID: \(messageID)")
      }
      
      // Print full message.
      print(userInfo)
   }
   
   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      //アプリがバックグラウンドにある間に通知メッセージを受信した場合
      //このコールバックは、ユーザーがアプリケーションを起動する通知をタップするまで起動されません。
      // TODO: 通知データを扱う
      
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      
      // Print message ID.
      if let messageID = userInfo["gcm.message_id"] {
         print("メッセージID: \(messageID)")
      }
      
      // Print full message.
      print(userInfo)
      
      completionHandler(UIBackgroundFetchResult.newData)
   }
   
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      print("deviceTokenをmessaging()に貼り付けた")
      Messaging.messaging().apnsToken = deviceToken
   }
   
   func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       // APNsの登録えらー
      print("Failed to register to APNs: \(error)")
   }
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo
      
      if let messageID = userInfo["gcm.message_id"] {
         print("メッセージID: \(messageID)")
      }
      
      print(userInfo)
      
      completionHandler([])
   }
   
   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               didReceive response: UNNotificationResponse,
                               withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo
      if let messageID = userInfo["gcm.message_id"] {
         print("メッセージID: \(messageID)")
      }
      
      print(userInfo)
      
      completionHandler()
   }
}

extension AppDelegate : MessagingDelegate {
   //MARK:- START refresh_token
   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")
      
      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: 必要に応じてトークンをアプリケーションサーバーに送信します。
      // Note: このコールバックは、アプリの起動時と新しいトークンが生成されるたびに発生します。
      
      print("新しいFCM TokenをUserDefaultsに保存します")
      UserDefaults.standard.set(fcmToken, forKey: "UserDefaultFcmToken")
      
      let UserUID = UserDefaults.standard.string(forKey: "UID")
      if UserUID == nil || UserUID == "" {
         print("多分最初にアプリを起動した(UserUID == nil)(Delegate)")
         return
      }
      
      let isLogined = UserDefaults.standard.bool(forKey: "Logined")
      if isLogined == false {
         print("isLoginedがfalse(Delegate)")
         return
      }
      
      print("\n------ FCMトークン更新されたので，Firestoreに登録しなおします ------")
      let db = Firestore.firestore()
      let userUID = UserDefaults.standard.string(forKey: "UID")
      
      
      
      if let uid = userUID {
         //setData()を使う時はmergeをtrueにする。
         //こうすることで，Document全体を上書きせずに，そのFieldを追加することができる.
         //ちなみに，updateData()を使うと，Document全体を上書きはされないけど，そのFieldがなかったら失敗する。
         db.collection("users").document(uid).setData(["FcmToken": fcmToken,], merge: true) { err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(user/に対し)エラー発生し失敗------\n")
            } else {
               print("------ FcmTokenのUpdate(user/に対し)成功しました ------\n")
            }
         }
         
         db.collection("users").document(uid).collection("MonitoredUserInfo").document("UserInfo").setData(["FcmToken": fcmToken,], merge: true) { err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(MonitoredUserInfo/に対し)エラー発生し失敗------\n")
            } else {
               print("------ FcmTokenのUpdate(MonitoredUserInfo/に対し)成功しました ------\n")
            }
         }
         
         db.collectionGroup("Stages").whereField("addUser", isEqualTo: uid).getDocuments() { documentSnapshot, err in
            if let err = err {
               print("Error FcmToken updating: \(err)")
               print("------ FcmTokenのUpdate(Stage/に対し)エラー発生し失敗------\n")
               return
            }
            
            for doc in documentSnapshot!.documents {
               doc.reference.updateData(["FcmToken": fcmToken])
            }
            print("------ FcmTokenのUpdate(Stage/に対し)成功しました------\n")
         }
         
         
      } else {
         print("------ userUIDにnilが入ってたので更新しません ------\n")
      }
      
   }
   //MARK: END refresh_token -
   
   //MARK:- START ios_10_data_message
   // アプリがフォアグラウンドにあるときに、iOS 10以降でデータメッセージをFCMから直接（APNをバイパスして）受信する。
   // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
   func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
      print("レシーブデータメッセージ: \(remoteMessage.appData)")
   }
   //MARK: END ios_10_data_message -
}
