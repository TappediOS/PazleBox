//
//  OtherUsersProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/27.
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

class OtherUsersProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var OtherUesrsProfileTableView: UITableView!
   let sectionHeaderHeight: CGFloat = 200
      
   var RefleshControl = UIRefreshControl()
     
   var OtherUsersUID = ""
   
   //こいつにTableVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
   var OtherUsersStageData: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   var PlayStageData = PlayStageRefInfo()
   
   //Firestoreからどれだけとってくるかのやつ。
   let MaxGetStageNumFormDataBase = 21
   var db: Firestore!
   
   let GameSound = GameSounds()
   var LoadActivityView: NVActivityIndicatorView?
   
   var OtherUsersProfileName: String = ""
   var OtherUsersProfileImage = UIImage()
   var OtherusersFollowerNum = 0
   var OtherusersFollowNum = 0
   var OtherusersPlayCountNum = 0
   
   var FollowList = Array<String>()
   var BlockList = Array<String>()
   var BlockedList = Array<String>()
   
   var BlockFlag = false
   var BlockedFlag = false
   var FollowFlag = false
   
   var isLoadingOtherUsersStage = true
      
   override func viewDidLoad() {
      super.viewDidLoad()
      ShowUsersInfo()
      SetUpNavigationController(name: "")
      SetUpUserProfileTableView()
      SetUpRefleshControl()
      
      InitLoadActivityView()
      SetUpFireStoreSetting()
      
      
      //自分のフォローリストとブロックリストを取得した上で，
      //otherUsernの情報を取得する
      GetMyFollowListAndBlockList()
   }
   
   public func fetchOtherUsersUIDbeforPushVC(uid: String) {
      OtherUsersUID = uid
   }
   
   func ShowUsersInfo() {
      print("\n----以下のUserのプロフィールVCを表示します----\n")
      print("UID: \(self.OtherUsersUID)")
      print("---------------------------------\n\n")
   }
   
   func SetUpNavigationController(name: String) {
      self.navigationItem.title = name
      
      let ellipsisItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(TapEllipsisButton(sender:)))
      ellipsisItem.tintColor = .systemGray
      self.navigationItem.setRightBarButton(ellipsisItem, animated: true)
   }
   
   func SetUpUserProfileTableView() {
      OtherUesrsProfileTableView.rowHeight = 160
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      OtherUesrsProfileTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 5 //横幅 viewWide / X　になる。
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / 2 - (Viewsize / 2)
      let StartY = self.view.frame.height / 2 - (Viewsize / 2)
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
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
   
   //ブロックするのにエラーが発生したときの処理
   private func ShowErrBlockUserFireStoreAlertView() {
      Play3DtouchError()
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errDele = NSLocalizedString("errBlock", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errDele + "\n" + checkNet)
   }
   
   //ステージを得るのにエラーした
   func ShowErrGetStageAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         ComleateView.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errGetDoc = NSLocalizedString("errGetDoc", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errGetDoc + "\n" + checkNet)
   }
   
   
      
   func SetUpRefleshControl() {
      self.OtherUesrsProfileTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      if self.isLoadingOtherUsersStage == true {
         print("リロード中です")
         self.RefleshControl.endRefreshing()
         return
      }
      GetMyFollowListAndBlockList()
   }
   
   @objc func TapFollowOrUnFollowButton(_ sender: UIButton) {
      print("FollowOrUnFollowButtonがタップされた")
   }

   //MARK:- BarItemからアクションシート表示
   @objc func TapEllipsisButton(sender: UIBarButtonItem) {
      if BlockList.contains(self.OtherUsersUID) == true {
         print("ブロックしてるからブロックするアクションシートは表示しない")
         return
      }
      print("ellipsisからのアクションシート表示")
      showActionSheetForReportOrBlockUser()
   }
   
   //MARK:- TabelviewCellからアクションシート表示
   @objc func TapOtherUsersPostReportButton(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellの報告ボタンがタップされました")
      showActionSheetForReportOrBlockUser()
   }
   
   private func showActionSheetForReportOrBlockUser() {
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
      let Report = NSLocalizedString("Report", comment: "")
      let ReportAction = UIAlertAction(title: Report, style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPost()
      })
      
      let Block = NSLocalizedString("Block", comment: "")
      let BlockAction = UIAlertAction(title: Block, style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost()
      })
      
      let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCancelタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CancelAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   //ユーザが投稿したものに対してレポートボタンが押されたときの処理
   private func TapReportActionAgainstUsersPost() {
      let Report = NSLocalizedString("Report", comment: "")
      let ReportActionSheet = UIAlertController(title: Report, message: nil, preferredStyle: .actionSheet)
      
      let StringInappropriate = NSLocalizedString("InapCharacters", comment: "")
      let StringInappropriateAction = UIAlertAction(title: StringInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な文字を含むボタンが押された押されたよ")
      })
      let ImageInappropriate = NSLocalizedString("InapImages", comment: "")
      let ImageInappropriateAction = UIAlertAction(title: ImageInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な画像を含むボタンが押された押されたよ")
      })
      
      let Other = NSLocalizedString("Other", comment: "")
      let OtherInappropriateAction = UIAlertAction(title: Other, style: .default, handler: { (action: UIAlertAction!) in
         print("その他ボタンが押された押されたよ")
      })
                      
      let Cancel = NSLocalizedString("Cancel", comment: "")
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ReportActionSheetでCancelタップされた")
      })
      
      ReportActionSheet.addAction(StringInappropriateAction)
      ReportActionSheet.addAction(ImageInappropriateAction)
      ReportActionSheet.addAction(OtherInappropriateAction)
      ReportActionSheet.addAction(CancelAction)
              
      self.present(ReportActionSheet, animated: true, completion: nil)
   }
   
   //ユーザが投稿したものに対してブロックボタンが押されたときの処理
   private func TapBlockActionAgainstUsersPost() {
      let Block = NSLocalizedString("Block", comment: "")
      let BlockAlertSheet = UIAlertController(title: Block + " " + self.OtherUsersProfileName, message: nil, preferredStyle: .alert)
      
      let Cancel = NSLocalizedString("Cancel", comment: "")
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("BlockActionSheetでCancelタップされた")
      })
      
      let BlockAction = UIAlertAction(title: "Block", style: .destructive, handler: { (action: UIAlertAction!) in
         print("Blockします: \(self.OtherUsersUID)")
         self.BlockUserFireStore(blockUsersUID: self.OtherUsersUID)
      })
      
      BlockAlertSheet.addAction(BlockAction)
      BlockAlertSheet.addAction(CancelAction)
      
      self.present(BlockAlertSheet, animated: true, completion: nil)
   }
   
   private func BlockUserFireStore(blockUsersUID: String) {
      print("\n------ Userのブロックを開始しますBlockします ------")
      print("uid: \(self.OtherUsersUID)")
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").updateData([
         "Block": FieldValue.arrayUnion([blockUsersUID]),
         "Follower": FieldValue.arrayRemove([blockUsersUID])
      ]) { err in
         if let err = err {
            print("Error: \(err)")
            print("----- ブロックするのにエラーが発生しました -----\n")
            self.ShowErrBlockUserFireStoreAlertView()
            return
         }
         print("----- ブロックすることに成功しました -----\n")
         self.GetMyFollowListAndBlockList()  //強制リロード
      }
   }
   
   
   private func OtherUsersPresentSomeUsersListVC(ListType: UsersListType) {
      let SomeUsersListSB = UIStoryboard(name: "SomeUsersListViewControllerSB", bundle: nil)
      let SomeUsersListVC = SomeUsersListSB.instantiateViewController(withIdentifier: "SomeUsersListVC") as! SomeUsersListViewController
      
      SomeUsersListVC.setListType(type: ListType)
      SomeUsersListVC.setShowUsersUID(uid: self.OtherUsersUID)
      
      SomeUsersListVC.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(SomeUsersListVC, animated: true)
   }
   
   private func TapUnFollowActionButton() {
      print("\n----- ユーザID\(self.OtherUsersUID)")
      print("のアンフォロー開始 -----")
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").updateData([
         "Follow": FieldValue.arrayRemove([self.OtherUsersUID])
      ]) { err in
         if let err = err {
            print("Err: \(err.localizedDescription)")
            print("----- アンフォロー失敗 -----")
         } else {
            print("----- アンフォロー成功 -----\n")
            self.FollowFlag = false
            self.OtherUesrsProfileTableView.reloadData()
         }
      }
   }
   
   private func TapUnBlockActionButton() {
      print("\n----- ユーザID\(self.OtherUsersUID)")
      print("のブロック解除開始 -----")
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").updateData([
         "Block": FieldValue.arrayRemove([self.OtherUsersUID])
      ]) { err in
         if let err = err {
            print("Error: \(err)")
            print("----- ブロック解除するのにエラーが発生しました -----\n")
            self.ShowErrBlockUserFireStoreAlertView()
            return
         }
         print("----- ブロック解除することに成功しました -----\n")
         self.GetMyFollowListAndBlockList()  //強制リロード
      }
   }
   
   //MARK:- フォローとかblockedとかのボタンが押されたときの処理
   @objc func TapFollwButtonForFollwUser(_ sender: UIButton) {
      print("FollowするためにFollowButtonタップされました")
      print("\n----- ユーザID\(self.OtherUsersUID)")
      print("のフォロー開始 -----")
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(UsersUID).collection("MonitoredUserInfo").document("UserInfo").updateData([
         "Follow": FieldValue.arrayUnion([self.OtherUsersUID])
      ]) { err in
         if let err = err {
            print("Err: \(err.localizedDescription)")
            print("----- フォロー失敗 -----")
         } else {
            print("----- フォロー成功 -----\n")
            self.FollowFlag = true
            self.OtherUesrsProfileTableView.reloadData()
         }
      }
   }
   
   @objc func TapFollowingButtonForUnFollowUser(_ sender: UIButton) {
      print("UnFollowするためにFollowingButtonタップされました")
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let UnFollow = NSLocalizedString("UnFollow", comment: "")
      let title = UnFollow + " " + self.OtherUsersProfileName
      let UnFollowAction = UIAlertAction(title: title, style: .destructive, handler: { (action: UIAlertAction!) in
         print("UnFollowAction押されたよ")
         self.TapUnFollowActionButton()
      })
      
      let Cancel = NSLocalizedString("Cancel", comment: "")
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("UnFollw?でCancelタップされた")
      })
      
      ActionSheet.addAction(UnFollowAction)
      ActionSheet.addAction(CancelAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   @objc func TapBlockedButtonForUnBlockedUser(_ sender: UIButton) {
      print("UnBlockedするためにBlockedButtonタップされました")
      print("UnFollowするためにFollowingButtonタップされました")
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let UnBlock = NSLocalizedString("UnBlock", comment: "")
      let title = UnBlock + " " + self.OtherUsersProfileName
      let UnFollowAction = UIAlertAction(title: title, style: .destructive, handler: { (action: UIAlertAction!) in
         print("UnBlockAction押されたよ")
         self.TapUnBlockActionButton()
      })
      
      let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("UnBlockでCancelタップされた")
      })
      
      ActionSheet.addAction(UnFollowAction)
      ActionSheet.addAction(CancelAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   //MARK:- Labelがタップされたときの処理
   @objc func TapFollowingLabel(_ sender: UITapGestureRecognizer) {
      print("OtherUserでフォローのラベルがタップされました")
      OtherUsersPresentSomeUsersListVC(ListType: .Follow)
   }
   
   @objc func TapFollowerLabel(_ sender: UITapGestureRecognizer) {
      print("OtherUserでフォロワーのラベルがタップされました")
      OtherUsersPresentSomeUsersListVC(ListType: .Follower)
   }
   
   @objc func TapFollowingCountLabel(_ sender: UITapGestureRecognizer) {
      print("OtherUserでフォロー数のラベルがタップされました")
      OtherUsersPresentSomeUsersListVC(ListType: .Follow)
   }
   
   @objc func TapFollowerCountLabel(_ sender: UITapGestureRecognizer) {
      print("OtherUserでフォロワー数のラベルがタップされました")
      OtherUsersPresentSomeUsersListVC(ListType: .Follower)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
