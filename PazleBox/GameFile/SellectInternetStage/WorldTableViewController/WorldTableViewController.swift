//
//  WorldTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import FirebaseFirestore
import Firebase
import NVActivityIndicatorView
import SCLAlertView
import TwicketSegmentedControl
import SnapKit

class WorldTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
     
   //それぞれFirestoreでとってきてだいにゅうする。
   var LatestStageDatas: [([String: Any])] = Array()
   var RatedStageDatas: [([String: Any])] = Array()
   var PlayCountStageDatas: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   
   var db: Firestore!
   let MaxGetStageNumFormDataBase = 15
   
   var RefleshControl = UIRefreshControl()
   
   @IBOutlet weak var WorldTableView: UITableView!
   
   var LoadActivityView: NVActivityIndicatorView?
   var segmentedControl: TwicketSegmentedControl?
   
   var CanSellectStage: Bool = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      WorldTableView.rowHeight = 160
      
      SetUpNavigationController()
      InitLoadActivityView()
      SetUpRefleshControl()
      SetUpFireStoreSetting()
      
      GetLatestStageDataFromDataBase()
      GetRatedStageDataFromDataBase()
      GetPlayCountStageDataFromDataBase()
      
      InitSegmentedControl()
   }
   
   //MARK:- segmentのオートレイアウトをしている
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      if #available(iOS 11.0, *) {
         let safeAreTop = self.view.safeAreaInsets.top
         self.segmentedControl?.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(safeAreTop + 12)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(40)
         }
      }
   }
   
   func SetUpNavigationController() {
      //TODO:- ローカライズする
      self.navigationItem.title = NSLocalizedString("World Stage", comment: "")
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
      self.WorldTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   //MARK:- 最新，回数，評価それぞれのデータを取得する。
   private func GetLatestStageDataFromDataBase() {
      print("Latestデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
      db.collection("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
            } else {
               self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  self.LatestStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("Latestデータの取得完了")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            self.UsingStageDatas = self.LatestStageDatas
            print("Delegate設定します。")
               
            //読み取りが終わってからデリゲードを入れる必要がある
            self.WorldTableView.delegate = self
            self.WorldTableView.dataSource = self
            self.WorldTableView.reloadData()
             //ローディングアニメーションの停止
            self.StopLoadingAnimation()
      }
   }
   
   private func GetPlayCountStageDataFromDataBase(){
      print("PlayCountデータの取得開始")
      db.collection("Stages").whereField("PlayCount", isGreaterThanOrEqualTo: 0)
         .order(by: "PlayCount", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
            } else {
               for document in querySnapshot!.documents {
                  self.PlayCountStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("PlayCountデータの取得完了")
      }
   }
   
   private func GetRatedStageDataFromDataBase() {
      print("Ratedデータの取得開始")
      db.collection("Stages").whereField("ReviewAve", isGreaterThanOrEqualTo: 0)
         .order(by: "ReviewAve", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
            } else {
            
               for document in querySnapshot!.documents {
                  self.RatedStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("Ratedデータの取得完了")
      }
   }
   
   private func ShowErrGetStageAlertView() {
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
   private func StartLoadingAnimation() {
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
   
   //MARK:- セグメントのInit
   private func InitSegmentedControl() {
      let Latest = NSLocalizedString("Latest", comment: "")
      let PlayCount = NSLocalizedString("PlayCount", comment: "")
      let Rating = NSLocalizedString("Rating", comment: "")
      let titles = [Latest, PlayCount, Rating]

      segmentedControl = TwicketSegmentedControl()
      segmentedControl?.setSegmentItems(titles)
      segmentedControl?.delegate = self
      
      segmentedControl?.backgroundColor = UIColor.white.withAlphaComponent(0.87)
      
      view.addSubview(segmentedControl!)
   }
      
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
      
   @objc func TapUserImageButtonWorldTableView(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
      
      //本人をタップしてたら，
      if TapedUserIsSelf(rowNum: rowNum) == true {
         print("本人をタップしたので，UesrsProfileVCを表示します")
         let UsersProfileSB = UIStoryboard(name: "UserProfileViewControllerSB", bundle: nil)
         let UsersProfileVC = UsersProfileSB.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
         self.navigationController?.pushViewController(UsersProfileVC, animated: true)
         return
      }
      //本人以外をタップしてたら
      print("他人をタップしたので，OtherUesrsProfileVCを表示します")
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
   
      let OtherUsersUID = UsingStageDatas[rowNum]["addUser"] as! String
      OtherUsersProfileVC.fetchOtherUsersUIDbeforPushVC(uid: OtherUsersUID)
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
   //タップした画像のユーザが本人かどうかを判定する
   private func TapedUserIsSelf(rowNum: Int) -> Bool {
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
