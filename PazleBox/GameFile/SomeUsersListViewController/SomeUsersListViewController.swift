//
//  SomeUsersListViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import FirebaseFirestore
import Firebase
import FirebaseStorage
import NVActivityIndicatorView
import SCLAlertView
import DZNEmptyDataSet

enum UsersListType {
   case None
   case Follow
   case Follower
   case Block
}

class SomeUsersListViewController: UIViewController {
   
   
   @IBOutlet weak var SomeUsersListTableView: UITableView!
   
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
   
   let cellHeight: CGFloat = 72
   let proFileImageHeight: CGFloat = 50
   
   var db: Firestore!
   let MaxGetStageNumFormDataBase = 50
   
   var ListType = UsersListType.None
   
   var LoadActivityView: NVActivityIndicatorView?
   
   let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
   var FetchUsersInfoCounter = 0
   var DownLoadProfileCounter = 0
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpListTableView()
      SetUpNavigationController()
      SetUpFireStoreSetting()
      InitLoadActivityView()
      
      switch self.ListType {
      case .None:
         break
      case .Follow:
         GetFollowListFromFireStore()
      case .Follower:
         GetFollowerListFromFireStore()
      case .Block:
         GetBlockListFromFireStore()
      }
   }
   
   func SetUpListTableView() {
      SomeUsersListTableView.rowHeight = cellHeight
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      SomeUsersListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   //TODO:- ローカライズする
   func SetUpNavigationController() {
      var NavigationTitle = "None"
      switch self.ListType {
      case .None:
         NavigationTitle = NSLocalizedString("None", comment: "")
      case .Follow:
         NavigationTitle = NSLocalizedString("Following", comment: "")
      case .Follower:
      NavigationTitle = NSLocalizedString("Follower", comment: "")
      case .Block:
         NavigationTitle = NSLocalizedString("Block", comment: "")
      }
      self.navigationItem.title = NavigationTitle
   }
   
   public func setListType(type: UsersListType) {
      self.ListType = type
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 5
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / 2 - (Viewsize / 2)
      let StartY = self.view.frame.height / 2 - (Viewsize / 2)
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
   }
   
   private func SetTabeleViewDelegate() {
      self.SomeUsersListTableView.delegate = self
      self.SomeUsersListTableView.dataSource = self
      self.SomeUsersListTableView.emptyDataSetSource = self
      self.SomeUsersListTableView.emptyDataSetDelegate = self
      self.SomeUsersListTableView.tableFooterView = UIView()
   }
   
   //MARK:- ローディングアニメーション再生
   func StartLoadingAnimation() {
      print("ローディングアニメーション再生")
      self.LoadActivityView?.startAnimating()
      return
   }
   
   public func StopLoadingAnimation() {
      print("ローディングアニメーション停止")
      if LoadActivityView?.isAnimating == true {
         self.LoadActivityView?.stopAnimating()
      }
   }
   
   private func GetFollowListFromFireStore() {
      self.StartLoadingAnimation()
      self.UsingStageDatas.removeAll()
      db.collection("users").document(self.UsersUID).getDocument() { (document, err) in
         if let err = err {
             print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            if let FollowList = document.data()?["Follow"] as? Array<Any> {
               print("FollowListゲットできた")
               self.FetchUsersInfoInList(FollowList)
            }
         }
      }
   }
   
   private func GetFollowerListFromFireStore() {
      self.StartLoadingAnimation()
      self.UsingStageDatas.removeAll()
      db.collection("users").document(self.UsersUID).getDocument() { (document, err) in
         if let err = err {
             print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            if let FollowList = document.data()?["Follower"] as? Array<Any> {
               print("FollowListゲットできた")
               self.FetchUsersInfoInList(FollowList)
            }
         }
      }
   }
   private func GetBlockListFromFireStore() {
      self.StartLoadingAnimation()
      self.UsingStageDatas.removeAll()
      db.collection("users").document(self.UsersUID).collection("MonitoredUserInfo").document("UserInfo").getDocument() { (document, err) in
         if let err = err {
             print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            if let FollowList = document.data()?["Block"] as? Array<Any> {
               print("FollowListゲットできた")
               self.FetchUsersInfoInList(FollowList)
            }
         }
      }
   }
   
   private func FetchUsersInfoInList(_ List: Array<Any>) {
      let ListStr = ConvArrayAnyToArrayStrint(ArrayAny: List)
      print(ListStr)
      
      let ListCount = ListStr.count
      if ListCount == 0 {
         self.StopLoadingAnimation()
         self.SetTabeleViewDelegate()
         return
      }
      
      for tmp in 0 ..< ListCount {
         let fetchUsersUID = ListStr[tmp]
         db.collection("users").document(fetchUsersUID).getDocument() { doc, err in
            if let err = err {
               print("ユーザのドキュメント取得エラ-")
               print("Err: \(err.localizedDescription)")
            }
            
            if let doc = doc, doc.exists {
               self.UsingStageDatas.append(self.GetRawData(document: doc))
            } else {
               print("ドキュメントが存在しませんでした")
            }
            
            self.FetchUsersInfoCounter += 1
            
            if self.FetchUsersInfoCounter == ListCount {
               print("UserInfoダウンロード完了")
               print("次にプロフィールをダウンロードします")
               self.FetchUsersProfileImage()
            }
            
         }
      }
   }
   
   func FetchUsersProfileImage() {
      for tmp in 0 ..< self.UsingStageDatas.count {
         let URL = self.UsingStageDatas[tmp]["downloadProfileURL"] as! String
         let httpsReference = Storage.storage().reference(forURL: URL)
         
         httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
               print("プロ画取得エラー")
               print(error.localizedDescription)
               let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
               self.UsingStageDatas[tmp].updateValue(errorUsersImage!, forKey: "UsersProfileImage")
            } else {
               // Data for "images/island.jpg" is returned
               self.UsingStageDatas[tmp].updateValue(data!, forKey: "UsersProfileImage")
               self.Play3DtouchSuccess()
            }
            
            self.DownLoadProfileCounter += 1
               
            if self.DownLoadProfileCounter == self.UsingStageDatas.count {
               print("---- プロフィール画像の取得完了 ----\n")
               //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
               //Segmentタップした時に別の関数でCollecti onVie をリロードする。
               self.StopLoadingAnimation()
               self.SetTabeleViewDelegate()
            }
         }
      }
   }
   
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetRawData(document: DocumentSnapshot) -> ([String: Any]) {
      var UsersData: [String: Any] =  ["documentID": document.documentID]
      
      if let value = document["name"] as? String {
         UsersData.updateValue(value, forKey: "name")
      }
      
      if let value = document["usersUID"] as? String {
         UsersData.updateValue(value, forKey: "usersUID")
      }
      
      if let value = document["downloadProfileURL"] as? String {
         UsersData.updateValue(value, forKey: "downloadProfileURL")
      }
      return UsersData
   }
   
   private func ConvArrayAnyToArrayStrint(ArrayAny: Array<Any>) -> [String] {
      var result = Array<String>()
      for tmp in ArrayAny {
         if let str = tmp as? String {
            result.append(str)
         }
      }
      return result
   }
   
   
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
