//
//  WorldTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/03/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import TapticEngine
import FirebaseFirestore
import FirebaseRemoteConfig
import Firebase
import NVActivityIndicatorView
import SCLAlertView
import TwicketSegmentedControl
import SnapKit
import FirebaseStorage

class WorldTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
     
   //それぞれFirestoreでとってきてだいにゅうする。
   var LatestStageDatas: [([String: Any])] = Array()
   var RatedStageDatas: [([String: Any])] = Array()
   var PlayCountStageDatas: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   
   var db: Firestore!
   let MaxGetStageNumFormDataBase = 15
   
   var RefleshControl = UIRefreshControl()
   
   @IBOutlet weak var WorldTableView: UITableView!
   
   var LoadActivityView: NVActivityIndicatorView?
   var segmentedControl: TwicketSegmentedControl?
   
   var CanSellectStage: Bool = true
   
   //For文で回す時に，どれだけ回して，どのタイミングで更新するかを測るやつ.
   var DownLoadProfileCounterForLatest = 0
   var DownLoadProfileCounterForPlayCount = 0
   var DownLoadProfileCounterForRated = 0
   
   //最初の自動ダウンロードが終わってるかどうか
   //これがtrueの時は引っ張って更新ができなくなる
   var isFetchDataWhenDidLoadThisVC = true
   
   var BlockList = Array<String>()
   var BlockedList = Array<String>()
   
   let PlayOurStagesKey = "can_play_ourStages"
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      Analytics.logEvent("showWorldStageVC", parameters: nil)

      SetUpWorldTableView()
      SetUpNavigationController()
      InitLoadActivityView()
      SetUpRefleshControl()
      SetUpFireStoreSetting()
      
      FetchBlockListAndBlockedListFromFireStore(FetchType: .all)
      
      InitSegmentedControl()
   }
   
   //MARK:- segmentのオートレイアウトをしている
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      if #available(iOS 11.0, *) {
         let safeAreTop = self.view.safeAreaInsets.top
         self.segmentedControl?.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(safeAreTop + 11)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(40)
         }
      }
   }
   
   @objc func TapShowOurPuzzleStage(sender: UIBarButtonItem) {
      let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
      let vc = StoryBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
      vc.modalPresentationStyle = .fullScreen
      Play3DtouchLight()
      Analytics.logEvent("showOurStageVCTapNaviItemWorldS", parameters: nil)
      self.navigationController?.pushViewController(vc, animated: true)
   }
   
   func SetUpWorldTableView() {
      WorldTableView.rowHeight = 160
      var BottonInsets: CGFloat = 0
      if UserDefaults.standard.bool(forKey: "BuyRemoveAd") == false {
         BottonInsets = 50
      }
      WorldTableView.contentInset = UIEdgeInsets(top: 61.0, left: 0, bottom: BottonInsets, right: 0)
   }
   
   func SetUpNavigationController() {
      self.navigationItem.title = NSLocalizedString("WorldStage", comment: "")
    
      var image = UIImage()
      image = UIImage(systemName: "gamecontroller.fill")!
    
      let SettingButtonItems = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(TapShowOurPuzzleStage(sender:)))
      SettingButtonItems.tintColor = .systemPink
      self.navigationItem.setLeftBarButton(SettingButtonItems, animated: true)
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 5
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / 2 - (Viewsize / 2)
      let StartY = self.view.frame.height / 2 - (Viewsize / 2)
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
   }
   
   func SetUpRefleshControl() {
      self.WorldTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   
   
   
   
   func ShowErrGetStageAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         ComleateView.dismiss(animated: true)
         self.Play3DtouchHeavy()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errGetDoc = NSLocalizedString("errGetDoc", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errGetDoc + "\n" + checkNet)
   }
   
   //MARK:- ローディングアニメーション再生
   func StartLoadingAnimation() {
      print("ローディングアニメーション再生")
      self.LoadActivityView?.startAnimating()
      return
   }
   
   public func StopLoadingAnimation() {
      print("ローディングアニメーション停止")
      if LoadActivityView?.isAnimating == true {
         self.LoadActivityView?.stopAnimating()
      }
   }
   
   //MARK:- セグメントのInit
   private func InitSegmentedControl() {
      let Latest = NSLocalizedString("Latest", comment: "")
      let PlayCount = NSLocalizedString("PlayCount", comment: "")
      let Rating = NSLocalizedString("Rating", comment: "")
      let titles = [Latest, PlayCount, Rating]

      segmentedControl = TwicketSegmentedControl()
      segmentedControl?.setSegmentItems(titles)
      segmentedControl?.delegate = self
      
      segmentedControl?.backgroundColor = UIColor.white.withAlphaComponent(0.87)
      
      view.addSubview(segmentedControl!)
   }
      
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      guard let indexNum = self.segmentedControl?.selectedSegmentIndex else {
         print("リロードする前に，セグメントのインデックスがnilやから中止する。")
         RefleshControl.endRefreshing()
         return
      }
      
      guard self.isFetchDataWhenDidLoadThisVC == false else {
         print("まだ最初のローディングをしている最中なので引っ張って更新はできません")
         RefleshControl.endRefreshing()
         return
      }
      
      switch indexNum{
      case 0:
         print("Latestの更新をします。")
         FetchBlockListAndBlockedListFromFireStore(FetchType: .latest)
      case 1:
         print("PlayCountの更新をします。")
         FetchBlockListAndBlockedListFromFireStore(FetchType: .playCount)
         print("Ratingの更新をします。")
      case 2:
         FetchBlockListAndBlockedListFromFireStore(FetchType: .rated)
      default:
         print("nilじゃなかったら何？")
         RefleshControl.endRefreshing()
      }
   }
      
   @objc func TapUserImageButtonWorldTableView(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
      
      //本人をタップしてたら，
      if TapedUserIsSelf(rowNum: rowNum) == true {
         Analytics.logEvent("pushUserProfileVC", parameters: nil)
         print("本人をタップしたので，UesrsProfileVCを表示します")
         let UsersProfileSB = UIStoryboard(name: "UserProfileViewControllerSB", bundle: nil)
         let UsersProfileVC = UsersProfileSB.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
         self.navigationController?.pushViewController(UsersProfileVC, animated: true)
         return
      }
      //本人以外をタップしてたら
      Analytics.logEvent("pushOtherUserProfileVC", parameters: nil)
      print("他人をタップしたので，OtherUesrsProfileVCを表示します")
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
   
      let OtherUsersUID = UsingStageDatas[rowNum]["addUser"] as! String
      OtherUsersProfileVC.fetchOtherUsersUIDbeforPushVC(uid: OtherUsersUID)
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
   
   //タップした画像のユーザが本人かどうかを判定する
   private func TapedUserIsSelf(rowNum: Int) -> Bool {
      let TapedUsersUID = UsingStageDatas[rowNum]["addUser"] as! String
      let UsersUID = UserDefaults.standard.string(forKey: "UID")
      
      if TapedUsersUID == UsersUID { return true}
      return false
   }
      
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
