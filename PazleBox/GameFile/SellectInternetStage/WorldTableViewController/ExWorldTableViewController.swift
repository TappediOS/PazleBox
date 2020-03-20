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
      
      let StageImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = StageImageData {
         let Image = UIImage(data: data as Data)
         cell?.UsersGameImageView.image = Image
      }
      
      let usersProfileData = UsingStageDatas[indexPath.item]["PostedUsersProfileImage"] as? NSData
      if let ProfileData = usersProfileData {
         let Image = UIImage(data: ProfileData as Data)
         cell?.UsersImageViewButton.setImage(Image, for: .normal)
      }
   
      cell?.UsersImageViewButton.tag = indexPath.row
      cell?.UsersImageViewButton.addTarget(self, action: #selector(TapUserImageButtonWorldTableView(_:)), for: .touchUpInside)
      
      cell?.UserNameLabel.text = UsingStageDatas[indexPath.row]["PostedUsersName"] as? String
      
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      cell?.UsersStageTitlelLabel.text = StageTitle
      
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      cell?.UsersStageReviewLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.UsersStagePlayCountLabel.text = String(UsingStageDatas[indexPath.item]["PlayCount"] as! Int)
      cell?.UsersStagePostedDateLabel.text = UsingStageDatas[indexPath.item]["addDate"] as? String

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
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      let UserUID = UsingStageDatas[indexPath.item]["addUser"] as! String
      let UserName = UsingStageDatas[indexPath.item]["addUserName"] as! String
      let UserProfileURL = UsingStageDatas[indexPath.item]["addUsersProfileImageURL"] as! String
      let StageCommentID = UsingStageDatas[indexPath.item]["StageCommentUid"] as! String
      
      let usersProfileImageData = UsingStageDatas[indexPath.item]["PostedUsersProfileImage"] as? NSData
      if let ProfileImageData = usersProfileImageData {
         let Image = UIImage(data: ProfileImageData as Data)
         InterNetCellTappedVC.setUsersImage(usersImage: Image!)
      }
      
      InterNetCellTappedVC.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      InterNetCellTappedVC.setUsersName(usersName: UserName)
      
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: StageTitle)
      
      
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: String(floor(Double(reviewNum) * 100) / 100) + " / 5")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: String(PlayCount))
      
      InterNetCellTappedVC.setPostUsersUID(postUsersUID: UserUID)
      InterNetCellTappedVC.setPostUsersProfileURL(postUsersProfileURL: UserProfileURL)
      InterNetCellTappedVC.setPostedStageCommentID(CommentID: StageCommentID)
      
      //ステージデータをセットする
      let PiceArray = GetPiceArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let StageArray = GetStageArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let PlayStageData = GetPlayStageInfoFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      
      
      InterNetCellTappedVC.setPiceArray(PiceArray)
      InterNetCellTappedVC.setStageArray(StageArray)
      InterNetCellTappedVC.setPlayStageData(PlayStageData)
      
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
   }
   
   
}


