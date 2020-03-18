//
//  ExSomeUsersListViewControllerTableView.swift
//  PazleBox
//
//  Created by jun on 2020/03/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet

extension SomeUsersListViewController: UITableViewDelegate, UITableViewDataSource {
   //セクションの数を返す
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   //テーブルの行数を返す
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 30
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.SomeUsersListTableView.dequeueReusableCell(withIdentifier: "SomeUsersListCell", for: indexPath) as? SomeUsersListTableViewCell
        
   
//      let usersProfileData = UsingStageDatas[indexPath.item]["PostedUsersProfileImage"] as? NSData
//      if let ProfileData = usersProfileData {
//         let Image = UIImage(data: ProfileData as Data)
//         cell?.UsersImageViewButton.setImage(Image, for: .normal)
//      }

      //cell?.UsersNameLabel.text = UsingStageDatas[indexPath.row]["PostedUsersName"] as? String
      cell?.UsersNameLabel.text = "Yon Yon"
      cell?.UsersProfileImageView.image = UIImage(named: "NoProfileImage.png")

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      //self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
   }
}

extension SomeUsersListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("ユーザなし", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("表示するユーザはいません", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}
