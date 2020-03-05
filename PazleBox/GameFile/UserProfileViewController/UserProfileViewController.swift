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
   private let sectionHeaderHeight: CGFloat = 200
   
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
   
   
   
   
   
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [PiceInfo] {
      var PiceArray: [PiceInfo] = Array()
      let MaxPiceNum = StageDic["MaxPiceNum"] as! Int
         
      for tmp in 1 ... MaxPiceNum {
         let PiceInfomation = PiceInfo()
         let PiceInfoName = "PiceInfo" + String(tmp)
         
         let PiceArrayFromDic = StageDic[PiceInfoName] as! Array<Any>

         PiceInfomation.PiceW = PiceArrayFromDic[0] as! Int
         PiceInfomation.PiceH = PiceArrayFromDic[1] as! Int
         PiceInfomation.ResX = PiceArrayFromDic[2] as! Int
         //転置してるから11から引く必要がある
         //ResPownはのYは下から数えるから
         PiceInfomation.ResY = 11 - (PiceArrayFromDic[3] as! Int)
         PiceInfomation.PiceName = PiceArrayFromDic[4] as! String
         PiceInfomation.PiceColor = PiceArrayFromDic[5] as! String
         
         PiceArray.append(PiceInfomation)
      }
      return PiceArray
   }
      
      
   func GetPiceArrayFromDataBase(StageDic: [String: Any]) -> [[Contents]] {
      var StageArry: [[Contents]] = Array()
      
      //Field1 から　Field12 まで回す
      for tmp in 1 ... 12 {
         var StageXInfo: [Contents] = Array()
         let FieldName = "Field" + String(tmp)
         //FieldXの配列内容をInt型で取得
         //[0, 1, 1, 0, 1, 1, 0] みたいな
         let Field_tmp_Array = StageDic[FieldName] as! Array<Int>
         
         //それをforで回してIn Outを代入する
         for field in Field_tmp_Array {
            if field == 0 {
               StageXInfo.append(Contents.Out)
            }else{
               StageXInfo.append(Contents.In)
            }
         }
         //Contents型を配列に保存
         StageArry.append(StageXInfo)
      }
      
      return StageArry
   }
      
      
   func GetPlayStageInfoFromDataBase(StageDic: [String: Any]) -> PlayStageRefInfo {
      var stageInfo = PlayStageRefInfo()
      
      let refID = StageDic["documentID"] as! String
      let playCount = StageDic["PlayCount"] as! Int
      let reviewCount = StageDic["ReviewCount"] as! Int
      let reviewAve = StageDic["ReviewAve"] as! CGFloat
      
      stageInfo.RefID = refID
      stageInfo.PlayCount = playCount
      stageInfo.ReviewCount = reviewCount
      stageInfo.ReviewAve = reviewAve
      
      return stageInfo
   }
      
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetRawData(document: DocumentSnapshot) -> ([String: Any]) {
      var StageData: [String: Any] =  ["documentID": document.documentID]
      var maxPiceNum: Int = 1
      
      if let value = document["ReviewAve"] as? CGFloat {
            StageData.updateValue(value, forKey: "ReviewAve")
      }
      
      if let value = document["PlayCount"] as? Int {
         StageData.updateValue(value, forKey: "PlayCount")
      }
      
      if let value = document["ReviewCount"] as? Int {
         StageData.updateValue(value, forKey: "ReviewCount")
      }
      
      if let value = document["StageTitle"] as? String {
         StageData.updateValue(value, forKey: "StageTitle")
      } else {
         StageData.updateValue("Nothing", forKey: "StageTitle")
      }
      
      if let value = document["addUser"] as? String {
         StageData.updateValue(value, forKey: "addUser")
      }
      
      if let value = document["addDate"] as? Timestamp {
         let date: Date = value.dateValue()
         
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         StageData.updateValue((dataAsString), forKey: "addDate")
      }
         
      if let value = document["MaxPiceNum"] as? Int {
         StageData.updateValue(value, forKey: "MaxPiceNum")
         maxPiceNum = value
      }
         
      if let value = document["ImageData"] as? Data {
         StageData.updateValue(value, forKey: "ImageData")
      }
      
      for tmp in 1 ... 12 {
         let FieldName = "Field" + String(tmp)
         if let value = document[FieldName] as? Array<Int> {
            StageData.updateValue(value, forKey: FieldName)
         }
      }
      
      for tmp in 1 ... maxPiceNum {
         let PiceName = "PiceInfo" + String(tmp)
         if let value = document[PiceName] as? Array<Any> {
            StageData.updateValue(value, forKey: PiceName)
         }
      }
      
      return StageData
   }
   
   
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

extension UserProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 25
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UserProfileTableView.dequeueReusableCell(withIdentifier: "UserProfileTableCell", for: indexPath) as? UserProfileTableViewCell
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         cell?.UsersPostedStageImageView.image = Image
      }
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      let addDate = UsingStageDatas[indexPath.item]["addDate"] as! String
      
      cell?.UsersPfofileImageView.image = UIImage(named: "person.png")!
      cell?.UsersPostedStageTitleLabel.text = StageTitle
      cell?.UsersPostedStageReviewLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.UsersPostedStagePlayCountLabel.text = String(PlayCount)
      cell?.UsersPostedStageAddDateLabel.text = addDate
      return cell!
   }
   
   //ヘッダーの高さを設定
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return sectionHeaderHeight
   }
   
   //ヘッダーに使うUIViewを返す
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
      //xibファイルから読み込んでヘッダを生成
      let HeaderView = UserProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeaderHeight))
      return HeaderView
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      let UserProfileTapCellViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileTapCellVC") as! UserProfileTapCellViewController
      
      UserProfileTapCellViewController.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      UserProfileTapCellViewController.setUsersName(usersName: "Great Girl")
      
      UserProfileTapCellViewController.setPostUsersStageImage(stageImage: UIImage(named: "23p9Blue.png")!)
      UserProfileTapCellViewController.setPostUsersStageTitle(stageTitle: "Rest MeeE")
         
         
      UserProfileTapCellViewController.setPostUsersStageReview(stageReview: String(floor(Double(4.12) * 100) / 100) + " / 5")
      UserProfileTapCellViewController.setPostUsersStagePlayCount(stagePlayCount: String(382))
         
      self.navigationController?.pushViewController(UserProfileTapCellViewController, animated: true)
   }
   
   
   //スクロールした際にtableviewのヘッダを動かす
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
       /// sectionHeaderが上部に残らないようにする
       let offsetY = scrollView.contentOffset.y
       let safeAreaInset: CGFloat = scrollView.safeAreaInsets.top

       let top: CGFloat
       if offsetY > sectionHeaderHeight{
           /// 一番上のheaderの最下部が画面外へ出ている状態
           top = -(safeAreaInset + sectionHeaderHeight)
       } else if offsetY < -safeAreaInset {
           /// 初期状態からメニューを下に引っ張っている状態
           top = 0
       } else {
           /// safeArea内を一番上のheaderが移動している状態
           top = -(safeAreaInset + offsetY)
       }
       scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
   }
}
