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

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var UserProfileTableView: UITableView!
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
      
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("My Page", comment: "")
   }
   
   func SetUpUserProfileTableView() {
      UserProfileTableView.rowHeight = 160
   }
   
   //MARK:- 設定ボタンを押したときの処理
   @objc func TapSettingButton(sender: UIBarButtonItem) {
      print("tap setting")
   }
   
   @objc func TapEditProfileButton(sender: UIBarButtonItem) {
      print("tap editProfile")
      let EditProfileSB = UIStoryboard(name: "EditProfileViewControllerSB", bundle: nil)
      let EditProfileVC = EditProfileSB.instantiateViewController(withIdentifier: "EditProfileVCNavigationController")
      EditProfileVC.modalPresentationStyle = .fullScreen
      
      self.present(EditProfileVC, animated: true, completion: nil)
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
               self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  //GetRawData()はEXファイルに存在している。
                  self.UsingStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("myデータの取得完了")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            print("Delegate設定します。")
            
            //読み取りが終わってからデリゲードを入れる必要がある
            self.UserProfileTableView.delegate = self
            self.UserProfileTableView.dataSource = self
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

