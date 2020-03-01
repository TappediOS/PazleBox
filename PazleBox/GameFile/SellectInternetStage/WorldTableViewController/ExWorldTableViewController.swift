//
//  ExWorldTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

extension WorldTableViewController {
   //セクションの数を返す
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   //テーブルの行数を返す
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return UsingStageDatas.count
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.WorldTableView.dequeueReusableCell(withIdentifier: "WorldTableViewCell", for: indexPath) as? WorldTableViewCell
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         cell?.UsersGameImageView.image = Image
      }
      
   
      cell?.UsersImageViewButton.setImage(UIImage(named: "person.png")!, for: .normal)
      cell?.UsersImageViewButton.tag = indexPath.row
      cell?.UsersImageViewButton.addTarget(self, action: #selector(TapUserImageButtonWorldTableView(_:)), for: .touchUpInside)
      
      cell?.UserNameLabel.text = "Raid on was"
      
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      cell?.UsersStageReviewLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.UsersStagePlayCountLabel.text = String(UsingStageDatas[indexPath.item]["PlayCount"] as! Int)
      cell?.UsersStagePostedDateLabel.text = UsingStageDatas[indexPath.item]["addDate"] as! String

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      let InterNetCellTappedVCSB = UIStoryboard(name: "InterNetTableView", bundle: nil)

      let InterNetCellTappedVC = InterNetCellTappedVCSB.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         InterNetCellTappedVC.setPostUsersStageImage(stageImage: Image!)
      }
      
      InterNetCellTappedVC.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      InterNetCellTappedVC.setUsersName(usersName: "Supar Boy")
      
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: "Drop Card")
      
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: String(floor(Double(reviewNum) * 100) / 100) + " / 5")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: String(UsingStageDatas[indexPath.item]["PlayCount"] as! Int))
      
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
   }
   
   
}

