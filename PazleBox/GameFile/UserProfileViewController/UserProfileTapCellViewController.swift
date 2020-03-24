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

class UserProfileTapCellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
   
   var isAbleToTapPlayDeleteButton = false
   
   var db: Firestore!
   
   var LoadActivityView: NVActivityIndicatorView?
   
   private var RefleshControl = UIRefreshControl()
   
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
      SetUpRefleshControl()
      
      SetUpPlayButtonAndDeleteButtonTitle()
      SetUpPostUsersStageButton(sender: UsersPostedStagePlayButton)
      SetUpPostUsersStageButton(sender: UsersPostedStageDeleteButton)
      
      self.UsersStageCommentTableView.delegate = self
      self.UsersStageCommentTableView.dataSource = self
      self.UsersStageCommentTableView.emptyDataSetSource = self
      self.UsersStageCommentTableView.emptyDataSetDelegate = self
      self.UsersStageCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
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
      //TODO:- ローカライズする
      self.navigationItem.title = NSLocalizedString("Stage", comment: "")
   }
   
   //MARK:- viewDidLoadで画面遷移前に取得した各値をセットする
   func InitUsersProfileImageView() {
      self.UsersProfileImageView.image = self.UsersProfileImage
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
   
   private func SetUpRefleshControl() {
      self.UsersStageCommentTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadCommentDataFromFireStore(sender:)), for: .valueChanged)
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
   
   private func AbleToEachButton() {
      self.UsersPostedStagePlayButton.isEnabled = true
      self.UsersPostedStageDeleteButton.isEnabled = true
      self.isAbleToTapPlayDeleteButton = true
   }
   
   //MARK:- コメントのリロードを行う
   @objc func ReloadCommentDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
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
      
      let docID = PlayStageData.RefID
      print("\n\n---データの削除開始---\n\n")
      print("docID = \(docID)")
      print("uid = \(String(describing: UserDefaults.standard.string(forKey: "UID")))")
      
      db.collection("Stages").document(docID).delete() { err in
         if let err = err {
            print("\n削除するのにエラーが発生:\n\(err)")
            self.ShowErrDeleteStageInStoreSaveAlertView()
            self.StopLoadingAnimation()
            return
         }else {
            print("削除成功しました。")
            self.DecrementCreateStageNum()
            self.ShowSuccDeleteStageInStoreSaveAlertView()
            self.StopLoadingAnimation()
         }
      }
   }
   
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
   
   @objc func TapUserImageButtonUserProfileTapCellComment(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
        
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
              
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
   
   @objc func TapUsersCommentReportButton(_ sender: UIButton) {
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

extension UserProfileTapCellViewController {
   //セクションの数を返す
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   //テーブルの行数を返す
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 20
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UsersStageCommentTableView.dequeueReusableCell(withIdentifier: "ProfileVCsTapCellTableViewCell", for: indexPath) as? ProfileVCtapCellCommentCell
      
      
      cell?.UsersImageButton.setImage(UIImage(named: "person.png"), for: .normal)
      cell?.UsersImageButton.tag = indexPath.row
      cell?.UsersImageButton.addTarget(self, action: #selector(TapUserImageButtonUserProfileTapCellComment(_:)), for: .touchUpInside)
      
      cell?.UsersCommentReportButton.tag = indexPath.row
      cell?.UsersCommentReportButton.addTarget(self, action: #selector(TapUsersCommentReportButton(_:)), for: .touchUpInside)
      cell?.UserNameLabel.text = "Your Person?"
      cell?.UsersComments.text = "Now I Lock on"
      
      if indexPath.row % 3 == 0 {
         cell?.UsersComments.text = "BanBanBan\nlet you know\ni like you, i hate you, i...,  thank you! \n\n lack lack lack \n lunch for me."
      }

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      
      
   }
}


//TODO:- ローカライズすること
extension UserProfileTapCellViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("コメントなし", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("コメントがついたら表示されます", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}
