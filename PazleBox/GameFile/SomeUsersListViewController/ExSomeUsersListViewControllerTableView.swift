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
      return self.UsingStageDatas.count
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.SomeUsersListTableView.dequeueReusableCell(withIdentifier: "SomeUsersListCell", for: indexPath) as? SomeUsersListTableViewCell
        
   
      let usersProfileData = UsingStageDatas[indexPath.item]["UsersProfileImage"] as? NSData
      if let ProfileData = usersProfileData {
         let Image = UIImage(data: ProfileData as Data)
         cell?.UsersProfileImageView.image = Image
      }

      cell?.UsersNameLabel.text = UsingStageDatas[indexPath.row]["name"] as? String
    
      cell?.ListUsersUID = UsingStageDatas[indexPath.row]["usersUID"] as! String
      

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      let TappedCellsUID = UsingStageDatas[indexPath.item]["usersUID"] as! String
      //本人をタップしてたら，
      if TappedCellsUID == self.UsersUID {
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
      
      OtherUsersProfileVC.fetchOtherUsersUIDbeforPushVC(uid: TappedCellsUID)
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
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
