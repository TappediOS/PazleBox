//
//  ExInterNetTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/23.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet
import Firebase
import FirebaseAnalytics

extension InterNetTableViewController {
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
      let cell = self.InterNetTableView.dequeueReusableCell(withIdentifier: "InterNetCell", for: indexPath) as? InterNetTableViewCell
      
      let StageImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = StageImageData {
         let Image = UIImage(data: data as Data)
         cell?.GameScreenshotImageView.image = Image
      }
      
      let usersProfileData = UsingStageDatas[indexPath.item]["PostedUsersProfileImage"] as? NSData
      if let ProfileData = usersProfileData {
         let Image = UIImage(data: ProfileData as Data)
         cell?.UserImageViewButton.setImage(Image, for: .normal)
      }
      
      cell?.UserImageViewButton.tag = indexPath.row
      cell?.UserImageViewButton.addTarget(self, action: #selector(TapUserImageButtonInterNetTableView(_:)), for: .touchUpInside)
      
      let StageTitle = UsingStageDatas[indexPath.item]["StageTitle"] as! String
      let reviewNum = UsingStageDatas[indexPath.item]["ReviewAve"] as! CGFloat
      let UserName = UsingStageDatas[indexPath.item]["PostedUsersName"] as! String
   
      
      
      
      cell?.UserNameLabel.text = UserName
      cell?.PuzzleTitleLabel.text = StageTitle
      
      cell?.RatedLabel.text = String(floor(Double(reviewNum) * 100) / 100) + " / 5"
      cell?.PlayCountLabel.text = String(UsingStageDatas[indexPath.item]["PlayCount"] as! Int)
      cell?.CreatedDayLabel.text = UsingStageDatas[indexPath.item]["addDate"] as! String

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      let InterNetCellTappedVC = self.storyboard?.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      let StageImageData = UsingStageDatas[indexPath.item]["ImageData"] as? NSData
      if let data = StageImageData {
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
      let FcmToken = UsingStageDatas[indexPath.item]["FcmToken"] as! String
      
      let usersProfileImageData = UsingStageDatas[indexPath.item]["PostedUsersProfileImage"] as? NSData
      if let ProfileImageData = usersProfileImageData {
         let Image = UIImage(data: ProfileImageData as Data)
         InterNetCellTappedVC.setUsersImage(usersImage: Image!)
      }
      
      InterNetCellTappedVC.setUsersName(usersName: UserName)
      
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
      
      Analytics.logEvent("pushInterNetCellTappedVC", parameters: nil)
      self.navigationController?.pushViewController(InterNetCellTappedVC, animated: true)
   }
}

extension InterNetTableViewController {
//   func scrollViewDidScroll(_ scrollView: UIScrollView) {
//      guard self.RefleshControl.isRefreshing == false else {
//         return
//      }
//      guard isLoadingDataFirestoreWhenDownTabelview == false else {
//         return
//      }
//
//      let height = scrollView.frame.size.height
//      let contentYoffset = scrollView.contentOffset.y
//      let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//      if distanceFromBottom >= height {
//         return
//      }
//
//      print("データをダウンロードします。")
//      self.isLoadingDataFirestoreWhenDownTabelview = true
//
//   }
}


extension InterNetTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("No stage posts", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let str = NSLocalizedString("IfYouFollow", comment: "")
       let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
       return NSAttributedString(string: str, attributes: attrs)
   }
   
   func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
//      let isPlayingOurStages = self.remoteConfig[self.PlayOurStagesKey].boolValue
//      guard isPlayingOurStages else {
//         return 0
//      }
      return 36
   }
   
   func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
      let isPlayingOurStages = self.remoteConfig[self.PlayOurStagesKey].boolValue
      guard isPlayingOurStages else {
         return 0
      }
      return -19
   }
   
   
   func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
//      let isPlayingOurStages = self.remoteConfig[self.PlayOurStagesKey].boolValue
//      guard isPlayingOurStages else {
//         return nil
//      }
      let str = NSLocalizedString("Play", comment: "")

      return NSAttributedString(
         string: str,
         attributes: [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title3),
            NSAttributedString.Key.foregroundColor: UIColor.white,
         ]
      )
   }
   
   
   
   func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
      let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
      let vc = StoryBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
      vc.modalPresentationStyle = .fullScreen
      Play3DtouchLight()
      //GameSound.PlaySoundsTapButton()
      self.navigationController?.pushViewController(vc, animated: true)
      Analytics.logEvent("showOurStageVCTapEmptyDataSet", parameters: nil)
   }
   
   
   func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
      let defaultSize = view.bounds.size.width * 0.88
      let afterSize = view.bounds.size.width * 0.4
      let padding: CGFloat = 14
      return UIImage(color: .systemPink, cornerRadius: 8).ReduceImageWidthAndHight(before: defaultSize, objectSize: afterSize, padding: padding)
   }
   


   //スクロールできるようにする
   func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
      return true
   }
}

extension UIImage {
   func ReduceImageWidthAndHight(before imageSize: CGFloat, objectSize: CGFloat, padding: CGFloat) -> UIImage {
      var rectInsets = UIEdgeInsets.zero
      let widthBetweenBackgroundAndLabel = (imageSize - objectSize) / 2
      let shrinkWidth = widthBetweenBackgroundAndLabel - padding
      rectInsets = UIEdgeInsets(top: 15.1, left: -shrinkWidth, bottom: 15.1, right: -shrinkWidth)
      return withAlignmentRectInsets(rectInsets)
   }

}
