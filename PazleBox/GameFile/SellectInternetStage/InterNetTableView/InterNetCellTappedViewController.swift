//
//  InterNetCellTappedViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/21.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitPostUsersImageView()
      InitPostUsersUserNBameLabel()
      InitPostUsersStageImageView()
      InitPostUsersStageTitleLabel()
      InitPostUsersStageReviewLabel()
      InitPostUsersStagePlayCountLabel()
      SetUpPostUsersStagePlayButton()
      
      self.UsersCommentTableView.delegate = self
      self.UsersCommentTableView.dataSource = self
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
   }
   func InitPostUsersUserNBameLabel() {
      self.PostUsersUserNBameLabel.text = self.PostUsersUserName
   }
   func InitPostUsersStageImageView() {
      self.PostUsersStageImageView.image = self.PostUsersStageImage
   }
   func InitPostUsersStageTitleLabel() {
      self.PostUsersStageTitleLabel.text = self.PostUsersStageTitle
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
   
   
   @IBAction func TapPostUsersStagePlayButton(_ sender: Any) {
      print("ユーザステージのプレイボタンタップされた")
   }
   
   @IBAction func TapPostUsersStageReportButton(_ sender: Any) {
      print("ユーザステージの報告ボタンタップされた")

      let ActionSheet = UIAlertController(title: "ポケモンリスト", message: "好きなポケモンを選んでください。", preferredStyle: .actionSheet)
             
      let ReportAction = UIAlertAction(title: "Report", style: .destructive, handler: { (action: UIAlertAction!) in
         print("Report押されたよ")
      })
      
      
      let BlockAction = UIAlertAction(title: "Block", style: .default, handler: { (action: UIAlertAction!) in
         print("Block押されたよ")
      })
      
         
      ActionSheet.addAction(ReportAction)
      ActionSheet.addAction(BlockAction)
         
      self.present(ActionSheet, animated: true, completion: nil)
   }
   
   
   @objc func TapCommentedUsersImageViewButtonInterNetTableView(_ sender: UIButton) {
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

