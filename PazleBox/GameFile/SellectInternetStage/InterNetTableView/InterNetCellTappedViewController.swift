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
   
   
   var db: Firestore!
   let MaxGetCommentNumFormDataBase = 40
   var DownLoadProfileCounter = 0
   
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingCommentedStageDatas: [([String: Any])] = Array()
   
   var BlockList = Array<String>()
   var BlockedList = Array<String>()
   
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
      
      SetUpFireStoreSetting()
      FetchBlockListAndBlockedListFromFireStore()
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
   
 
   //MARK:- viewDidLoadで画面遷移前に取得した各値をセットする
   func InitPostUsersImageView() {
      self.PostUsersImageView.image = self.PostusersImage
      self.PostUsersImageView.layer.cornerRadius = self.PostUsersImageView.frame.width / 2
      self.PostUsersImageView.layer.masksToBounds = true
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
      let errDele = NSLocalizedString("errBlock", comment: "") //TODO: ローカライズする
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errDele + "\n" + checkNet)
   }
   
   
   //MARK:- プレイボタン押されたときの処理
   @IBAction func TapPostUsersStagePlayButton(_ sender: Any) {
      print("ユーザステージのプレイボタンタップされた")
      PostUsersStagePlayBuutton.isEnabled = false //2度押し禁止する処理
      isLoadingGameVC = true
      PresentGameViewController()
   }
   
   //MARK:- GameVCをプレゼントする関数
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
   
   //MARK:- コメントをFireStoreに登録する
   //MARK: 不適切な文字を含むコメント
   private func ReportCommentIncludeStringInappropriate(TappedCellNum: Int) {
      print("\n------ 不適切な文字を含むコメントをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      let CommentID = UsingCommentedStageDatas[TappedCellNum]["CommentID"] as! String
      let CommentBody = UsingCommentedStageDatas[TappedCellNum]["CommentBody"] as! String
      let CommentUserUID = UsingCommentedStageDatas[TappedCellNum]["CommentUserUID"] as! String
      let CommentUserName = UsingCommentedStageDatas[TappedCellNum]["CommentUsersName"] as! String
      let CommentUsersProfileURL = UsingCommentedStageDatas[TappedCellNum]["CommentUsersProfileURL"] as! String
      
      db.collection("Report").document("CommentReport").collection("StringInappropriateComment").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "CommentID": CommentID,
         "CommentBody": CommentBody,
         "CommentUserUID": CommentUserUID,
         "CommentUserName": CommentUserName,
         "CommentUsersProfileURL": CommentUsersProfileURL,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切な文字を含むコメントをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切な文字を含むコメントをFirestoreに登録成功 ------\n")
      }
   }
   //MARK: 不適切な画像を含むコメント
   private func ReportCommentIncludeImageInappropriate(TappedCellNum: Int) {
      print("\n------ 不適切な画像を含むコメントをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      let CommentID = UsingCommentedStageDatas[TappedCellNum]["CommentID"] as! String
      let CommentBody = UsingCommentedStageDatas[TappedCellNum]["CommentBody"] as! String
      let CommentUserUID = UsingCommentedStageDatas[TappedCellNum]["CommentUserUID"] as! String
      let CommentUserName = UsingCommentedStageDatas[TappedCellNum]["CommentUsersName"] as! String
      let CommentUsersProfileURL = UsingCommentedStageDatas[TappedCellNum]["CommentUsersProfileURL"] as! String
      
      db.collection("Report").document("CommentReport").collection("ImageInappropriateComment").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "CommentID": CommentID,
         "CommentBody": CommentBody,
         "CommentUserUID": CommentUserUID,
         "CommentUserName": CommentUserName,
         "CommentUsersProfileURL": CommentUsersProfileURL,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切な画像を含むコメントをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切な画像を含むコメントをFirestoreに登録成功 ------\n")
      }
   }
   //MARK: その他のコメント
   private func ReportCommentOther(TappedCellNum: Int) {
      print("\n------ 不適切なその他を含むコメントをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      let CommentID = UsingCommentedStageDatas[TappedCellNum]["CommentID"] as! String
      let CommentBody = UsingCommentedStageDatas[TappedCellNum]["CommentBody"] as! String
      let CommentUserUID = UsingCommentedStageDatas[TappedCellNum]["CommentUserUID"] as! String
      let CommentUserName = UsingCommentedStageDatas[TappedCellNum]["CommentUsersName"] as! String
      let CommentUsersProfileURL = UsingCommentedStageDatas[TappedCellNum]["CommentUsersProfileURL"] as! String
      
      db.collection("Report").document("CommentReport").collection("OtherComment").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "CommentID": CommentID,
         "CommentBody": CommentBody,
         "CommentUserUID": CommentUserUID,
         "CommentUserName": CommentUserName,
         "CommentUsersProfileURL": CommentUsersProfileURL,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切なその他を含むコメントをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切なその他を含むコメントをFirestoreに登録成功 ------\n")
      }
   }
   //MARK:- コメントをFireStoreに登録するここまで
   
   //MARK:- StageをFireStoreに登録する
   //MARK: 不適切な文字を含むStage
   private func ReportStageIncludeStringInappropriate(TappedCellNum: Int) {
      print("\n------ 不適切な文字を含むStageをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      db.collection("Report").document("StageReport").collection("StringInappropriateStage").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "ReportedUsersUID": self.PostUsersUID,
         "ReportedUserName": self.PostUsersUserName,
         "ReportedProfileURL": self.PostUsersProfileURL,
         "ReportedStageTitle": self.PostUsersStageTitle,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切な文字を含むStageをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切な文字を含むStageをFirestoreに登録成功 ------\n")
      }
   }
   //MARK: 不適切な画像を含むStage
   private func ReportStageIncludeImageInappropriate(TappedCellNum: Int) {
      print("\n------ 不適切な画像を含むStageをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      db.collection("Report").document("StageReport").collection("ImageInappropriateStage").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "ReportedUsersUID": self.PostUsersUID,
         "ReportedUserName": self.PostUsersUserName,
         "ReportedProfileURL": self.PostUsersProfileURL,
         "ReportedStageTitle": self.PostUsersStageTitle,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切な画像を含むStageをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切な画像を含むStageをFirestoreに登録成功 ------\n")
      }
   }
   //MARK: その他のStage
   private func ReportStageOther(TappedCellNum: Int) {
      print("\n------ 不適切なその他を含むStageをFirestoreに登録開始 ------")
      let ReportUserUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      db.collection("Report").document("StageReport").collection("OtherStage").addDocument(data: [
         "ReportUserUID": ReportUserUID,
         "ReportedUsersUID": self.PostUsersUID,
         "ReportedUserName": self.PostUsersUserName,
         "ReportedProfileURL": self.PostUsersProfileURL,
         "ReportedStageTitle": self.PostUsersStageTitle,
         "ReportedDay": FieldValue.serverTimestamp()
      ]) { err in
         if let err = err {
            print("Error: \(err.localizedDescription)")
            print("------ 不適切なその他を含むStageをFirestoreに登録失敗 ------\n")
            return
         }
         print("------ 不適切なその他を含むStageをFirestoreに登録成功 ------\n")
      }
   }
   //MARK:- StageをFireStoreに登録するここまで
   
   
   //MARK:- ユーザが投稿したコメントに対してレポートボタンが押されたときの処理
   //TODO: ローカライズすること
   private func TapReportActionAgainstUsersPostComment(TappedCellNum: Int) {
      let ReportActionSheet = UIAlertController(title: "Report", message: nil, preferredStyle: .actionSheet)
      
      let StringInappropriate = "Contains illegal characters"
      let StringInappropriateAction = UIAlertAction(title: StringInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な文字を含むボタンが押された押されたよ")
         self.ReportCommentIncludeStringInappropriate(TappedCellNum: TappedCellNum)
      })
      let ImageInappropriate = "Contains inappropriate images"
      let ImageInappropriateAction = UIAlertAction(title: ImageInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な画像を含むボタンが押された押されたよ")
         self.ReportCommentIncludeImageInappropriate(TappedCellNum: TappedCellNum)
      })
      
      let Other = "Other"
      let OtherInappropriateAction = UIAlertAction(title: Other, style: .default, handler: { (action: UIAlertAction!) in
         print("その他ボタンが押された押されたよ")
         self.ReportCommentOther(TappedCellNum: TappedCellNum)
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
   
   //MARK:- ユーザが投稿したステージに対してレポートボタンが押されたときの処理
   //TODO: ローカライズすること
   private func TapReportActionAgainstUsersPostStage(TappedCellNum: Int) {
      let ReportActionSheet = UIAlertController(title: "Report", message: nil, preferredStyle: .actionSheet)
      
      let StringInappropriate = "Contains illegal characters"
      let StringInappropriateAction = UIAlertAction(title: StringInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な文字を含むボタンが押された押されたよ")
         self.ReportStageIncludeStringInappropriate(TappedCellNum: TappedCellNum)
      })
      let ImageInappropriate = "Contains inappropriate images"
      let ImageInappropriateAction = UIAlertAction(title: ImageInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な画像を含むボタンが押された押されたよ")
         self.ReportStageIncludeImageInappropriate(TappedCellNum: TappedCellNum)
      })
      
      let Other = "Other"
      let OtherInappropriateAction = UIAlertAction(title: Other, style: .default, handler: { (action: UIAlertAction!) in
         print("その他ボタンが押された押されたよ")
         self.ReportStageOther(TappedCellNum: TappedCellNum)
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
   
   //MARK:- ユーザが投稿したものに対してブロックボタンが押されたときの処理
   //TODO: ローカライズすること
   //ユーザが投稿したものに対してブロックボタンが押されたときの処理
   //TODO: ローカライズすること
   private func TapBlockActionAgainstUsersPost(UserName: String, uid: String) {
      let BlockAlertSheet = UIAlertController(title: "Block " + UserName, message: nil, preferredStyle: .alert)
      
      let CanselAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("BlockActionSheetでCanselタップされた")
      })
      
      let BlockAction = UIAlertAction(title: "Block", style: .destructive, handler: { (action: UIAlertAction!) in
         self.BlockUserFireStore(blockUsersUID: uid)
      })
      
      BlockAlertSheet.addAction(BlockAction)
      BlockAlertSheet.addAction(CanselAction)
      
      self.present(BlockAlertSheet, animated: true, completion: nil)
   }
   
   private func BlockUserFireStore(blockUsersUID: String) {
      print("\n------ Userのブロックを開始しますBlockします ------")
      print("uid: \(blockUsersUID)")
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
      }
   }
   
   //TODO: ローカライズすること
   //MARK:- ユーザステージの報告ボタンタップされた処理
   @IBAction func TapPostUsersStageReportButton(_ sender: UIButton) {
      print("ユーザステージの報告ボタンタップされた")
      
      let tag = sender.tag
      print("\(tag)番目のcellの報告ボタンがタップされました")
      
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      //自分のコメントをタップしていたら
      if self.PostUsersUID == UsersUID {
         print("自分のステージをタップしているのでアクションシートは表示しません\n")
         return
      }
      
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
             
      let ReportAction = UIAlertAction(title: "Report", style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPostStage(TappedCellNum: tag)
      })
      
      let BlockAction = UIAlertAction(title: "Block", style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost(UserName: self.PostUsersUserName, uid: self.PostUsersUID)
      })
      
      let CanselAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCanselタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CanselAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   
   //MARK:- コメントしたユーザの報告ボタンがタップされたときの処理
   //TODO:- ローカライズね。
   @objc func TapReportCommentedUserTableViewCell(_ sender: UIButton) {
      guard self.isLoadingGameVC == false else {
         print("コメントしたユーザの報告タップされたけど，ローディング中やから何もしない.")
         return
      }
      let rowNum = sender.tag
      print("\(rowNum)番目のcellのユーザの報告ボタンがタップされました")
      
      let TapStagePostUsersUID = UsingCommentedStageDatas[rowNum]["CommentUserUID"] as! String
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      //自分のコメントをタップしていたら
      if TapStagePostUsersUID == UsersUID {
         print("自分のコメントをタップしているのでアクションシートは表示しません\n")
         return
      }
      
      let UserName = UsingCommentedStageDatas[rowNum]["CommentUsersName"] as! String
      
      let ActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let Report = NSLocalizedString("Report", comment: "")
      let Block = NSLocalizedString("Block", comment: "")
      let Cansel = NSLocalizedString("Cansel", comment: "")
             
      let ReportAction = UIAlertAction(title: Report, style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPostComment(TappedCellNum: rowNum)
      })
      
      let BlockAction = UIAlertAction(title: Block, style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost(UserName: UserName, uid: TapStagePostUsersUID)
      })
      
      let CanselAction = UIAlertAction(title: Cansel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCanselタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CanselAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   //MARK:- コメントしたユーザの画像がタップされたときの処理
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
