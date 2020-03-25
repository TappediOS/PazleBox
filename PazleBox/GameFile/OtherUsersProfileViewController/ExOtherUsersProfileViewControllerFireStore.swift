//
//  ExOtherUsersProfileViewControllerFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import RealmSwift
import TapticEngine
import FlatUIKit
import Hero
import Firebase
import FirebaseFirestore
import SCLAlertView
import NVActivityIndicatorView
import DZNEmptyDataSet
import FirebaseStorage
import DZNEmptyDataSet


extension OtherUsersProfileViewController {
   //MARK:- 他のステージデータを取得する。
   func GetOtherUsersStageDataFromDataBase() {
      print("他のユーザのステージデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
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
                  self.UsingStageDatas.append(self.GetRawData(document: document))
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
         
         //読み取りが終わってからデリゲードを入れる必要がある
         self.OtherUesrsProfileTableView.delegate = self
         self.OtherUesrsProfileTableView.dataSource = self
         self.OtherUesrsProfileTableView.emptyDataSetSource = self
         self.OtherUesrsProfileTableView.emptyDataSetDelegate = self
         self.OtherUesrsProfileTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         self.OtherUesrsProfileTableView.reloadData()
         
         //ローディングアニメーションの停止。
         self.StopLoadingAnimation()
      }
   }
}
