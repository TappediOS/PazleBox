//
//  InterNetTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/20.
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

class InterNetTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
     
   //それぞれFirestoreでとってきてだいにゅうする。
   var TimeLineData: [([String: Any])] = Array()
   
   @IBOutlet weak var InterNetTableView: UITableView!
   var RefleshControl = UIRefreshControl()
   
   var db: Firestore!
   let MaxGetStageNumFormDataBase = 15
   
   var LoadActivityView: NVActivityIndicatorView?
   
   var DownLoadProfileCounter = 0
   var isFetchDataWhenDidLoadThisVC = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpInterNetTableView()
      SetUpNavigationController()
      
      InitLoadActivityView()
      SetUpRefleshControl()
      SetUpFireStoreSetting()
      
      GetTimeLineDataFromDataBase()
   }
   
   func SetUpInterNetTableView() {
      InterNetTableView.rowHeight = 160
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      InterNetTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   func SetUpNavigationController() {
      //TODO:- ローカライズする
      self.navigationItem.title = NSLocalizedString("Home", comment: "")
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
   
   func SetUpRefleshControl() {
      self.InterNetTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   func ShowErrGetStageAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         ComleateView.dismiss(animated: true)
         self.Play3DtouchHeavy()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errGetDoc = NSLocalizedString("errGetDoc", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errGetDoc + "\n" + checkNet)
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
   
   //MARK:- タイムラインのリロード処理
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      guard self.isFetchDataWhenDidLoadThisVC == false else {
         print("まだ最初のローディングをしている最中なので引っ張って更新はできません")
         RefleshControl.endRefreshing()
         return
      }
      print("TimeLineの更新をします。")
      GetTimeLineDataFromDataBase()
      
   }
   
   @objc func TapUserImageButtonInterNetTableView(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
      
      //本人をタップしてたら，
      if TapedUserIsSelfInTimeLine(rowNum: rowNum) == true {
         print("本人をタップしたので，UesrsProfileVCを表示します")
         let UsersProfileSB = UIStoryboard(name: "UserProfileViewControllerSB", bundle: nil)
         let UsersProfileVC = UsersProfileSB.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
         self.navigationController?.pushViewController(UsersProfileVC, animated: true)
         return
      }
      
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
      
      let OtherUsersUID = UsingStageDatas[rowNum]["addUser"] as! String
      OtherUsersProfileVC.fetchOtherUsersUIDbeforPushVC(uid: OtherUsersUID)
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
   //タップした画像のユーザが本人かどうかを判定する
   private func TapedUserIsSelfInTimeLine(rowNum: Int) -> Bool {
      let TapedUsersUID = UsingStageDatas[rowNum]["addUser"] as! String
      let UsersUID = UserDefaults.standard.string(forKey: "UID")
      
      if TapedUsersUID == UsersUID { return true}
      return false
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

