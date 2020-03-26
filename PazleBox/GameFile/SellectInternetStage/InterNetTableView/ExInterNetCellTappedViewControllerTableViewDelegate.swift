//
//  ExInterNetCellTappedViewControllerTableViewDelegate.swift
//  PazleBox
//
//  Created by jun on 2020/03/26.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet


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
