//
//  InterNetCellTappedViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/21.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
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
   
   @IBOutlet weak var UsersCommentTableView: UITableView!

   let ButtonCornerRadius: CGFloat = 6.5
   
   let GameSound = GameSounds()
   
   //GameSceneを読み込むのに必要なデータ
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   var PlayStageData = PlayStageRefInfo()
   
   var isLoadingGameVC = false
   
   private var RefleshControl = UIRefreshControl()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpNavigationController()
      InitPostUsersImageView()
      InitPostUsersUserNBameLabel()
      InitPostUsersStageImageView()
      InitPostUsersStageTitleLabel()
      InitPostUsersStageReviewLabel()
      InitPostUsersStagePlayCountLabel()
      SetUpPostUsersStagePlayButton()
      SetUpRefleshControl()
      
      self.UsersCommentTableView.delegate = self
      self.UsersCommentTableView.dataSource = self
      self.UsersCommentTableView.emptyDataSetSource = self
      self.UsersCommentTableView.emptyDataSetDelegate = self
      self.UsersCommentTableView.tableFooterView = UIView() //コメントが0の時にcell間の線を消すテクニック
      
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
      
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
            
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
}

extension InterNetCellTappedViewController {
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
      let cell = self.UsersCommentTableView.dequeueReusableCell(withIdentifier: "UsersCommentCell", for: indexPath) as? UsersCommentTableViewCell
      
      
      cell?.CommentedUsersImageViewButton.setImage(UIImage(named: "person.png")!, for: .normal)
      cell?.CommentedUsersImageViewButton.tag = indexPath.row
      cell?.CommentedUsersImageViewButton.addTarget(self, action: #selector(TapCommentedUsersImageViewButtonInterNetTableView(_:)), for: .touchUpInside)
      
      
      cell?.CommentedUsersNameLabel.text = "Kind Person"
      cell?.CommentedUsersCommentLabel.text = "This is a super good!"
      
      cell?.ReportUserButton.tag = indexPath.row
      cell?.ReportUserButton.addTarget(self, action: #selector(TapReportCommentedUserTableViewCell(_:)), for: .touchUpInside)
      
      if indexPath.row % 3 == 0 {
         cell?.CommentedUsersCommentLabel.text = "apple. apple\nyou are apple\nif you have a any question, please contact us. thank you! \n\n ad ad ad\n lunch for you."
      }

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)

      
   }
}

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

