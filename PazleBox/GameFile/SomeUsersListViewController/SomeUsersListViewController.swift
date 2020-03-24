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
      
      self.SomeUsersListTableView.delegate = self
      self.SomeUsersListTableView.dataSource = self
      self.SomeUsersListTableView.emptyDataSetSource = self
      self.SomeUsersListTableView.emptyDataSetDelegate = self
      self.SomeUsersListTableView.tableFooterView = UIView()
   }
   
   func SetUpListTableView() {
      SomeUsersListTableView.rowHeight = cellHeight
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
   
      db.collection("users").document(self.UsersUID).getDocument() { (document, err) in
         if let err = err {
             print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            if let FollowList = document.data()?["Follow"] as? Array<Any> {
               print("FollowListゲットできた")
               self.FetchUsersNameAndImageInList(FollowList)
            }
         }
      }
   }
   
   private func FetchUsersNameAndImageInList(_ List: Array<Any>) {
      let ListStr = ConvArrayAnyToArrayStrint(ArrayAny: List)
      print(ListStr)
      
      
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
   
   private func GetFollowerListFromFireStore() {
      self.StartLoadingAnimation()
   }
   private func GetBlockListFromFireStore() {
      self.StartLoadingAnimation()
   }
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
