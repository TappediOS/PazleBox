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
      
      let EditProfile = "Edit Profile"
      let EditProfileItem = UIBarButtonItem(title: EditProfile, style: .plain, target: self, action: #selector(TapEditProfileButton(sender:)))
      EditProfileItem.tintColor = .black
      self.navigationItem.setRightBarButton(EditProfileItem, animated: true)
      
      // 左端スワイプで戻るために必要
      //コメントとか画像からMy Pageを参照した時にこれがなかったら，スワイプで戻れない。
      //セッティングボタン置いてなかったらいらん。
      //あと，UIGestureRecognizerDelegateを継承追加するのと，viewWillDisappearでnilを追加するのは忘れたらあかんよ。
      self.navigationController?.interactivePopGestureRecognizer?.delegate = self
      
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("My Page", comment: "")
   }
   
   func SetUpUserProfileTableView() {
      UserProfileTableView.rowHeight = 160
   }
   
   //MARK:- 設定ボタンを押したときの処理
   @objc func TapSettingButton(sender: UIBarButtonItem) {
      print("tap setting")
      let MainStorybord = UIStoryboard(name: "Main", bundle: nil)
      let SettingVC = MainStorybord.instantiateViewController(withIdentifier: "SettingNavigationVC")
      SettingVC.modalPresentationStyle = .fullScreen
      self.present(SettingVC, animated: true, completion: {
         print("設定画面の表示完了\n")
      })
   }
   
   @objc func TapEditProfileButton(sender: UIBarButtonItem) {
      print("tap editProfile")
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
   
   private func ShowErrGetStageAlertView() {
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
   

   //MARK:- 自分のステージデータを取得する。
   private func GetMyStageDataFromDataBase() {
      print("自分のデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      print("UID = \(uid)")
      db.collection("Stages")
         .whereField("addUser", isEqualTo: uid)
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
            print("myデータの取得完了")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            print("Delegate設定します。")
            
            self.GetUsersInfomationFromFireStore()
            
            
            
      }
   }
   
   private func GetUsersInfomationFromFireStore() {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(uid).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            self.SetUsersName(document: document)
            self.GetUsersPfofileImageURL(document: document)
            
         } else {
            print("Document does not exist")
            
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
   }
   
   private func SetUsersName(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         self.userName = userName
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
            self.usersProfileImagfe = UIImage(named: "NoProfileImage.png")!
         } else {
            // Data for "images/island.jpg" is returned
            self.usersProfileImagfe = UIImage(data: data!)!
            self.Play3DtouchSuccess()
         }
         
         //読み取りが終わってからデリゲードを入れる必要がある
         self.UserProfileTableView.delegate = self
         self.UserProfileTableView.dataSource = self
         self.UserProfileTableView.emptyDataSetSource = self
         self.UserProfileTableView.emptyDataSetDelegate = self
         self.UserProfileTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         self.UserProfileTableView.reloadData()
         
         //ローディングアニメーションの停止。
         self.StopLoadingAnimation()
      }
   }
   
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

