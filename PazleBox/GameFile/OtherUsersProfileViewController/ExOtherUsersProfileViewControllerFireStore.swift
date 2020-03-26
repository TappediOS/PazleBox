//
//  ExOtherUsersProfileViewControllerFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import SCLAlertView
import DZNEmptyDataSet
import FirebaseStorage
import DZNEmptyDataSet

extension OtherUsersProfileViewController {
   
   func GetMyFollowListAndBlockList() {
      isLoadingOtherUsersStage = true
      print("\n----- 自分のフォロワーとブロックリストの取得開始 -----")
      if self.RefleshControl.isRefreshing == false {
         self.StartLoadingAnimation()
      }
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").getDocument() { document, err in
         if let err = err {
            print("Err: \(err.localizedDescription)")
            print("\n----- 自分のフォロワーとブロックリストの取得失敗 -----")
         }
         
         if let document = document, document.exists {
            if let Follow = document.data()?["Follow"] as? Array<Any> {
               self.FollowList = Follow.filter { ($0 as? String) != nil } as! [String]
            }
            if let Block = document.data()?["Block"] as? Array<Any> {
               self.BlockList = Block.filter { ($0 as? String) != nil } as! [String]
            }
            if let Blocked = document.data()?["Blocked"] as? Array<Any> {
               self.BlockedList = Blocked.filter { ($0 as? String) != nil } as! [String]
            }
         } else {
            print("\n----- 自分のフォロワーとブロックリストの取得失敗(ドキュメントが存在しない) -----")
         }
         
         print("\n----- 自分のフォロワーとブロックリストの取得成功 -----")
         print("Follow: \(self.FollowList)")
         print("Block: \(self.BlockList)")
         print("Blocked: \(self.BlockedList)")
         self.ConditionalBranchingBasedOnFollowBlockBlockedList()
      }
   }
   
   //関数GetMyFollowListAndBlockList()で取得したリストに基づいて条件分岐をする
   func ConditionalBranchingBasedOnFollowBlockBlockedList() {
      let otherUID = self.OtherUsersUID
      self.OtherUsersStageData.removeAll()
      //相手をブロックしていたときの処理
      //FollowボタンをBlockedにすれば良い
      //その上でステージとか投稿とかは全て0で扱う。
      //さらに，フォロワーとかの表示はできなくする
      if self.BlockList.contains(otherUID) {
         self.BlockFlag = true
         GetOtherUsersInfomationFromFireStore()
         return
      } else {
         self.BlockFlag = false
      }
      //相手にブロックされていたときの処理
      if self.BlockedList.contains(otherUID) {
         self.BlockedFlag = true
         self.isLoadingOtherUsersStage = false
         GetOtherUsersInfomationFromFireStore()
         return
      } else {
         self.BlockedFlag = false
      }
      //相手をフォローしていたときの処理
      //FollowボタンをFollowingにすれば良い
      if self.FollowList.contains(otherUID) {
         self.FollowFlag = true
         GetOtherUsersStageDataFromDataBase()
         return
      } else {
         self.FollowFlag = false
      }
      
      //他のステージデータを取得する。
      GetOtherUsersStageDataFromDataBase()
   }
   
   //MARK:- 他のステージデータを取得する。
   func GetOtherUsersStageDataFromDataBase() {
      print("他のユーザのステージデータの取得開始")
      
      let uid = self.OtherUsersUID
      print("UID = \(uid)")
            
      db.collection("users").document(uid).collection("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
            } else {
               
               for document in querySnapshot!.documents {
                  //GetRawData()はEXファイルに存在している。
                  self.OtherUsersStageData.append(self.GetRawData(document: document))
               }
            }
            print("他のユーザのステージデータの取得完了")
            print("続いて，他のユーザのユーザ情報を取得します。")
            self.GetOtherUsersInfomationFromFireStore()
      }
   }
   
   private func GetOtherUsersInfomationFromFireStore() {
      db.collection("users").document(self.OtherUsersUID).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            if let FollowArray = document.data()?["Follow"] as? Array<Any> {
               self.OtherusersFollowNum = FollowArray.count
            }
            if let FollowerArray = document.data()?["Follower"] as? Array<Any> {
               self.OtherusersFollowerNum = FollowerArray.count
            }
            if let PlayCount = document.data()?["ClearStageCount"] as? Int {
               self.OtherusersPlayCountNum = PlayCount
            }
            self.SetUsersName(document: document)
            self.GetUsersPfofileImageURL(document: document)
            
         } else {
            print("Document does not exist")
            self.ShowErrGetStageAlertView()
            self.StopLoadingAnimation()
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
   }
   
   private func SetUsersName(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         self.OtherUsersProfileName = userName
         SetUpNavigationController(name: self.OtherUsersProfileName)
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
            self.OtherUsersProfileImage = UIImage(named: "NoProfileImage.png")!
         } else {
            // Data for "images/island.jpg" is returned
            print("プロ画取得成功!")
            self.OtherUsersProfileImage = UIImage(data: data!)!
            self.Play3DtouchSuccess()
         }
         self.isLoadingOtherUsersStage = false
         self.UsingStageDatas = self.OtherUsersStageData
         
         if self.RefleshControl.isRefreshing == true {
            self.isLoadingOtherUsersStage = false
            self.RefleshControl.endRefreshing()
            self.OtherUesrsProfileTableView.reloadData()
            return
         }
         
         self.setTabeleviewDelegate()
         //ローディングアニメーションの停止。
         self.StopLoadingAnimation()
      }
   }
   
   func setTabeleviewDelegate() {
      //読み取りが終わってからデリゲードを入れる必要がある
      self.OtherUesrsProfileTableView.delegate = self
      self.OtherUesrsProfileTableView.dataSource = self
      self.OtherUesrsProfileTableView.emptyDataSetSource = self
      self.OtherUesrsProfileTableView.emptyDataSetDelegate = self
      self.OtherUesrsProfileTableView.tableFooterView = UIView()
      self.OtherUesrsProfileTableView.reloadData()
   }
}
