//
//  ExInterNetCellTappedViewControllerFireStore.swift
//  PazleBox
//
//  Created by jun on 2020/03/26.
//  Copyright © 2020 jun. All rights reserved.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit


extension InterNetCellTappedViewController {
   
   //MARK:- ブロックリストをFireStoreからフェッチする
   //で，fetchtypeでその後どれを取得するかを決める
   func FetchBlockListFromFireStore() {
      print("\n----- 自分のブロックリストの取得開始 -----")
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
         } else {
            print("\n----- 自分のブロックリストの取得失敗(ドキュメントが存在しない) -----")
         }
              
         print("\n----- 自分のブロックリストの取得成功 -----")
         print("Block: \(self.BlockList)")
         self.GetStageCommentDataFromFireStore()
      }
   }
   
   
   private func FetchCommentDataPostUserProfileImage() {
      //コメントない時はForぶん回らんからTableViewの設定してreturn
      if UsingCommentedStageDatas.count == 0 {
         self.UsersCommentTableView.delegate = self
         self.UsersCommentTableView.dataSource = self
         self.UsersCommentTableView.emptyDataSetSource = self
         self.UsersCommentTableView.emptyDataSetDelegate = self
         self.UsersCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
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
               
            if self.DownLoadProfileCounter == self.UsingCommentedStageDatas.count{
               print("---- コメントデータの取得完了 ----\n")
               //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
               //Segmentタップした時に別の関数でCollecti onVie をリロードする。
               self.UsersCommentTableView.reloadData()
               print("Delegate設定します。")
               //読み取りが終わってからデリゲードを入れる必要がある
               self.UsersCommentTableView.delegate = self
               self.UsersCommentTableView.dataSource = self
               self.UsersCommentTableView.emptyDataSetSource = self
               self.UsersCommentTableView.emptyDataSetDelegate = self
               self.UsersCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
            }
         }
      }
   }
   
   
   func GetStageCommentDataFromFireStore() {
      print("\n---- コメントデータの取得開始 ----")
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
                  if let userUID = document["CommentUserUID"] as? String, self.BlockList.contains(userUID) {
                     print("\(userUID)をブロックしているのでこいつのコメントデータは取得しない")
                     continue
                  }
                  self.UsingCommentedStageDatas.append(self.GetCommentRaw(document: document))
               }
               print("配列の総数は \(self.UsingCommentedStageDatas.count)")
               self.FetchCommentDataPostUserProfileImage()
            }
      }
   }
}
