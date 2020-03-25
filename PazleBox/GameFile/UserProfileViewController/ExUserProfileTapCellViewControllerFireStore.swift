//
//  ExUserProfileTapCellViewControllerFireStore.swift
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

extension UserProfileTapCellViewController {
   private func FetchCommentDataPostUserProfileImage() {
      //コメントない時はForぶん回らんからTableViewの設定してreturn
      if UsingCommentedStageDatas.count == 0 {
         self.UsersStageCommentTableView.delegate = self
         self.UsersStageCommentTableView.dataSource = self
         self.UsersStageCommentTableView.emptyDataSetSource = self
         self.UsersStageCommentTableView.emptyDataSetDelegate = self
         self.UsersStageCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         return
      }
      
      for tmp in 0 ..< UsingCommentedStageDatas.count {
         let URL = UsingCommentedStageDatas[tmp]["CommentUsersProfileURL"] as! String
         let httpsReference = Storage.storage().reference(forURL: URL)
         
         httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
               print("プロ画取得エラー")
               print(error.localizedDescription)
               let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
               self.UsingCommentedStageDatas[tmp].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
            } else {
               // Data for "images/island.jpg" is returned
               self.UsingCommentedStageDatas[tmp].updateValue(data!, forKey: "CommentedUsersProfileImage")
               self.Play3DtouchSuccess()
            }
            
            self.DownLoadProfileCounter += 1
               
            if self.DownLoadProfileCounter == self.UsingCommentedStageDatas.count {
               print("---- 自分のステージのコメントデータの取得完了 ----\n")
               //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
               //Segmentタップした時に別の関数でCollecti onVie をリロードする。
               self.UsersStageCommentTableView.reloadData()
               //読み取りが終わってからデリゲードを入れる必要がある
               self.UsersStageCommentTableView.delegate = self
               self.UsersStageCommentTableView.dataSource = self
               self.UsersStageCommentTableView.emptyDataSetSource = self
               self.UsersStageCommentTableView.emptyDataSetDelegate = self
               self.UsersStageCommentTableView.tableFooterView = UIView()
            }
         }
      }
   }
   
   func GetUsersStageCommentDataFromFireStore() {
      print("\n---- 自分のステージのコメントデータの取得開始 ----")
      let DocID = self.PostedStageCommentID
      
      db.collection("StageComment").document(DocID).collection("Comment")
         .order(by: "AddDate", descending: true)
         .limit(to: MaxGetCommentNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからのデータ取得エラー ----")
               //self.Play3DtouchError()
               //self.ShowErrGetStageAlertView()
            } else {
               //self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  self.UsingCommentedStageDatas.append(self.GetCommentRaw(document: document))
               }
               print("自分のステージのコメントの総数は \(self.UsingCommentedStageDatas.count)")
               self.FetchCommentDataPostUserProfileImage()
            }
      }
   }
   
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetCommentRaw(document: DocumentSnapshot) -> ([String: Any]) {
      var CommentData: [String: Any] =  ["documentID": document.documentID]
      
      if let value = document["AddDate"] as? Timestamp {
         let date: Date = value.dateValue()
         
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         CommentData.updateValue((dataAsString), forKey: "AddDate")
      }
      
      if let value = document["CommentBody"] as? String {
         CommentData.updateValue(value, forKey: "CommentBody")
      }
      
      if let value = document["CommentID"] as? String {
         CommentData.updateValue(value, forKey: "ReviewAve")
      }
      
      if let value = document["CommentUserUID"] as? String {
         CommentData.updateValue(value, forKey: "CommentUserUID")
      }
      
      if let value = document["CommentUsersProfileURL"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersProfileURL")
      }
      
      if let value = document["isPublished"] as? Bool {
         CommentData.updateValue(value, forKey: "isPublished")
      }
      
      if let value = document["CommentUsersName"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersName")
      }
      
      return CommentData
   }
}
