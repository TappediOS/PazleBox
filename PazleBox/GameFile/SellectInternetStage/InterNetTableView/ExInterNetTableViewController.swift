//
//  ExInterNetTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/23.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

extension InterNetTableViewController {
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
      let cell = self.InterNetTableView.dequeueReusableCell(withIdentifier: "InterNetCell", for: indexPath) as? InterNetTableViewCell
      
      
      cell?.UserImageView.image = UIImage(named: "person.png")
      cell?.GameScreenshotImageView.image = UIImage(named: "23p5Red.png")
      cell?.UserNameLabel.text = "Raid on was"
      cell?.PlayCountLabel.text = String(2 * indexPath.row + 100 - indexPath.row)

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      
      
      let InterNetCellTappedVC = self.storyboard?.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      InterNetCellTappedVC.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      InterNetCellTappedVC.setUsersName(usersName: "Supar Boy")
      InterNetCellTappedVC.setPostUsersStageImage(stageImage: UIImage(named: "23p2Blue")!)
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: "Drop Card")
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: "2.16 / 5")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: "968")
      
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
   }
   
   
}

