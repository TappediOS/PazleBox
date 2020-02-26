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
   
   //MARK:- viewDidLoadで画面遷移前に取得した各値をセットする
   func InitUsersProfileImageView() {
      self.UsersProfileImageView.image = self.UsersProfileImage
   }
   func InitUsersNameLabel() {
      self.UsersNameLabel.text = self.UsersName
   }
   func InitUsersPostedStageImageView() {
      self.UsersPostedStageImageView.image = self.UsersPostedStageImage
   }
   func InitUsersPostedStageTitleLabel() {
      self.UsersPostedStageTitleLabel.text = self.UsersPostedStageTitle
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
   
   
   @IBAction func TapUsersPostedStagePlayButton(_ sender: Any) {
      print("Play Buttonタップされました")
   }
   
   
   @IBAction func TapUsersPostedStagePlayButton(_ sender: Any) {
      print("Delete Buttonタップされました")
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
      let cell = self.UsersCommentTableView.dequeueReusableCell(withIdentifier: "ProfileVCsTapCellTableViewCell", for: indexPath) as? ProfileVCtapCellCommentCell
      
      
      cell?.UsersImageButton.image = UIImage(named: "person.png")
      cell?.UserNameLabel.text = "Your Person?"
      cell?.UsersComments.text = "Now I Lock on"
      
      if indexPath.row % 3 == 0 {
         cell?.CommentedUsersCommentLabel.text = "BanBanBan\nlet you know\ni like you, i hate you, i...,  thank you! \n\n lack lack lack \n lunch for me."
      }

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)

      
   }
}
