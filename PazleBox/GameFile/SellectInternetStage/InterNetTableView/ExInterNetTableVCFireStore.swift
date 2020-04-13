//
//  ExInterNetTableVCFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/24.
//  Copyright © 2020 jun. All rights reserved.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

extension InterNetTableViewController {
   //MARK:- TimeLineのデータからユーザの名前とプロ画を取得する。
   func FetchTimeLineStageDataPostUserNameAndProfileImage() {
      for tmp in 0 ..< TimeLineData.count {
         let usersUID = TimeLineData[tmp]["addUser"] as! String
         
         db.collection("users").document(usersUID).getDocument(){ (document, err) in
            if let err = err {
               print("Error: \(err)")
               print("UID = \(usersUID)")
               print("\n---- データベースからのデータ取得エラー ----")
            } else {
               if let document = document, document.exists, let doc = document.data() {
                  let userName = doc["name"] as! String
                  self.TimeLineData[tmp].updateValue(userName, forKey: "PostedUsersName")
                  let profileURL = doc["downloadProfileURL"] as! String
                  self.DownloadTimeLineProfileFromStorege(arrayNum: tmp, downLoadURL: profileURL)
               }
            }
         }
      }
   }
   
   func DownloadTimeLineProfileFromStorege(arrayNum: Int, downLoadURL: String) {
      let httpsReference = Storage.storage().reference(forURL: downLoadURL)
      
      httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
         if let error = error {
            print("プロ画取得エラー")
            print(error.localizedDescription)
            let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
            self.TimeLineData[arrayNum].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
         } else {
            // Data for "images/island.jpg" is returned
            self.TimeLineData[arrayNum].updateValue(data!, forKey: "PostedUsersProfileImage")
         }
         
         self.DownLoadProfileCounter += 1
         
         if self.DownLoadProfileCounter == self.TimeLineData.count{
            print("---- TimeLineデータの取得完了 ----\n")
            self.setReloadTableViewOnBasedRefleshControl()
         }
      }
   }
   //MARK: TimeLineのデータからユーザの名前とプロ画を取得するここまで
   
   private func setReloadTableViewOnBasedRefleshControl() {
      self.UsingStageDatas = self.TimeLineData
      self.isFetchDataWhenDidLoadThisVC = false //これでリロードできるようになる
      
      if self.RefleshControl.isRefreshing == false {
         self.StopLoadingAnimation()
         print("Delegate設定します。")
         self.Play3DtouchSuccess()
         //読み取りが終わってからデリゲードを入れる必要がある
         self.InterNetTableView.delegate = self
         self.InterNetTableView.dataSource = self
         self.InterNetTableView.emptyDataSetSource = self
         self.InterNetTableView.emptyDataSetDelegate = self
         self.InterNetTableView.tableFooterView = UIView()
      } else {
         print("---- リフレッシュ中なのでTimeLineのデータでリロードします ----\n")
         self.RefleshControl.endRefreshing()
         self.InterNetTableView.reloadData()
      }
   }

   //MARK:- TimeLineのデータを取得する。
   func GetTimeLineDataFromDataBase() {
      print("\n---- TimeLieデータの取得開始 ----")
      let UsersUID = UserDefaults.standard.string(forKey: "UID")
      self.TimeLineData.removeAll()
      self.DownLoadProfileCounter = 0
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation() //ローディングアニメーションの再生。
      }
      
      db.collectionGroup("Stages")
         .whereField("ShowTimeLineUserUID", arrayContains: UsersUID ?? "")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからTimeLineのデータ取得エラー ----\n")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
            } else {
               for document in querySnapshot!.documents {
                  self.TimeLineData.append(self.GetRawData(document: document))
               }
            }
            print("TimeLineの配列の総数は \(self.TimeLineData.count)")
            
            //配列の総数が0のときはそのままdelegateを設定する
            if self.TimeLineData.count == 0 {
               self.setReloadTableViewOnBasedRefleshControl()
               return
            }
            
            
            self.FetchTimeLineStageDataPostUserNameAndProfileImage()
      }
   }
}
