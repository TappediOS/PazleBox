//
//  ExOtherUsersProfileVCTableView.swift
//  PazleBox
//
//  Created by jun on 2020/03/15.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet


extension OtherUsersProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return UsingStageDatas.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.OtherUesrsProfileTableView.dequeueReusableCell(withIdentifier: "OtherUsersProfileCell", for: indexPath) as? OtherUsersProfileTableViewCell
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         cell?.OtherUsersPostedStageImageView.image = Image
      }
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      let addDate = UsingStageDatas[indexPath.item]["addDate"] as! String
      
      cell?.OtherUsersPostReportButton.tag = indexPath.row
      cell?.OtherUsersPostReportButton.addTarget(self, action: #selector(TapOtherUsersPostReportButton(_:)), for: .touchUpInside)
      
      cell?.OtherUsersNameLabel.text = self.OtherUsersProfileName
      cell?.OtherUsersNameImageView.image = self.OtherUsersProfileImage
      cell?.OtherUsersPostedStageTitleLabel.text = StageTitle
      cell?.OtherUsersPostedStageRatedLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.OtherUsersPostedStagePlayCountLabel.text = String(PlayCount)
      cell?.OtherUsersPostedStageDateLabel.text = addDate

      return cell!
   }
   
   //ヘッダーの高さを設定
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return sectionHeaderHeight
   }
   
   //ヘッダーに使うUIViewを返す
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
      //xibファイルから読み込んでヘッダを生成
      let HeaderView = OtherUsersProfileTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeaderHeight))
      HeaderView.OtherUsersNameLabel.text = self.OtherUsersProfileName
      HeaderView.OtherUsersProfileImageView.image = self.OtherUsersProfileImage
      HeaderView.OtherUsersFollowingCountLabel.text = String(self.OtherusersFollowNum)
      HeaderView.OtherUsersFollowersCountLabel.text = String(self.OtherusersFollowerNum)
      HeaderView.OtherUsersPlayCountNumLabel.text = String(self.OtherusersPlayCountNum)
      HeaderView.OtherUsersPostsCountLabel.text = String(UsingStageDatas.count)
      
      //ブロックしてるかされてるかやったら0代入してreturn
      if (self.BlockFlag == true || self.BlockedFlag == true) {
         HeaderView.OtherUsersFollowingCountLabel.text = "0"
         HeaderView.OtherUsersFollowersCountLabel.text = "0"
         HeaderView.OtherUsersPlayCountNumLabel.text = "0"
         HeaderView.OtherUsersPostsCountLabel.text = "0"
         
         if self.BlockedFlag == true {
            HeaderView.SetUpFollowOrFollowingOrBlockedButtonAsCantWorkButtonBecauseUserBlockedUserThatShowOtherUsersVC()
         }
         
         if self.BlockFlag == true {
            HeaderView.SetUpFollowOrFollowingOrBlockedButtonAsBlockedButton()
            HeaderView.FollowOrFollowingOrBlockedButton.addTarget(self, action: #selector(self.TapBlockedButtonForUnBlockedUser(_:)), for: .touchUpInside)
         }
         return HeaderView
      }
      
      //followしてたら，変更するボタンをfollwingに変更する
      if self.FollowFlag == true {
         HeaderView.SetUpFollowOrFollowingOrBlockedButtonAsUnFollowButton()
         HeaderView.FollowOrFollowingOrBlockedButton.addTarget(self, action: #selector(self.TapFollowingButtonForUnFollowUser(_:)), for: .touchUpInside)
      }
      
      if self.FollowFlag == false {
         HeaderView.SetUpFollowOrFollowingOrBlockedButtonAsFollowButton()
         HeaderView.FollowOrFollowingOrBlockedButton.addTarget(self, action: #selector(self.TapFollwButtonForFollwUser(_:)), for: .touchUpInside)
      }
      
      //フォローフォロワーラベルをタップしたときの処理
      //ただし，この処理はBlockフラグもしくはBlockedFlagが立っていた時には走らない
      let TapFollowingGesture = UITapGestureRecognizer(target: self, action: #selector(TapFollowingLabel(_:)))
      let TapFollowingCountGesture = UITapGestureRecognizer(target: self, action: #selector(TapFollowingCountLabel(_:)))
      let TapFollowerGesture = UITapGestureRecognizer(target: self, action: #selector(TapFollowerLabel(_:)))
      let TapFollowerCountGesture = UITapGestureRecognizer(target: self, action: #selector(TapFollowerCountLabel(_:)))
           
      HeaderView.OtherUsersFollowingLabel.addGestureRecognizer(TapFollowingGesture)
      HeaderView.OtherUsersFollowingCountLabel.addGestureRecognizer(TapFollowingCountGesture)
      HeaderView.OtherUsersFollowersLabel.addGestureRecognizer(TapFollowerGesture)
      HeaderView.OtherUsersFollowersCountLabel.addGestureRecognizer(TapFollowerCountGesture)
           
      
      return HeaderView
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      //InterNetTableVCのcellタップイベントと同様にして画面遷移すればいい。
      let InterNetTableVCSB = UIStoryboard(name: "InterNetTableView", bundle: nil)
      let InterNetCellTappedVC = InterNetTableVCSB.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      let ImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         InterNetCellTappedVC.setPostUsersStageImage(stageImage: Image!)
      }
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let PlayCount = UsingStageDatas[indexPath.item]["PlayCount"] as! Int
      let UserUID = UsingStageDatas[indexPath.item]["addUser"] as! String
      let UserProfileURL = UsingStageDatas[indexPath.item]["addUsersProfileImageURL"] as! String
      let StageCommentID = UsingStageDatas[indexPath.item]["StageCommentUid"] as! String
      let FcmToken = UsingStageDatas[indexPath.item]["FcmToken"] as! String
      
      InterNetCellTappedVC.setUsersImage(usersImage: self.OtherUsersProfileImage)
      InterNetCellTappedVC.setUsersName(usersName: self.OtherUsersProfileName)
      
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: StageTitle)
      
      
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: String(floor(Double(reviewNum) * 100) / 100) + " / 5")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: String(PlayCount))
      
      InterNetCellTappedVC.setPostUsersUID(postUsersUID: UserUID)
      InterNetCellTappedVC.setPostUsersProfileURL(postUsersProfileURL: UserProfileURL)
      InterNetCellTappedVC.setPostedStageCommentID(CommentID: StageCommentID)
      InterNetCellTappedVC.setFcmToken(FcmToken: FcmToken)
      
      //ステージデータをセットする
      let PiceArray = GetPiceArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let StageArray = GetStageArrayFromDataBase(StageDic: UsingStageDatas[indexPath.item])
      let PlayStageData = GetPlayStageInfoFromDataBase(StageDic: UsingStageDatas[indexPath.item])
           
           
      InterNetCellTappedVC.setPiceArray(PiceArray)
      InterNetCellTappedVC.setStageArray(StageArray)
      InterNetCellTappedVC.setPlayStageData(PlayStageData)
      
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
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

extension OtherUsersProfileViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("No stage posts", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("It will be shown when the stage has been posted", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }

   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}
