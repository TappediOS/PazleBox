//
//  UserProfileTapCellViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/26.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

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
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
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
      
      self.UsersStageCommentTableView.delegate = self
      self.UsersStageCommentTableView.dataSource = self
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
   
   @IBAction func TapUsersStagePlayButton(_ sender: Any) {
      print("Play Buttonタップされたよ")
   }
   
   
   @IBAction func TapUsersStageDeleteButton(_ sender: Any) {
       print("Delete Buttonタップされたよ")
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
