//
//  OtherUsersProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/27.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class OtherUsersProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var OtherUesrsProfileTableView: UITableView!
   private let sectionHeaderHeight: CGFloat = 200
      
   var RefleshControl = UIRefreshControl()
      
      
   override func viewDidLoad() {
      super.viewDidLoad()
         
      SetUpRefleshControl()
         
      OtherUesrsProfileTableView.rowHeight = 160
      OtherUesrsProfileTableView.delegate = self
      OtherUesrsProfileTableView.dataSource = self
   }
      
   func SetUpRefleshControl() {
      self.OtherUesrsProfileTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
   
   @objc func TapFollowOrUnFollowButton(_ sender: UIButton) {
      print("TFollowOrUnFollowButtonがタップされた")
   }
}


extension OtherUsersProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 25
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.OtherUesrsProfileTableView.dequeueReusableCell(withIdentifier: "OtherUsersProfileCell", for: indexPath) as? OtherUsersProfileTableViewCell
      

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
      let followButton = HeaderView.getFollowOrUnFollowButton()
      followButton.addTarget(self, action: #selector(TapFollowOrUnFollowButton(_:)), for: .touchUpInside)
      return HeaderView
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      //InterNetTableVCのcellタップイベントと同様にして画面遷移すればいい。
      let InterNetTableVCSB = UIStoryboard(name: "InterNetTableView", bundle: nil)
      let InterNetCellTappedVC = InterNetTableVCSB.instantiateViewController(withIdentifier: "InterNetCellTappedVC") as! InterNetCellTappedViewController
      
      InterNetCellTappedVC.setPostUsersStageImage(stageImage: UIImage(named: "23p2Red")!)
      InterNetCellTappedVC.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      InterNetCellTappedVC.setUsersName(usersName: "Supar Boy")
      
      InterNetCellTappedVC.setPostUsersStageTitle(stageTitle: "Drop Card")
      
      
      InterNetCellTappedVC.setPostUsersStageReview(stageReview: "1.92 / 5 ")
      InterNetCellTappedVC.setPostUsersStagePlayCount(stagePlayCount: "542")
      
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