//
//  UserProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/24.
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

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
   
   @IBOutlet weak var UserProfileTableView: UITableView!
   
   //画面遷移するときに選択されているcellのIndexPath
   var UserProfileTableViewSellectedIndexPath = IndexPath()
   
   let sectionHeaderHeight: CGFloat = 200
   
   var RefleshControl = UIRefreshControl()
   
   //こいつにTableVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
   var MyStageData: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   var PlayStageData = PlayStageRefInfo()
   
   //Firestoreからどれだけとってくるかのやつ。
   let MaxGetStageNumFormDataBase = 21
   var db: Firestore!
   
   let GameSound = GameSounds()
   var LoadActivityView: NVActivityIndicatorView?
   
   var userName: String = ""
   var usersProfileImagfe = UIImage()
   var usersFollowerNum = 0
   var usersFollowNum = 0
   var usersPlayCountNum = 0
   
   var isLoadingProfile = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpNavigationController()
      SetUpUserProfileTableView()
      SetUpRefleshControl()
      
      InitLoadActivityView()
      SetUpFireStoreSetting()
      //自分の取得する
      GetMyStageDataFromDataBase()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      let isCangeProfile = UserDefaults.standard.bool(forKey: "ChangeUsersProfileInEditionVC")
      if isCangeProfile == false {
         print("プロフィールの変更は起きていません")
         return
      }
      
      GetMyStageDataFromDataBase()
      UserDefaults.standard.set(false, forKey: "ChangeUsersProfileInEditionVC")
   }
   
   override func viewWillDisappear(_ animated: Bool) {
       //スワイプで戻る処理を無効にする
       self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      print("viewがAppearされた後")
      CheckDeletedUsersStage()
   }
   
   func CheckDeletedUsersStage() {
      let isDeletedUsersStage = UserDefaults.standard.bool(forKey: "isDeleteUsersPostedCell")
      if isDeletedUsersStage == false {
         print("ユーザのステージは削除されていません")
         return
      }
      print("ユーザのステージが削除されています")
      let DeletedUsersStageCellNum = UserDefaults.standard.integer(forKey: "DeleteUsersPostedCellNum")
      print("\(DeletedUsersStageCellNum) 番目のcellが削除されています")
      
      self.UsingStageDatas.remove(at: DeletedUsersStageCellNum)
      UserProfileTableView.deleteRows(at: [UserProfileTableViewSellectedIndexPath], with: .automatic)
      ReSetUserDefaultsDeletedStage()
   }
   
   func ReSetUserDefaultsDeletedStage() {
      UserDefaults.standard.set(false, forKey: "isDeleteUsersPostedCell")
      UserDefaults.standard.set(0, forKey: "DeleteUsersPostedCellNum")
      UserDefaults.standard.synchronize()
   }
   
   func SetUpNavigationController() {
      var image = UIImage()
      if #available(iOS 13, *) {
         image = UIImage(systemName: "gear")!
      } else {
         image = UIImage(named: "Gear.png")!
      }
      
      let SettingButtonItems = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(TapSettingButton(sender:)))
      SettingButtonItems.tintColor = .black
      self.navigationItem.setLeftBarButton(SettingButtonItems, animated: true)
      
      let EditProfile = NSLocalizedString("EditProfile", comment: "")
      let EditProfileItem = UIBarButtonItem(title: EditProfile, style: .plain, target: self, action: #selector(TapEditProfileButton(sender:)))
      EditProfileItem.tintColor = .black
      self.navigationItem.setRightBarButton(EditProfileItem, animated: true)
      
      // 左端スワイプで戻るために必要
      //コメントとか画像からMy Pageを参照した時にこれがなかったら，スワイプで戻れない。
      //セッティングボタン置いてなかったらいらん。
      //あと，UIGestureRecognizerDelegateを継承追加するのと，viewWillDisappearでnilを追加するのは忘れたらあかんよ。
      self.navigationController?.interactivePopGestureRecognizer?.delegate = self
      
      self.navigationItem.title = NSLocalizedString("MyPage", comment: "")
   }
   
   func SetUpUserProfileTableView() {
      UserProfileTableView.rowHeight = 160
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      UserProfileTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   //MARK:- 設定ボタンを押したときの処理
   @objc func TapSettingButton(sender: UIBarButtonItem) {
      guard self.isLoadingProfile == false else {
         print("プロフィール読み込み中です")
         return
      }
      print("tap setting")
      let MainStorybord = UIStoryboard(name: "Main", bundle: nil)
      let SettingVC = MainStorybord.instantiateViewController(withIdentifier: "SettingNavigationVC")
      SettingVC.modalPresentationStyle = .fullScreen
      self.present(SettingVC, animated: true, completion: {
         print("設定画面の表示完了\n")
      })
   }
   
   //MARK:- プロフィール編集ボタン押された
   @objc func TapEditProfileButton(sender: UIBarButtonItem) {
      guard self.isLoadingProfile == false else {
         print("プロフィール読み込み中です")
         return
      }
      print("tap editProfile")
      //名前とプロ画は保存してから画面遷移する。
      UserDefaults.standard.set(self.usersProfileImagfe.pngData() as! NSData, forKey: "UserProfileImageData")
      UserDefaults.standard.set(self.userName, forKey: "UserProfileName")
      let EditProfileSB = UIStoryboard(name: "EditProfileViewControllerSB", bundle: nil)
      let EditProfileVC = EditProfileSB.instantiateViewController(withIdentifier: "EditProfileVCNavigationController")
      EditProfileVC.modalPresentationStyle = .fullScreen
      self.present(EditProfileVC, animated: true, completion: {
         print("EditProfileVCの表示完了\n")
      })
   }
   
   func SetUpRefleshControl() {
      self.UserProfileTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
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
   

   
   
   
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      if isLoadingProfile == true {
         print("リロード中です")
         self.RefleshControl.endRefreshing()
         return
      }
      Analytics.logEvent("ReloadDataUserProfileVC", parameters: nil)
      GetMyStageDataFromDataBase()
   }
   
   
   private func PresentSomeUsersListVC(ListType: UsersListType) {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      let SomeUsersListSB = UIStoryboard(name: "SomeUsersListViewControllerSB", bundle: nil)
      let SomeUsersListVC = SomeUsersListSB.instantiateViewController(withIdentifier: "SomeUsersListVC") as! SomeUsersListViewController
      
      SomeUsersListVC.setListType(type: ListType)
      SomeUsersListVC.setShowUsersUID(uid: uid)
      
      SomeUsersListVC.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(SomeUsersListVC, animated: true)
   }
   
   //MARK:- Labelがタップされたときの処理
   @objc func TapFollowingLabel(_ sender: UITapGestureRecognizer) {
      print("フォローのラベルがタップされました")
      Analytics.logEvent("TapFollowButtonUsersProfileVC", parameters: nil)
      PresentSomeUsersListVC(ListType: .Follow)
   }
   
   @objc func TapFollowerLabel(_ sender: UITapGestureRecognizer) {
      print("フォロワーのラベルがタップされました")
      Analytics.logEvent("TapFollowerButtonUsersProfileVC", parameters: nil)
      PresentSomeUsersListVC(ListType: .Follower)
   }
   
   @objc func TapFollowingCountLabel(_ sender: UITapGestureRecognizer) {
      print("フォロー数のラベルがタップされました")
      Analytics.logEvent("TapFollowButtonUsersProfileVC", parameters: nil)
      PresentSomeUsersListVC(ListType: .Follow)
   }
   
   @objc func TapFollowerCountLabel(_ sender: UITapGestureRecognizer) {
      print("フォロワー数のラベルがタップされました")
      Analytics.logEvent("TapFollowerButtonUsersProfileVC", parameters: nil)
      PresentSomeUsersListVC(ListType: .Follower)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

