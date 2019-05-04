//
//  AppDelegate.swift
//  PazleBox
//
//  Created by jun on 2019/02/28.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import Crashlytics
import SwiftyStoreKit
import GameKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


      //--------------------FIREBASE-----------------------//
      #if DEBUG
      let fileName = "GoogleService-Info"
      print("テスト環境")
      #else
      let fileName = "GoogleService-Info"
      print("本番のfirebaseにアクセス")
      
      let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")
      let fileopts = FirebaseOptions(contentsOfFile: filePath!)
      
      FirebaseApp.configure(options: fileopts!)
      #endif
      
      //--------------------FIREBASE-----------------------//
      
      //-----------バックグラウンドでの音の再生を許可------------//
      let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
      try! audioSession.setCategory(AVAudioSession.Category.ambient)
      //-----------バックグラウンドでの音の再生を許可------------//
      
      
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      
      
      
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
      //-------------------Init Ad Flag-------------------//
      UserDefaults.standard.register(defaults: ["BuyRemoveAd": false])
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == true {
         print("\n--- ユーザーは広告削除の課金をしています ---\n")
      }else{
         print("\n ---ユーザーは広告削除の課金をしてない. ---\n")
      }
      //-------------------User First Open-----------------//
      //-------------------Init Ad Flag-------------------//
      
      
      
      
      
      //-------------------Game Center-----------------//
      if let rootView = self.window?.rootViewController {
         let player = GKLocalPlayer.local
         
         player.authenticateHandler = {(viewController, error) -> Void in
            if player.isAuthenticated {
               //geme center login
               print("ゲームセンターの認証完了")
               
            } else if viewController != nil {
               //game center not login. login page open
               print("ゲームセンターにログインしていません。ログインページを表示します。")
               rootView.present(viewController!, animated: true, completion: nil)
               
            } else {
               if error != nil {
                  //game center login error
                  print("ゲームセンターのログインでエラーが発生しました")
               }
            }
         }
      }
      //-------------------Game Center-----------------//

      return true
   }

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

}
