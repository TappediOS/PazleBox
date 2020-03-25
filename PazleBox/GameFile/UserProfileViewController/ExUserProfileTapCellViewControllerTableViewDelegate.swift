//
//  ExUserProfileTapCellViewControllerTableViewDelegate.swift
//  PazleBox
//
//  Created by jun on 2020/03/25.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import Firebase
import FirebaseFirestore
import SCLAlertView
import NVActivityIndicatorView
import DZNEmptyDataSet
import FirebaseStorage


extension UserProfileTapCellViewController: UITableViewDelegate, UITableViewDataSource  {
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
      let cell = self.UsersStageCommentTableView.dequeueReusableCell(withIdentifier: "ProfileVCsTapCellTableViewCell", for: indexPath) as? ProfileVCtapCellCommentCell
      
      let usersProfileData = UsingCommentedStageDatas[indexPath.item]["CommentedUsersProfileImage"] as? NSData
      if let ProfileData = usersProfileData {
         let Image = UIImage(data: ProfileData as Data)
         cell?.UsersImageButton.setImage(Image, for: .normal)
      }
      
      let UserName = UsingCommentedStageDatas[indexPath.item]["CommentUsersName"] as! String
      let CommentBody = UsingCommentedStageDatas[indexPath.item]["CommentBody"] as! String
      
      cell?.UserNameLabel.text = UserName
      cell?.UsersComments.text = CommentBody
      
      cell?.UsersImageButton.tag = indexPath.row
      cell?.UsersImageButton.addTarget(self, action: #selector(TapUserImageButtonUserProfileTapCellComment(_:)), for: .touchUpInside)
      
      cell?.UsersCommentReportButton.tag = indexPath.row
      cell?.UsersCommentReportButton.addTarget(self, action: #selector(TapUsersCommentReportButton(_:)), for: .touchUpInside)
      
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
