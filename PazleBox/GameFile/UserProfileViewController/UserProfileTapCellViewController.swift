//
//  UserProfileTapCellViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/26.
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

class UserProfileTapCellViewController: UIViewController {
   @IBOutlet weak var UsersStageCommentTableView: UITableView!
   
   
   @IBOutlet weak var UsersProfileImageView: UIImageView!
   @IBOutlet weak var UsersNameLabel: UILabel!
   
   var UsersProfileImage = UIImage()
   var UsersName: String = ""
   
   @IBOutlet weak var UsersPostedStageImageView: UIImageView!
   @IBOutlet weak var UsersPostedStageTitleLabel: UILabel!
   
   var UsersPostedStageImage = UIImage()
   var UsersPostedStageTitle: String = ""
   
   @IBOutlet weak var UsersPostedStageReviewLabel: UILabel!
   @IBOutlet weak var UsersPostedStagePalyCountLabel: UILabel!
   
   var UsersPostedStageReview: String = "" // 2.23 / 5
   var UsersPostedStagePlayCount: String = "" // 245
   
   @IBOutlet weak var UsersPostedStagePlayButton: UIButton!
   @IBOutlet weak var UsersPostedStageDeleteButton: UIButton!
   
   let ButtonCornerRadius: CGFloat = 6.5
   let GameSound = GameSounds()
   
   var PostUsersProfileURL = ""
   var PostUsersUID = ""
   var PostedStageCommentID = ""
   var PostedUsersFcmToken = ""
   
   //GameSceneを読み込むのに必要なデータ
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   var PlayStageData = PlayStageRefInfo()
   
   //どこのcellをタップして画面遷移されたかを決めている。
   var TopVCTableViewCellNum = 0
   
   var isAbleToTapPlayDeleteButton = true
   
   var db: Firestore!
   var LoadActivityView: NVActivityIndicatorView?
   
   //こいつにcommentTableviewで表示するやつを入れる。
   var UsingCommentedStageDatas: [([String: Any])] = Array()
   let MaxGetCommentNumFormDataBase = 40
   var DownLoadProfileCounter = 0
   
   var BlockList = Array<String>()
   var BlockedList = Array<String>()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      SetUpUsersStageCommentTableView()
      InitLoadActivityView()
      SetUpFireStoreSetting()
      SetUpNavigationController()
      InitUsersProfileImageView()
      InitUsersNameLabel()
      InitUsersPostedStageImageView()
      InitUsersPostedStageTitleLabel()
      InitUsersPostedStageReviewLabel()
      InitUsersPostedStagePalyCountLabel()
      
      SetUpPlayButtonAndDeleteButtonTitle()
      SetUpPostUsersStageButton(sender: UsersPostedStagePlayButton)
      SetUpPostUsersStageButton(sender: UsersPostedStageDeleteButton)
      
      FetchBlockAndBlockedListFromFireStore()
   }
   
   func SetUpUsersStageCommentTableView() {
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false { BottonInsets = 50 }
      UsersStageCommentTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: BottonInsets, right: 0)
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
   
   func SetUpNavigationController() {
      self.navigationItem.title = NSLocalizedString("Stage", comment: "")
   }
   
   //MARK:- viewDidLoadで画面遷移前に取得した各値をセットする
   func InitUsersProfileImageView() {
      self.UsersProfileImageView.image = self.UsersProfileImage
      self.UsersProfileImageView.layer.cornerRadius = self.UsersProfileImageView.frame.width / 2
      self.UsersProfileImageView.layer.masksToBounds = true
   }
   func InitUsersNameLabel() {
      self.UsersNameLabel.text = self.UsersName
      self.UsersNameLabel.adjustsFontSizeToFitWidth = true
      self.UsersNameLabel.minimumScaleFactor = 0.4
   }
   func InitUsersPostedStageImageView() {
      self.UsersPostedStageImageView.image = self.UsersPostedStageImage
      self.UsersPostedStageImageView.contentMode = .scaleAspectFill
   }
   func InitUsersPostedStageTitleLabel() {
      self.UsersPostedStageTitleLabel.text = self.UsersPostedStageTitle
      self.UsersPostedStageTitleLabel.adjustsFontSizeToFitWidth = true
      self.UsersPostedStageTitleLabel.minimumScaleFactor = 0.4
   }
   func InitUsersPostedStageReviewLabel() {
      self.UsersPostedStageReviewLabel.text = self.UsersPostedStageReview
   }
   func InitUsersPostedStagePalyCountLabel() {
      self.UsersPostedStagePalyCountLabel.text = self.UsersPostedStagePlayCount
   }
   
   
   
   private func SetUpPlayButtonAndDeleteButtonTitle() {
      let play = NSLocalizedString("Play", comment: "")
      let delete = NSLocalizedString("Delete", comment: "")
      UsersPostedStagePlayButton.setTitle(play, for: .normal)
      UsersPostedStageDeleteButton.setTitle(delete, for: .normal)
   }
   
   private func SetUpPostUsersStageButton(sender: UIButton) {
      sender.titleLabel?.adjustsFontSizeToFitWidth = true
      sender.titleLabel?.adjustsFontForContentSizeCategory = true
      sender.titleLabel?.font = UIFont.boldFlatFont (ofSize: 18)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      sender.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      sender.layer.cornerRadius =  ButtonCornerRadius
   }
   
   
   //MARK:- 画面遷移する前にポストユーザの画面の各値をセットする
   public func setUsersImage(usersImage: UIImage) {
      self.UsersProfileImage = usersImage
   }
   
   public func setUsersName(usersName: String) {
      self.UsersName = usersName
   }
   
   public func setPostUsersStageImage(stageImage: UIImage) {
      self.UsersPostedStageImage = stageImage
   }
   
   public func setPostUsersStageTitle(stageTitle: String) {
      self.UsersPostedStageTitle = stageTitle
   }
   
   public func setPostUsersStageReview(stageReview: String) {
      self.UsersPostedStageReview = stageReview
   }
   
   public func setPostUsersStagePlayCount(stagePlayCount: String) {
      self.UsersPostedStagePlayCount = stagePlayCount
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
   
   public func setTopVCTableViewCellNum(_ cellNum: Int) {
      self.TopVCTableViewCellNum = cellNum
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
   
   private func AbleToEachButton() {
      self.UsersPostedStagePlayButton.isEnabled = true
      self.UsersPostedStageDeleteButton.isEnabled = true
      self.isAbleToTapPlayDeleteButton = true
   }
   

   //MARK:- プレイボタン押されたときの処理
   @IBAction func TapUsersStagePlayButton(_ sender: Any) {
      print("Play Buttonタップされたよ")
      UsersPostedStagePlayButton.isEnabled = false //2度押し禁止する処理
      UsersPostedStageDeleteButton.isEnabled = false
      isAbleToTapPlayDeleteButton = false
      PresentGameViewController()
   }
   
   /// GameVCをプレゼントする関数
   func PresentGameViewController() {
      //GameSound.PlaySoundsTapButton()
      let CleateSB = UIStoryboard(name: "CleateStageSB", bundle: nil)
      let GameVC = CleateSB.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController
      
      GameVC.LoadUsersInfo()
      GameVC.LoadUsersNameOfPostedStages(name: self.UsersName)
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
         self.AbleToEachButton()
      })
   }
   
   //MARK:- 削除ボタン押されたときの処理
   @IBAction func TapUsersStageDeleteButton(_ sender: Any) {
      print("Delete Buttonタップされたよ")
      GameSound.PlaySoundsTapButton()
      UsersPostedStagePlayButton.isEnabled = false //2度押し禁止する処理
      UsersPostedStageDeleteButton.isEnabled = false
      isAbleToTapPlayDeleteButton = false
      ShowDeleteView()
   }
   
   private func  ShowDeleteView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)

      ComleateView.addButton(NSLocalizedString("Delete", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.DeleteDocumentForFireStore()
         ComleateView.removeFromParent()
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")){
         self.Play3DtouchHeavy()
         ComleateView.removeFromParent()
         self.AbleToEachButton()
      }
      let delStage = NSLocalizedString("delStage", comment: "")
      let cantBack = NSLocalizedString("cantBack", comment: "")
      ComleateView.showWarning(delStage, subTitle: cantBack)
   }
   
   //MARK:- FireStoreからデータを削除する関数
   private func DeleteDocumentForFireStore() {
      self.StartLoadingAnimation()
      
      let docRef = PlayStageData.RefID
      print("\n\n--- データの削除開始---\n")
      print("docID = \(docRef)")
      print("uid = \(String(describing: UserDefaults.standard.string(forKey: "UID")))")
      
      db.document(docRef).delete() { err in
         if let err = err {
            print("\n削除するのにエラーが発生:\n\(err)")
            self.ShowErrDeleteStageInStoreSaveAlertView()
            self.StopLoadingAnimation()
            return
         }
         print("---  データの削除成功しました---\n\n")
         self.DecrementCreateStageNum()
         self.ShowSuccDeleteStageInStoreSaveAlertView()
         self.StopLoadingAnimation()
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
   
   //ステージを削除するのにエラーが発生したときの処理
   private func ShowErrDeleteStageInStoreSaveAlertView() {
      Play3DtouchError()
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.AbleToEachButton()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errDele = NSLocalizedString("errDele", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errDele + "\n" + checkNet)
   }
   
   private func ShowSuccDeleteStageInStoreSaveAlertView() {
      Play3DtouchSuccess()
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.AbleToEachButton()
         self.ReturnPopToRootViewController()
      }
      let suc = NSLocalizedString("suc", comment: "")
      let sucDele = NSLocalizedString("sucDele", comment: "")
      ComleateView.showSuccess(suc, subTitle: sucDele)
   }
   
   //MARK:- 登録ステージ数をデクリメントする
   private func DecrementCreateStageNum() {
      let CreateStageNum: Int = UserDefaults.standard.integer(forKey: "CreateStageNum")
      print("\nステージ送信完了したので登録しているステージ数を\nデクリメントします。")
      UserDefaults.standard.set(CreateStageNum - 1, forKey: "CreateStageNum")
      let AfterCreateStageNum: Int = UserDefaults.standard.integer(forKey: "CreateStageNum")
      print("デクリメント完了しました")
      print("登録数は：　\(CreateStageNum) から　\(AfterCreateStageNum) に更新されました\n\n")
   }
   
   func ReturnPopToRootViewController() {
      UserDefaults.standard.set(true, forKey: "isDeleteUsersPostedCell")
      UserDefaults.standard.set(TopVCTableViewCellNum, forKey: "DeleteUsersPostedCellNum")
      UserDefaults.standard.synchronize()
      self.navigationController?.popToRootViewController(animated: true)
   }
   
   //MARK:- コメントしたユーザの画像タップされたときの処理
   @objc func TapUserImageButtonUserProfileTapCellComment(_ sender: UIButton) {
      guard self.isAbleToTapPlayDeleteButton == true else {
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
   
   //MARK:- ユーザが投稿したものに対してレポートボタンが押されたときの処理
   private func TapReportActionAgainstUsersPost(TappedCellNum: Int) {
      let Report = NSLocalizedString("Report", comment: "")
      let ReportActionSheet = UIAlertController(title: Report, message: nil, preferredStyle: .actionSheet)
      
      let StringInappropriate = NSLocalizedString("InapCharacters", comment: "")
      let StringInappropriateAction = UIAlertAction(title: StringInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な文字を含むボタンが押された押されたよ")
         self.ReportCommentIncludeStringInappropriate(TappedCellNum: TappedCellNum)
      })
      let ImageInappropriate = NSLocalizedString("InapImages", comment: "")
      let ImageInappropriateAction = UIAlertAction(title: ImageInappropriate, style: .default, handler: { (action: UIAlertAction!) in
         print("不適切な画像を含むボタンが押された押されたよ")
         self.ReportCommentIncludeImageInappropriate(TappedCellNum: TappedCellNum)
      })
      
      let Other = NSLocalizedString("Other", comment: "")
      let OtherInappropriateAction = UIAlertAction(title: Other, style: .default, handler: { (action: UIAlertAction!) in
         print("その他ボタンが押された押されたよ")
         self.ReportCommentOther(TappedCellNum: TappedCellNum)
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
   private func TapBlockActionAgainstUsersPost(UserName: String, uid: String) {
      let Block = NSLocalizedString("Block", comment: "")
      let BlockAlertSheet = UIAlertController(title: Block + " " + UserName, message: nil, preferredStyle: .alert)
      
      let Cancel = NSLocalizedString("Cancel", comment: "")
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("BlockActionSheetでCancelタップされた")
      })
      
      let BlockAction = UIAlertAction(title: Block, style: .destructive, handler: { (action: UIAlertAction!) in
         self.BlockUserFireStore(blockUsersUID: uid)
      })
      
      BlockAlertSheet.addAction(BlockAction)
      BlockAlertSheet.addAction(CancelAction)
      
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
   
   
   //MARK:- Reportボタン押されたときの処理
   @objc func TapUsersCommentReportButton(_ sender: UIButton) {
      guard self.isAbleToTapPlayDeleteButton == true else {
         print("コメントしたユーザの報告タップされたけど，ローディング中やから何もしない.")
         return
      }
      let rowNum = sender.tag
      print("\(rowNum)番目のcellの報告ボタンがタップされました")
      
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
      let ReportAction = UIAlertAction(title: Report, style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
         self.TapReportActionAgainstUsersPost(TappedCellNum: rowNum)
      })
      
      let Block = NSLocalizedString("Block", comment: "")
      let BlockAction = UIAlertAction(title: Block, style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
         self.TapBlockActionAgainstUsersPost(UserName: UserName, uid: TapStagePostUsersUID)
      })
      
      let Cancel = NSLocalizedString("Cancel", comment: "")
      let CancelAction = UIAlertAction(title: Cancel, style: .cancel, handler: { (action: UIAlertAction!) in
         print("ActionSheetでCancelタップされた")
      })
      
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
      ActionSheet.addAction(CancelAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}


