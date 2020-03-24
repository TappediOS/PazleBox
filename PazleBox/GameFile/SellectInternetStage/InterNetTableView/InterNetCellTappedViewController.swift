//
//  InterNetCellTappedViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/21.
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
import FirebaseStorage
import DZNEmptyDataSet

class InterNetCellTappedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var PostUsersImageView: UIImageView!
   @IBOutlet weak var PostUsersUserNBameLabel: UILabel!
   
   @IBOutlet weak var PostUsersStageImageView: UIImageView!
   @IBOutlet weak var PostUsersStageTitleLabel: UILabel!
   
   @IBOutlet weak var PostUsersStageReviewLabel: UILabel!
   @IBOutlet weak var PostUsersStagePlayCountLabel: UILabel!
   @IBOutlet weak var PostUsersStagePlayBuutton: UIButton!

   var PostusersImage = UIImage()
   var PostUsersUserName = ""
   var PostUsersStageImage = UIImage()
   var PostUsersStageTitle = ""
   var PostUsersStageReivew = ""
   var PostUsersStagePlayCount = ""
   
   var PostUsersProfileURL = ""
   var PostUsersUID = ""
   var PostedStageCommentID = ""
   var PostedUsersFcmToken = ""
   
   @IBOutlet weak var UsersCommentTableView: UITableView!

   let ButtonCornerRadius: CGFloat = 6.5
   
   let GameSound = GameSounds()
   
   //GameSceneを読み込むのに必要なデータ
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   var PlayStageData = PlayStageRefInfo()
   
   var isLoadingGameVC = false
   
   private var RefleshControl = UIRefreshControl()
   
   var db: Firestore!
   let MaxGetCommentNumFormDataBase = 40
   var DownLoadProfileCounter = 0
   
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingCommentedStageDatas: [([String: Any])] = Array()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpUsersCommentTableView()
      SetUpNavigationController()
      InitPostUsersImageView()
      InitPostUsersUserNBameLabel()
      InitPostUsersStageImageView()
      InitPostUsersStageTitleLabel()
      InitPostUsersStageReviewLabel()
      InitPostUsersStagePlayCountLabel()
      SetUpPostUsersStagePlayButton()
      SetUpRefleshControl()
      
      SetUpFireStoreSetting()
      GetStageCommentDataFromFireStore()
      
      
      
   }
   
   func SetUpUsersCommentTableView() {
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      UsersCommentTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   func SetUpNavigationController() {
      //TODO:- ローカライズする
      self.navigationItem.title = NSLocalizedString("Stage", comment: "")
   }
   
   private func SetUpPostUsersStagePlayButton() {
      let title = NSLocalizedString("Play", comment: "")
      PostUsersStagePlayBuutton.setTitle(title, for: .normal)
      PostUsersStagePlayBuutton.titleLabel?.adjustsFontSizeToFitWidth = true
      PostUsersStagePlayBuutton.titleLabel?.adjustsFontForContentSizeCategory = true
      PostUsersStagePlayBuutton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 18)
      PostUsersStagePlayBuutton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      PostUsersStagePlayBuutton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      PostUsersStagePlayBuutton.layer.cornerRadius =  ButtonCornerRadius
   }
   
   private func SetUpRefleshControl() {
      self.UsersCommentTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadCommentDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   //MARK:- viewDidLoadで画面遷移前に取得した各値をセットする
   func InitPostUsersImageView() {
      self.PostUsersImageView.image = self.PostusersImage
   }
   func InitPostUsersUserNBameLabel() {
      self.PostUsersUserNBameLabel.text = self.PostUsersUserName
      self.PostUsersUserNBameLabel.adjustsFontSizeToFitWidth = true
      self.PostUsersUserNBameLabel.minimumScaleFactor = 0.4
   }
   func InitPostUsersStageImageView() {
      self.PostUsersStageImageView.image = self.PostUsersStageImage
      self.PostUsersStageImageView.contentMode = .scaleAspectFill
   }
   func InitPostUsersStageTitleLabel() {
      self.PostUsersStageTitleLabel.text = self.PostUsersStageTitle
      self.PostUsersStageTitleLabel.adjustsFontSizeToFitWidth = true
      self.PostUsersStageTitleLabel.minimumScaleFactor = 0.4
   }
   func InitPostUsersStageReviewLabel() {
      self.PostUsersStageReviewLabel.text = self.PostUsersStageReivew
   }
   func InitPostUsersStagePlayCountLabel() {
      self.PostUsersStagePlayCountLabel.text = self.PostUsersStagePlayCount
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   
   //MARK:- 画面遷移する前にポストユーザの画面の各値をセットする
   public func setUsersImage(usersImage: UIImage) {
      self.PostusersImage = usersImage
   }
   
   public func setUsersName(usersName: String) {
      self.PostUsersUserName = usersName
   }
   
   public func setPostUsersStageImage(stageImage: UIImage) {
      self.PostUsersStageImage = stageImage
   }
   
   public func setPostUsersStageTitle(stageTitle: String) {
      self.PostUsersStageTitle = stageTitle
   }
   
   public func setPostUsersStageReview(stageReview: String) {
      self.PostUsersStageReivew = stageReview
   }
   
   public func setPostUsersStagePlayCount(stagePlayCount: String) {
      self.PostUsersStagePlayCount = stagePlayCount
   }
   
   public func setPostUsersUID(postUsersUID: String) {
      self.PostUsersUID = postUsersUID
   }
   
   public func setPostUsersProfileURL(postUsersProfileURL: String) {
      self.PostUsersProfileURL = postUsersProfileURL
   }
   
   public func setPostedStageCommentID(CommentID: String) {
      self.PostedStageCommentID = CommentID
   }
   
   public func setFcmToken(FcmToken: String) {
      self.PostedUsersFcmToken = FcmToken
   }
   
   //MARK:- 画面遷移する前にプレイするステージデータをセットする
   public func setPiceArray(_ piceArray: [PiceInfo]) {
      self.PiceArray = piceArray
   }
   
   public func setStageArray(_ stageArray: [[Contents]]) {
      self.StageArray = stageArray
   }
   
   public func setPlayStageData(_ playStageData: PlayStageRefInfo) {
      self.PlayStageData = playStageData
   }
   
   
   private func FetchCommentDataPostUserProfileImage() {
      //コメントない時はForぶん回らんからTableViewの設定してreturn
      if UsingCommentedStageDatas.count == 0 {
         self.UsersCommentTableView.delegate = self
         self.UsersCommentTableView.dataSource = self
         self.UsersCommentTableView.emptyDataSetSource = self
         self.UsersCommentTableView.emptyDataSetDelegate = self
         self.UsersCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
         return
      }
      
      for tmp in 0 ..< UsingCommentedStageDatas.count {
         let URL = UsingCommentedStageDatas[tmp]["CommentUsersProfileURL"] as! String
         let httpsReference = Storage.storage().reference(forURL: URL)
         
         httpsReference.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
               print("プロ画取得エラー")
               print(error.localizedDescription)
               let errorUsersImage = UIImage(named: "NoProfileImage.png")?.pngData()
               self.UsingCommentedStageDatas[tmp].updateValue(errorUsersImage!, forKey: "PostedUsersProfileImage")
            } else {
               // Data for "images/island.jpg" is returned
               self.UsingCommentedStageDatas[tmp].updateValue(data!, forKey: "CommentedUsersProfileImage")
               self.Play3DtouchSuccess()
            }
            
            self.DownLoadProfileCounter += 1
               
            if self.DownLoadProfileCounter == self.UsingCommentedStageDatas.count{
               print("---- コメントデータの取得完了 ----\n")
               //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
               //Segmentタップした時に別の関数でCollecti onVie をリロードする。
               self.UsersCommentTableView.reloadData()
            
               //リフレッシュかそうでないかで処理を変える
               if self.RefleshControl.isRefreshing == false {
                  //self.StopLoadingAnimation()
                  print("Delegate設定します。")
                  //読み取りが終わってからデリゲードを入れる必要がある
                  self.UsersCommentTableView.delegate = self
                  self.UsersCommentTableView.dataSource = self
                  self.UsersCommentTableView.emptyDataSetSource = self
                  self.UsersCommentTableView.emptyDataSetDelegate = self
                  self.UsersCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
               } else {
                  self.RefleshControl.endRefreshing()
               }
            }
         }
      }
   }
   
   
   private func GetStageCommentDataFromFireStore() {
      print("\n---- コメントデータの取得開始 ----")
      let DocID = self.PostedStageCommentID
      
      db.collection("StageComment").document(DocID).collection("Comment")
         .order(by: "AddDate", descending: true)
         .limit(to: MaxGetCommentNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("Error: \(err)")
               print("\n---- データベースからのデータ取得エラー ----")
               //self.Play3DtouchError()
               //self.ShowErrGetStageAlertView()
            } else {
               //self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  self.UsingCommentedStageDatas.append(self.GetCommentRaw(document: document))
               }
               print("配列の総数は \(self.UsingCommentedStageDatas.count)")
               self.FetchCommentDataPostUserProfileImage()
            }
      }
   }
   
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetCommentRaw(document: DocumentSnapshot) -> ([String: Any]) {
      var CommentData: [String: Any] =  ["documentID": document.documentID]
      
      if let value = document["AddDate"] as? Timestamp {
         let date: Date = value.dateValue()
         
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         CommentData.updateValue((dataAsString), forKey: "AddDate")
      }
      
      if let value = document["CommentBody"] as? String {
         CommentData.updateValue(value, forKey: "CommentBody")
      }
      
      if let value = document["CommentID"] as? String {
         CommentData.updateValue(value, forKey: "ReviewAve")
      }
      
      if let value = document["CommentUserUID"] as? String {
         CommentData.updateValue(value, forKey: "CommentUserUID")
      }
      
      if let value = document["CommentUsersProfileURL"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersProfileURL")
      }
      
      if let value = document["isPublished"] as? Bool {
         CommentData.updateValue(value, forKey: "isPublished")
      }
      
      if let value = document["CommentUsersName"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersName")
      }
      
      return CommentData
   }
   
   //MARK:- コメントのリロードを行う
   @objc func ReloadCommentDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
   
   //MARK:- プレイボタン押されたときの処理
   @IBAction func TapPostUsersStagePlayButton(_ sender: Any) {
      print("ユーザステージのプレイボタンタップされた")
      PostUsersStagePlayBuutton.isEnabled = false //2度押し禁止する処理
      isLoadingGameVC = true
      PresentGameViewController()
   }
   
   /// GameVCをプレゼントする関数
   func PresentGameViewController() {
      //GameSound.PlaySoundsTapButton()
      let CleateSB = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let GameVC = CleateSB.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      GameVC.LoadUsersInfo()
      GameVC.LoadUsersNameOfPostedStages(name: self.PostUsersUserName)
      GameVC.LoadLoadUsersUIDOfPostedStages(postedUsersUID: self.PostUsersUID)
      GameVC.LoadUsersProfileImageURLOfPostedStages(profileURL: self.PostUsersProfileURL)
      GameVC.LoadStageCommentIDofPostedStages(CommentID: self.PostedStageCommentID)
      GameVC.LoadPostedUsersFcmToken(PostedUsersFcmToken: self.PostedUsersFcmToken)
      
      GameVC.LoadPiceArray(PiceArray: PiceArray)
      GameVC.LoadStageArray(StageArray: StageArray)
      GameVC.LoadPlayStageData(RefID: PlayStageData.RefID, stageDataForNoDocExsist: self.PlayStageData)
      GameVC.modalPresentationStyle = .fullScreen
      //HomeViewに対してBGMを消してって通知を送る
      NotificationCenter.default.post(name: .StopHomeViewBGM, object: nil, userInfo: nil)
      self.present(GameVC, animated: true, completion: {
         print("プレゼント終わった")
         self.PostUsersStagePlayBuutton.isEnabled = true //ボタンロック解除
         self.isLoadingGameVC = false
      })
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
   
   //TODO: ローカライズすること
   @IBAction func TapPostUsersStageReportButton(_ sender: Any) {
      print("ユーザステージの報告ボタンタップされた")

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
   
   
   //コメントしたユーザの報告ボタンがタップされたときの処理
   //TODO:- ローカライズね。
   @objc func TapReportCommentedUserTableViewCell(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellのユーザの報告ボタンがタップされました")
      
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let Report = NSLocalizedString("Report", comment: "")
      let Block = NSLocalizedString("Block", comment: "")
      let Cansel = NSLocalizedString("Cansel", comment: "")
             
      let ReportAction = UIAlertAction(title: Report, style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPost()
      })
      
      let BlockAction = UIAlertAction(title: Block, style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost()
      })
      
      let CanselAction = UIAlertAction(title: Cansel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCanselタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CanselAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   //コメントしたユーザの画像がタップされたときの処理
   @objc func TapCommentedUsersImageViewButtonInterNetTableView(_ sender: UIButton) {
      guard self.isLoadingGameVC == false else {
         print("コメントしたユーザの画像タップされたけど，ローディング中やから何もしない.")
         return
      }
      
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
      
      //本人をタップしてたら，
      if TapedCommentedUserIsSelf(rowNum: rowNum) == true {
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
      
      let OtherUsersUID = UsingCommentedStageDatas[rowNum]["CommentUserUID"] as! String
      OtherUsersProfileVC.fetchOtherUsersUIDbeforPushVC(uid: OtherUsersUID)
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
   //タップした画像のユーザが本人かどうかを判定する
   private func TapedCommentedUserIsSelf(rowNum: Int) -> Bool {
      let TapedUsersUID = UsingCommentedStageDatas[rowNum]["CommentUserUID"] as! String
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

extension InterNetCellTappedViewController {
   //セクションの数を返す
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   //テーブルの行数を返す
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return UsingCommentedStageDatas.count
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UsersCommentTableView.dequeueReusableCell(withIdentifier: "UsersCommentCell", for: indexPath) as? UsersCommentTableViewCell
      
      let usersProfileData = UsingCommentedStageDatas[indexPath.item]["CommentedUsersProfileImage"] as? NSData
      if let ProfileData = usersProfileData {
         let Image = UIImage(data: ProfileData as Data)
         cell?.CommentedUsersImageViewButton.setImage(Image, for: .normal)
      }
      
      let UserName = UsingCommentedStageDatas[indexPath.item]["CommentUsersName"] as! String
      let CommentBody = UsingCommentedStageDatas[indexPath.item]["CommentBody"] as! String
      
      cell?.CommentedUsersImageViewButton.tag = indexPath.row
      cell?.CommentedUsersImageViewButton.addTarget(self, action: #selector(TapCommentedUsersImageViewButtonInterNetTableView(_:)), for: .touchUpInside)
      
      
      cell?.CommentedUsersNameLabel.text = UserName
      cell?.CommentedUsersCommentLabel.text = CommentBody
      
      cell?.ReportUserButton.tag = indexPath.row
      cell?.ReportUserButton.addTarget(self, action: #selector(TapReportCommentedUserTableViewCell(_:)), for: .touchUpInside)
      

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)

      
   }
}


//TODO:- ローカライズすること
extension InterNetCellTappedViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("No Comment", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("No Comment Yet", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}

