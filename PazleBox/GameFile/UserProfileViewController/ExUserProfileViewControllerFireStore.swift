//
//  ExUserProfileViewControllerFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Hero
import Firebase
import FirebaseFirestore
import SCLAlertView
import NVActivityIndicatorView
import DZNEmptyDataSet
import FirebaseStorage

extension UserProfileViewController {
   //MARK:- 自分のステージデータを取得する。
   func GetMyStageDataFromDataBase() {
      print("自分のステージデータの取得開始")
      isLoadingProfile = true
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation() //ローディングアニメーションの再生。
      }
      self.MyStageData.removeAll() //データ取得する前に，配列を空にする
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      print("UID = \(uid)")
      db.collection("users").document(uid).collection("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
               self.RefleshControl.endRefreshing()
            } else {
               
               for document in querySnapshot!.documents {
                  //GetRawData()はEXファイルに存在している。
                  self.MyStageData.append(self.GetRawData(document: document))
               }
            }
            print("自分のステージデータの取得完了")
            print("続いて，自分のユーザ情報の取得開始")
            self.GetUsersInfomationFromFireStore()
      }
   }
   
   private func GetUsersInfomationFromFireStore() {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(uid).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            
            if let FollowArray = document.data()?["Follow"] as? Array<Any> {
               self.usersFollowNum = FollowArray.count
            }
            if let FollowerArray = document.data()?["Follower"] as? Array<Any> {
               self.usersFollowerNum = FollowerArray.count
            }
            if let PlayCount = document.data()?["ClearStageCount"] as? Int {
               self.usersPlayCountNum = PlayCount
            }
            
            self.GetUsersPfofileImageURL(document: document)
            
            
         } else {
            print("Document does not exist")
            self.ShowErrGetStageAlertView()
            self.StopLoadingAnimation()
            self.RefleshControl.endRefreshing()
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
      
      //名前の取得はMonitoredUserInfoから行う。
   db.collection("users").document(uid).collection("MonitoredUserInfo").document("UserInfo").getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            self.SetUsersName(document: document)
         } else {
            print("Document does not exist")
            self.ShowErrGetStageAlertView()
            self.StopLoadingAnimation()
            self.RefleshControl.endRefreshing()
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
   }
   
   private func SetUsersName(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         self.userName = userName
      }
   }
   
   private func GetUsersPfofileImageURL(document: DocumentSnapshot) {
      if let downLoadUrlAsString = document.data()?["downloadProfileURL"] as? String {
         print("データベースからえたプロ画のURL = \(downLoadUrlAsString)")
         self.DownloadProfileFromStorege(downLoadURL: downLoadUrlAsString)
      }
   }
   
   private func DownloadProfileFromStorege(downLoadURL: String) {
      let httpsReference = Storage.storage().reference(forURL: downLoadURL)
      
      httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
         if let error = error {
            print("プロ画取得エラー")
            print(error.localizedDescription)
            self.usersProfileImagfe = UIImage(named: "NoProfileImage.png")!
         } else {
            // Data for "images/island.jpg" is returned
            print("プロ画取得成功!")
            self.usersProfileImagfe = UIImage(data: data!)!
            self.Play3DtouchSuccess()
         }
         
         self.UsingStageDatas = self.MyStageData
         self.isLoadingProfile = false
         
         if self.RefleshControl.isRefreshing {
            self.RefleshControl.endRefreshing()
            self.UserProfileTableView.reloadData()
            return
         }
         
         //読み取りが終わってからデリゲードを入れる必要がある
         self.UserProfileTableView.delegate = self
         self.UserProfileTableView.dataSource = self
         self.UserProfileTableView.emptyDataSetSource = self
         self.UserProfileTableView.emptyDataSetDelegate = self
         self.UserProfileTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         self.UserProfileTableView.reloadData()
         //ローディングアニメーションの停止。
         self.StopLoadingAnimation()
      }
   }
}
