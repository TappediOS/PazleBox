//
//  ExUserProfileViewControllerDelegate.swift
//  PazleBox
//
//  Created by jun on 2020/03/05.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet

extension UserProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return UsingStageDatas.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UserProfileTableView.dequeueReusableCell(withIdentifier: "UserProfileTableCell", for: indexPath) as? UserProfileTableViewCell
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         cell?.UsersPostedStageImageView.image = Image
      }
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      let addDate = UsingStageDatas[indexPath.item]["addDate"] as! String
      
      cell?.UsersNameLabel.text = "Japn Qj"
      cell?.UsersPfofileImageView.image = UIImage(named: "person.png")!
      cell?.UsersPostedStageTitleLabel.text = StageTitle
      cell?.UsersPostedStageReviewLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.UsersPostedStagePlayCountLabel.text = String(PlayCount)
      cell?.UsersPostedStageAddDateLabel.text = addDate
      return cell!
   }
   
   //ヘッダーの高さを設定
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return sectionHeaderHeight
   }
   
   //ヘッダーに使うUIViewを返す
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
      //xibファイルから読み込んでヘッダを生成
      let HeaderView = UserProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeaderHeight))
      return HeaderView
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      UserProfileTableViewSellectedIndexPath = indexPath
      
      let UserProfileTapCellViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileTapCellVC") as! UserProfileTapCellViewController
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         UserProfileTapCellViewController.setPostUsersStageImage(stageImage: Image!)
      }
      //let UserName = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      
      UserProfileTapCellViewController.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      UserProfileTapCellViewController.setUsersName(usersName: "Great Girl")
      
      UserProfileTapCellViewController.setPostUsersStageTitle(stageTitle: StageTitle)
         
         
      UserProfileTapCellViewController.setPostUsersStageReview(stageReview: String(floor(Double(reviewNum) * 100) / 100) + " / 5")
      UserProfileTapCellViewController.setPostUsersStagePlayCount(stagePlayCount: String(PlayCount))
      
      //ステージデータをセットする
      let PiceArray = GetPiceArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let StageArray = GetStageArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let PlayStageData = GetPlayStageInfoFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      
      
      UserProfileTapCellViewController.setPiceArray(PiceArray)
      UserProfileTapCellViewController.setStageArray(StageArray)
      UserProfileTapCellViewController.setPlayStageData(PlayStageData)
      
      UserProfileTapCellViewController.setTopVCTableViewCellNum(indexPath.item)
         
      self.navigationController?.pushViewController(UserProfileTapCellViewController, animated: true)
   }
   
   
   //スクロールした際にtableviewのヘッダを動かす
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
       /// sectionHeaderが上部に残らないようにする
       let offsetY = scrollView.contentOffset.y
       let safeAreaInset: CGFloat = scrollView.safeAreaInsets.top

       let top: CGFloat
       if offsetY > sectionHeaderHeight{
           /// 一番上のheaderの最下部が画面外へ出ている状態
           top = -(safeAreaInset + sectionHeaderHeight)
       } else if offsetY < -safeAreaInset {
           /// 初期状態からメニューを下に引っ張っている状態
           top = 0
       } else {
           /// safeArea内を一番上のheaderが移動している状態
           top = -(safeAreaInset + offsetY)
       }
       scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
   }
}

//TODO:- ローカライズすること
extension UserProfileViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("ステージ投稿なし", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("ステージが投稿されたら表示されます", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}