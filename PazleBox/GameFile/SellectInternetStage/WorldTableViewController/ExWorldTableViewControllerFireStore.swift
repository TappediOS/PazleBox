//
//  ExWorldTableViewControllerFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/15.
//  Copyright © 2020 jun. All rights reserved.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

enum FetchType {
   case all
   case latest
   case playCount
   case rated
}

extension WorldTableViewController {
   
   //MARK:- ブロックリストをFireStoreからフェッチする
   //で，fetchtypeでその後どれを取得するかを決める
   func FetchBlockListAndBlockedListFromFireStore(FetchType: FetchType) {
      print("\n----- 自分のブロックリストの取得開始 -----")
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation()
      }
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""

      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").getDocument() { document, err in
         if let err = err {
            print("Err: \(err.localizedDescription)")
            print("\n----- 自分のブロックリストの取得失敗 -----")
         }
              
         if let document = document, document.exists {
            //BlockListを取得してStringに直して配列に追加
            if let Block = document.data()?["Block"] as? Array<Any> {
               self.BlockList = Block.filter { ($0 as? String) != nil } as! [String]
            }
            //BlockedListを取得してStringに直して配列に追加
            if let Blocked = document.data()?["Blocked"] as? Array<Any> {
               self.BlockedList = Blocked.filter { ($0 as? String) != nil } as! [String]
            }
         } else {
            print("\n----- 自分のブロックリストの取得失敗(ドキュメントが存在しない) -----")
         }
              
         print("\n----- 自分のブロックリストの取得成功 -----")
         print("Block: \(self.BlockList)")
         switch FetchType {
         case .all:
            self.GetLatestStageDataFromDataBase()
            self.GetRatedStageDataFromDataBase()
            self.GetPlayCountStageDataFromDataBase()
         case .latest:
            self.GetLatestStageDataFromDataBase()
         case .playCount:
            self.GetPlayCountStageDataFromDataBase()
         case .rated:
            self.GetRatedStageDataFromDataBase()
         }
      }
   }
   
   //MARK:- 最新のデータからユーザの名前とプロ画を取得する。
   func FetchLatestStageDataPostUserNameAndProfileImage() {
      for tmp in 0 ..< LatestStageDatas.count {
         let usersUID = LatestStageDatas[tmp]["addUser"] as! String
         
         db.collection("users").document(usersUID).getDocument(){ (document, err) in
            if let err = err {
               print("Error: \(err)")
               print("UID = \(usersUID)")
               print("\n---- データベースからのデータ取得エラー ----")
            } else {
               self.Play3DtouchLight()
               if let document = document, document.exists, let doc = document.data() {
                  let userName = doc["name"] as! String
                  self.LatestStageDatas[tmp].updateValue(userName, forKey: "PostedUsersName")
                  let profileURL = doc["downloadProfileURL"] as! String
                  self.DownloadLatestProfileFromStorege(arrayNum: tmp, downLoadURL: profileURL)
               }
            }
         }
      }
   }
   
   func DownloadLatestProfileFromStorege(arrayNum: Int, downLoadURL: String) {
      let httpsReference = Storage.storage().reference(forURL: downLoadURL)
      
      httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
         if let error = error {
            print("プロ画取得エラー")
            print(error.localizedDescription)
            let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
            self.LatestStageDatas[arrayNum].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
         } else {
            // Data for "images/island.jpg" is returned
            self.LatestStageDatas[arrayNum].updateValue(data!, forKey: "PostedUsersProfileImage")
            self.Play3DtouchSuccess()
         }
         
         self.DownLoadProfileCounterForLatest += 1
         
         if self.DownLoadProfileCounterForLatest == self.LatestStageDatas.count{
            print("---- Latestデータの取得完了 ----\n")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            self.UsingStageDatas = self.LatestStageDatas
            self.WorldTableView.reloadData()
            self.isFetchDataWhenDidLoadThisVC = false //これでリロードできるようになる
         
            //リフレッシュかそうでないかで処理を変える
            if self.RefleshControl.isRefreshing == false {
               self.StopLoadingAnimation()
               print("Delegate設定します。")
               //読み取りが終わってからデリゲードを入れる必要がある
               self.WorldTableView.delegate = self
               self.WorldTableView.dataSource = self
            } else {
               print("---- リフレッシュ中なのでLatestのデータでリロードします ----\n")
               self.RefleshControl.endRefreshing()
            }
         }
      }
   }
   //MARK: 最新のデータからユーザの名前とプロ画を取得するここまで
   
   //MARK:- プレイ回数のデータからユーザの名前とプロ画を取得する。
   func FetchPlayCountStageDataPostUserNameAndProfileImage() {
      for tmp in 0 ..< PlayCountStageDatas.count {
         let usersUID = PlayCountStageDatas[tmp]["addUser"] as! String
         //print("\(usersUID)の名前とプロフィール画像を取得開始")
         
         db.collection("users").document(usersUID).getDocument(){ (document, err) in
            if let err = err {
               print("Error: \(err)")
               print("UID = \(usersUID)")
               print("\n---- データベースからのデータ取得エラー ----")
            } else {
               self.Play3DtouchLight()
               if let document = document, document.exists, let doc = document.data() {
                  let userName = doc["name"] as! String
                  self.PlayCountStageDatas[tmp].updateValue(userName, forKey: "PostedUsersName")
                  let profileURL = doc["downloadProfileURL"] as! String
                  self.DownloadPlayCountProfileFromStorege(arrayNum: tmp, downLoadURL: profileURL)
               }
            }
         }
      }
   }
   
   func DownloadPlayCountProfileFromStorege(arrayNum: Int, downLoadURL: String) {
      let httpsReference = Storage.storage().reference(forURL: downLoadURL)
      
      httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
         if let error = error {
            print("プロ画取得エラー")
            print(error.localizedDescription)
            let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
            self.PlayCountStageDatas[arrayNum].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
         } else {
            self.PlayCountStageDatas[arrayNum].updateValue(data!, forKey: "PostedUsersProfileImage")
            self.Play3DtouchSuccess()
         }
         
         self.DownLoadProfileCounterForPlayCount += 1
         
         if self.DownLoadProfileCounterForPlayCount == self.PlayCountStageDatas.count{
            print("---- PlayCountデータの取得完了 ----\n")
            //リフレッシュ中なら表示をする
            if self.RefleshControl.isRefreshing == true {
               print("---- リフレッシュ中なのでPlayCountのデータでリロードします ----\n")
               self.UsingStageDatas = self.PlayCountStageDatas
               self.WorldTableView.reloadData()
               self.RefleshControl.endRefreshing()
            }
         }
      }
   }
   //MARK: プレイ回数のデータからユーザの名前とプロ画を取得するここまで
   
   //MARK:- 評価順のデータからユーザの名前とプロ画を取得する。
   func FetchRatedStageDataPostUserNameAndProfileImage() {
      for tmp in 0 ..< RatedStageDatas.count {
         let usersUID = RatedStageDatas[tmp]["addUser"] as! String
         
         db.collection("users").document(usersUID).getDocument(){ (document, err) in
            if let err = err {
               print("Error: \(err)")
               print("UID = \(usersUID)")
               print("\n---- データベースからのデータ取得エラー ----")
            } else {
               self.Play3DtouchLight()
               if let document = document, document.exists, let doc = document.data() {
                  let userName = doc["name"] as! String
                  self.RatedStageDatas[tmp].updateValue(userName, forKey: "PostedUsersName")
                  let profileURL = doc["downloadProfileURL"] as! String
                  self.DownloadRatedProfileFromStorege(arrayNum: tmp, downLoadURL: profileURL)
               }
            }
         }
      }
   }
   
   func DownloadRatedProfileFromStorege(arrayNum: Int, downLoadURL: String) {
      let httpsReference = Storage.storage().reference(forURL: downLoadURL)
      
      httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
         if let error = error {
            print("プロ画取得エラー")
            print(error.localizedDescription)
            let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
            self.RatedStageDatas[arrayNum].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
         } else {
            // Data for "images/island.jpg" is returned
            self.RatedStageDatas[arrayNum].updateValue(data!, forKey: "PostedUsersProfileImage")
            self.Play3DtouchSuccess()
         }
         
         self.DownLoadProfileCounterForRated += 1
         
         if self.DownLoadProfileCounterForRated == self.RatedStageDatas.count{
            print("---- Ratedデータの取得完了 ----\n")
            if self.RefleshControl.isRefreshing == true {
               print("---- リフレッシュ中なのでRatedのデータでリロードします ----\n")
               self.UsingStageDatas = self.RatedStageDatas
               self.WorldTableView.reloadData()
               self.RefleshControl.endRefreshing()
            }
         }
      }
   }
   //MARK: 評価順のデータからユーザの名前とプロ画を取得するここまで
   
   //MARK:- 最新のデータを取得する。
   func GetLatestStageDataFromDataBase() {
      print("\n---- Latestデータの取得開始 ----")
      self.LatestStageDatas.removeAll()
      self.DownLoadProfileCounterForLatest = 0
      //最初に開いた時にはくるくるのアニメーションを表示させる
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation() //ローディングアニメーションの再生。
      }
      
      db.collectionGroup("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからのデータ取得エラー ----")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
            } else {
               self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  if let userUID = document["addUser"] as? String, self.BlockList.contains(userUID) {
                     print("\(userUID)をブロックしているのでこいつの最新データは取得しない")
                     continue
                  }
                  if let userUID = document["addUser"] as? String, self.BlockedList.contains(userUID) {
                     print("\(userUID)にブロックされているのでこいつの最新データは取得しない")
                     continue
                  }
                  self.LatestStageDatas.append(self.GetRawData(document: document))
               }
               print("Latestの配列の総数は \(self.LatestStageDatas.count)")
               self.FetchLatestStageDataPostUserNameAndProfileImage()
            }
      }
   }
   
   //MARK:- プレイ回数データを取得する。
   func GetPlayCountStageDataFromDataBase(){
      print("\n---- PlayCountデータの取得開始 ----")
      self.PlayCountStageDatas.removeAll()
      self.DownLoadProfileCounterForPlayCount = 0
      db.collectionGroup("Stages").whereField("PlayCount", isGreaterThanOrEqualTo: 0)
         .order(by: "PlayCount", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("---- データベースからのデータ取得エラー ----\n")
            } else {
               print("PlayCountデータの取得成功")
               for document in querySnapshot!.documents {
                  if let userUID = document["addUser"] as? String, self.BlockList.contains(userUID) {
                     print("\(userUID)をブロックしているのでこいつのプレイ回数データは取得しない")
                     continue
                  }
                  if let userUID = document["addUser"] as? String, self.BlockedList.contains(userUID) {
                     print("\(userUID)にブロックされているのでこいつのプレイ回数データは取得しない")
                     continue
                  }
                  self.PlayCountStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("PlayCountの配列の総数は \(self.PlayCountStageDatas.count)")
            self.FetchPlayCountStageDataPostUserNameAndProfileImage()
      }
   }
   
   //MARK:- 評価のデータを取得する。
   func GetRatedStageDataFromDataBase() {
      print("\n---- Ratedデータの取得開始 ----")
      self.RatedStageDatas.removeAll()
      self.DownLoadProfileCounterForRated = 0
      db.collectionGroup("Stages").whereField("ReviewAve", isGreaterThanOrEqualTo: 0)
         .order(by: "ReviewAve", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからのデータ取得エラー ----\n")
            } else {
               print("Ratedデータの取得成功")
               for document in querySnapshot!.documents {
                  if let userUID = document["addUser"] as? String, self.BlockList.contains(userUID) {
                     print("\(userUID)をブロックしているのでこいつの評価データは取得しない")
                     continue
                  }
                  if let userUID = document["addUser"] as? String, self.BlockedList.contains(userUID) {
                     print("\(userUID)にブロックされているのでこいつの評価データは取得しない")
                     continue
                  }
                  self.RatedStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("Ratedの配列の総数は \(self.PlayCountStageDatas.count)")
            self.FetchRatedStageDataPostUserNameAndProfileImage()
      }
   }
}
