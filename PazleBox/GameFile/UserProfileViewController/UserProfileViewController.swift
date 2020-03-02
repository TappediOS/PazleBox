//
//  UserProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/24.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   
   @IBOutlet weak var UserProfileTableView: UITableView!
   private let sectionHeaderHeight: CGFloat = 200
   
   var RefleshControl = UIRefreshControl()
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      SetUpNavigationController()
      
      SetUpRefleshControl()
      
      UserProfileTableView.rowHeight = 160
      UserProfileTableView.delegate = self
      UserProfileTableView.dataSource = self
   }
   
   func SetUpNavigationController() {
      var image = UIImage()
      if #available(iOS 13, *) {
         image = UIImage(systemName: "gear")!
      } else {
         image = UIImage(named: "Gear.png")!
      }
      
      let SettingButtonItems = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(TapSettingButton(sender:)))
      SettingButtonItems.tintColor = .black
      self.navigationItem.setLeftBarButton(SettingButtonItems, animated: true)
      
      let EditProfile = "Edit Profile"
      let EditProfileItem = UIBarButtonItem(title: EditProfile, style: .plain, target: self, action: #selector(TapEditProfileButton(sender:)))
      EditProfileItem.tintColor = .black
      self.navigationItem.setRightBarButton(EditProfileItem, animated: true)
      
      //TODO:- ローカライズすること
      self.navigationItem.title = NSLocalizedString("My Page", comment: "")
   }
   
   //MARK:- 設定ボタンを押したときの処理
   @objc func TapSettingButton(sender: UIBarButtonItem) {
      print("tap setting")
   }
   
   @objc func TapEditProfileButton(sender: UIBarButtonItem) {
      print("tap editProfile")
   }
   
   func SetUpRefleshControl() {
      self.UserProfileTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
}

extension UserProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 25
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UserProfileTableView.dequeueReusableCell(withIdentifier: "UserProfileTableCell", for: indexPath) as? UserProfileTableViewCell
      

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
      let UserProfileTapCellViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileTapCellVC") as! UserProfileTapCellViewController
      
      UserProfileTapCellViewController.setUsersImage(usersImage: UIImage(named: "hammer.png")!)
      UserProfileTapCellViewController.setUsersName(usersName: "Great Girl")
      
      UserProfileTapCellViewController.setPostUsersStageImage(stageImage: UIImage(named: "23p9Blue.png")!)
      UserProfileTapCellViewController.setPostUsersStageTitle(stageTitle: "Rest MeeE")
         
         
      UserProfileTapCellViewController.setPostUsersStageReview(stageReview: String(floor(Double(4.12) * 100) / 100) + " / 5")
      UserProfileTapCellViewController.setPostUsersStagePlayCount(stagePlayCount: String(382))
         
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
