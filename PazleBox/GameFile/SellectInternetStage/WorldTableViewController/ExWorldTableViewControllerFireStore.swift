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

extension WorldTableViewController {
   //MARK:- 最新のデータからユーザの名前とプロ画を取得する。
   func FetchLatestStageDataPostUserNameAndProfileImage() {
      for tmp in 0 ..< LatestStageDatas.count {
         let usersUID = LatestStageDatas[tmp]["addUser"] as! String
         print("\(usersUID)の名前とプロフィール画像を取得開始")
         
         db.collection("users").document(usersUID).getDocument(){ (document, err) in
            if let err = err {
               print("Error: \(err)")
               print("UID = \(usersUID)")
               print("\n---- データベースからのデータ取得エラー ----")
            } else {
               self.Play3DtouchLight()
               if let document = document, document.exists, let doc = document.data() {
                  let userName = doc["name"] as! String
                  print("UserName = \(userName)")
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
            print("プロ画取得成功!")
            self.LatestStageDatas[arrayNum].updateValue(data!, forKey: "PostedUsersProfileImage")
            self.Play3DtouchSuccess()
         }
         
         self.DownLoadProfileCounter += 1
         print("ダウンロードカウンター = \(self.DownLoadProfileCounter)")
         print("arryNumカウンター = \(arrayNum)")
         
         if self.DownLoadProfileCounter == self.LatestStageDatas.count{
            print("---- Latestデータの取得完了 ----\n")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            self.UsingStageDatas = self.LatestStageDatas
            self.WorldTableView.reloadData()
         
            //リフレッシュかそうでないかで処理を変える
            if self.RefleshControl.isRefreshing == false {
               self.StopLoadingAnimation()
               print("Delegate設定します。")
               //読み取りが終わってからデリゲードを入れる必要がある
               self.WorldTableView.delegate = self
               self.WorldTableView.dataSource = self
            } else {
               self.RefleshControl.endRefreshing()
            }
         }
      }
   }
   
   //MARK:- 最新，回数，評価それぞれのデータを取得する。
   func GetLatestStageDataFromDataBase() {
      print("\n---- Latestデータの取得開始 ----")
      self.LatestStageDatas.removeAll()
      self.DownLoadProfileCounter = 0
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation() //ローディングアニメーションの再生。
      }
      
      db.collection("Stages")
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
                  self.LatestStageDatas.append(self.GetRawData(document: document))
               }
               print("配列の総数は \(self.LatestStageDatas.count)")
               self.FetchLatestStageDataPostUserNameAndProfileImage()
            }
            
      }
   }
   
   func GetPlayCountStageDataFromDataBase(){
      print("\n---- PlayCountデータの取得開始 ----")
      self.LatestStageDatas.removeAll()
      self.DownLoadProfileCounter = 0
      db.collection("Stages").whereField("PlayCount", isGreaterThanOrEqualTo: 0)
         .order(by: "PlayCount", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("---- データベースからのデータ取得エラー ----\n")
            } else {
               print("PlayCountデータの取得成功")
               for document in querySnapshot!.documents {
                  self.PlayCountStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("---- PlayCountデータの取得完了 ----\n")
      }
   }
   
   
   func GetRatedStageDataFromDataBase() {
      print("\n---- Ratedデータの取得開始 ----")
      self.LatestStageDatas.removeAll()
      self.DownLoadProfileCounter = 0
      db.collection("Stages").whereField("ReviewAve", isGreaterThanOrEqualTo: 0)
         .order(by: "ReviewAve", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからのデータ取得エラー ----\n")
            } else {
               print("Ratedデータの取得成功")
               for document in querySnapshot!.documents {
                  self.RatedStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("---- Ratedデータの取得完了 ----\n")
      }
   }
   
   
   //MARK:- リロード処理
   func ReLoadLatestStageDataFromDataBase() {
      print("\n---- Latestデータの更新開始 ----")
      db.collection("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("---- データベースからのデータ取得エラー ----\n")
            } else {
               print("Latestデータの取得成功")
               self.LatestStageDatas.removeAll()
               for document in querySnapshot!.documents {
                  self.LatestStageDatas.append(self.GetRawData(document: document))
               }
               print("---- Latestデータの更新完了 ----\n")
               self.UsingStageDatas = self.LatestStageDatas
               self.WorldTableView.reloadData()
            }
            self.RefleshControl.endRefreshing()
      }
   }
   
   func ReLoadPlayCountStageDataFromDataBase(){
        print("\n---- PlayCountデータの更新開始 ----")
        db.collection("Stages").whereField("PlayCount", isGreaterThanOrEqualTo: 0)
           .order(by: "PlayCount", descending: true)
           .limit(to: MaxGetStageNumFormDataBase)
           .getDocuments() { (querySnapshot, err) in
              if let err = err {
                 print("Error: \(err)")
                 print("---- データベースからのデータ取得エラー ----\n")
              } else {
                 print("PlayCountデータの取得完了")
                 self.PlayCountStageDatas.removeAll()
                 for document in querySnapshot!.documents {
                    self.PlayCountStageDatas.append(self.GetRawData(document: document))
                 }
                 print("---- PlayCountデータの更新完了 ----\n")
                 self.UsingStageDatas = self.PlayCountStageDatas
                 self.WorldTableView.reloadData()
              }
              self.RefleshControl.endRefreshing()
        }
     }
   
   func ReLoadRatedStageDataFromDataBase() {
      print("\n---- Ratedデータの更新開始 ----")
      db.collection("Stages").whereField("ReviewAve", isGreaterThanOrEqualTo: 0)
         .order(by: "ReviewAve", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("---- データベースからのデータ取得エラー ----\n")
            } else {
               print("Ratedデータの取得成功")
               self.RatedStageDatas.removeAll()
               for document in querySnapshot!.documents {
                  self.RatedStageDatas.append(self.GetRawData(document: document))
               }
               print("---- Ratedデータの更新完了 ----\n")
            }
            self.RefleshControl.endRefreshing()
      }
   }
}
