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

class OtherUsersProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var OtherUesrsProfileTableView: UITableView!
   private let sectionHeaderHeight: CGFloat = 200
      
   var RefleshControl = UIRefreshControl()
     
   var OtherUsersUID = ""
   
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
      ShowUsersInfo()
      SetUpNavigationController(name: "")
      SetUpUserProfileTableView()
      SetUpRefleshControl()
      
      InitLoadActivityView()
      SetUpFireStoreSetting()
      //その人の取得する
      GetOtherUsersStageDataFromDataBase()
         
      self.OtherUesrsProfileTableView.rowHeight = 160
      self.OtherUesrsProfileTableView.delegate = self
      self.OtherUesrsProfileTableView.dataSource = self
      self.OtherUesrsProfileTableView.emptyDataSetSource = self
      self.OtherUesrsProfileTableView.emptyDataSetDelegate = self
      self.OtherUesrsProfileTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
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
   }
   
   func SetUpUserProfileTableView() {
      OtherUesrsProfileTableView.rowHeight = 160
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
   
   //MARK:- 他のステージデータを取得する。
   private func GetOtherUsersStageDataFromDataBase() {
      print("他のユーザのステージデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
      let uid = self.OtherUsersUID
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
            print("他のユーザのステージデータの取得完了")
            print("続いて，他のユーザのユーザ情報を取得します。")
            self.GetOtherUsersInfomationFromFireStore()
      }
   }
   
   private func GetOtherUsersInfomationFromFireStore() {
      db.collection("users").document(self.OtherUsersUID).getDocument { (document, err) in
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
            self.ShowErrGetStageAlertView()
            self.StopLoadingAnimation()
         }
         print("ユーザネームとプレイ回数のデータの取得完了")
      }
   }
   
   private func SetUsersName(document: DocumentSnapshot) {
      if let userName = document.data()?["name"] as? String {
         SetUpNavigationController(name: userName)
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
         self.OtherUesrsProfileTableView.delegate = self
         self.OtherUesrsProfileTableView.dataSource = self
         self.OtherUesrsProfileTableView.emptyDataSetSource = self
         self.OtherUesrsProfileTableView.emptyDataSetDelegate = self
         self.OtherUesrsProfileTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         self.OtherUesrsProfileTableView.reloadData()
         
         //ローディングアニメーションの停止。
         self.StopLoadingAnimation()
      }
   }
      
   func SetUpRefleshControl() {
      self.OtherUesrsProfileTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
   
   @objc func TapFollowOrUnFollowButton(_ sender: UIButton) {
      print("FollowOrUnFollowButtonがタップされた")
   }
   
   @objc func TapOtherUsersPostReportButton(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellの報告ボタンがタップされました")
      
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
             
      let ReportAction = UIAlertAction(title: "Report", style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPost()
      })
      
      let BlockAction = UIAlertAction(title: "Block", style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost()
      })
      
      let CanselAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCanselタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CanselAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   //ユーザが投稿したものに対してレポートボタンが押されたときの処理
   //TODO: ローカライズすること
   private func TapReportActionAgainstUsersPost() {
      let ReportActionSheet = UIAlertController(title: "Report", message: nil, preferredStyle: .actionSheet)
      
      let StringInappropriate = "Contains illegal characters"
      let StringInappropriateAction = UIAlertAction(title: StringInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な文字を含むボタンが押された押されたよ")
      })
      let ImageInappropriate = "Contains inappropriate images"
      let ImageInappropriateAction = UIAlertAction(title: ImageInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な画像を含むボタンが押された押されたよ")
      })
      
      let Other = "Other"
      let OtherInappropriateAction = UIAlertAction(title: Other, style: .default, handler: { (action: UIAlertAction!) in
         print("その他ボタンが押された押されたよ")
      })
                      
      let CanselAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("ReportActionSheetでCanselタップされた")
      })
           
              
      ReportActionSheet.addAction(StringInappropriateAction)
      ReportActionSheet.addAction(ImageInappropriateAction)
      ReportActionSheet.addAction(OtherInappropriateAction)
      ReportActionSheet.addAction(CanselAction)
              
      self.present(ReportActionSheet, animated: true, completion: nil)
   }
   
   //ユーザが投稿したものに対してブロックボタンが押されたときの処理
   //TODO: ローカライズすること
   private func TapBlockActionAgainstUsersPost() {
      let BlockAlertSheet = UIAlertController(title: "Block", message: nil, preferredStyle: .alert)
      
      let CanselAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("BlockActionSheetでCanselタップされた")
      })
      
      let BlockAction = UIAlertAction(title: "Block", style: .destructive, handler: { (action: UIAlertAction!) in
         print("Blockします。")
      })
      
      BlockAlertSheet.addAction(BlockAction)
      BlockAlertSheet.addAction(CanselAction)
      
      self.present(BlockAlertSheet, animated: true, completion: nil)
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}


extension OtherUsersProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.OtherUesrsProfileTableView.dequeueReusableCell(withIdentifier: "OtherUsersProfileCell", for: indexPath) as? OtherUsersProfileTableViewCell
      
      cell?.OtherUsersPostReportButton.tag = indexPath.row
      cell?.OtherUsersPostReportButton.addTarget(self, action: #selector(TapOtherUsersPostReportButton(_:)), for: .touchUpInside)

      return cell!
   }
   
   //ヘッダーの高さを設定
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return sectionHeaderHeight
   }
   
   //ヘッダーに使うUIViewを返す
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
      //xibファイルから読み込んでヘッダを生成
      let HeaderView = OtherUsersProfileTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeaderHeight))
      let followButton = HeaderView.getFollowOrUnFollowButton()
      followButton.addTarget(self, action: #selector(TapFollowOrUnFollowButton(_:)), for: .touchUpInside)
      return HeaderView
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      //InterNetTableVCのcellタップイベントと同様にして画面遷移すればいい。
      let InterNetTableVCSB = UIStoryboard(name: "InterNetTableView", bundle: nil)
      let InterNetCellTappedVC = InterNetTableVCSB.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      InterNetCellTappedVC.setPostUsersStageImage(stageImage: UIImage(named: "23p2Red")!)
      InterNetCellTappedVC.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      InterNetCellTappedVC.setUsersName(usersName: "Supar Boy")
      
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: "Drop Card")
      
      
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: "1.92 / 5 ")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: "542")
      
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
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

//TODO:- ローカライズすること
extension OtherUsersProfileViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("ステージ投稿なし", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("ステージが投稿されたら表示されます", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}
