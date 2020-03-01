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
import Firebase
import NVActivityIndicatorView
import SCLAlertView
import TwicketSegmentedControl
import SnapKit

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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      WorldTableView.rowHeight = 160
      
      InitLoadActivityView()
      SetUpRefleshControl()
      SetUpFireStoreSetting()
      
      GetLatestStageDataFromDataBase()
      GetRatedStageDataFromDataBase()
      GetPlayCountStageDataFromDataBase()
      
      InitSegmentedControl()
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
   
   //MARK:- 最新，回数，評価それぞれのデータを取得する。
   private func GetLatestStageDataFromDataBase() {
      print("Latestデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
      db.collection("Stages")
         .order(by: "addDate", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
               self.Play3DtouchError()
               self.ShowErrGetStageAlertView()
            } else {
               self.Play3DtouchSuccess()
               for document in querySnapshot!.documents {
                  self.LatestStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("Latestデータの取得完了")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            self.UsingStageDatas = self.LatestStageDatas
            print("Delegate設定します。")
               
            //読み取りが終わってからデリゲードを入れる必要がある
            self.WorldTableView.delegate = self
            self.WorldTableView.dataSource = self
            self.WorldTableView.reloadData()
             //ローディングアニメーションの停止
            self.StopLoadingAnimation()
      }
   }
   
   private func GetPlayCountStageDataFromDataBase(){
      print("PlayCountデータの取得開始")
      db.collection("Stages").whereField("PlayCount", isGreaterThanOrEqualTo: 0)
         .order(by: "PlayCount", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
            } else {
               for document in querySnapshot!.documents {
                  self.PlayCountStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("PlayCountデータの取得完了")
      }
   }
   
   private func GetRatedStageDataFromDataBase() {
      print("Ratedデータの取得開始")
      db.collection("Stages").whereField("ReviewAve", isGreaterThanOrEqualTo: 0)
         .order(by: "ReviewAve", descending: true)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
            } else {
            
               for document in querySnapshot!.documents {
                  self.RatedStageDatas.append(self.GetRawData(document: document))
               }
            }
            //ここでは必要な配列を作っただけで何もする必要はない。
            //ここで作った配列(self.LatestStageDatas)
            //はSegmentタップされたときにUsingStageDataに代入してリロードすればいい。
            print("Ratedデータの取得完了")
      }
   }
   
   private func ShowErrGetStageAlertView() {
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
   private func StartLoadingAnimation() {
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
   
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetRawData(document: DocumentSnapshot) -> ([String: Any]) {
      var StageData: [String: Any] =  ["documentID": document.documentID]
      var maxPiceNum: Int = 1
            
      if let value = document["ReviewAve"] as? CGFloat {
         StageData.updateValue(value, forKey: "ReviewAve")
      }
            
      if let value = document["PlayCount"] as? Int {
         StageData.updateValue(value, forKey: "PlayCount")
      }
      
      if let value = document["ReviewCount"] as? Int {
         StageData.updateValue(value, forKey: "ReviewCount")
      }
            
      if let value = document["addUser"] as? String {
         StageData.updateValue(value, forKey: "addUser")
      }
            
      if let value = document["addDate"] as? Timestamp {
         let date: Date = value.dateValue()
               
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         StageData.updateValue((dataAsString), forKey: "addDate")
      }
            
      if let value = document["MaxPiceNum"] as? Int {
         StageData.updateValue(value, forKey: "MaxPiceNum")
         maxPiceNum = value
      }
      
      if let value = document["ImageData"] as? Data {
         StageData.updateValue(value, forKey: "ImageData")
      }
            
      for tmp in 1 ... 12 {
         let FieldName = "Field" + String(tmp)
         if let value = document[FieldName] as? Array<Int> {
            StageData.updateValue(value, forKey: FieldName)
         }
      }
            
      for tmp in 1 ... maxPiceNum {
         let PiceName = "PiceInfo" + String(tmp)
         if let value = document[PiceName] as? Array<Any> {
            StageData.updateValue(value, forKey: PiceName)
         }
      }
            
      //      for data in StageData {
      //         //print("\(data.key) -> \(data.value)")
      //      }
            
      return StageData
   }
    
   //MARK:- セグメントのInit
   private func InitSegmentedControl() {
      let Latest = NSLocalizedString("Latest", comment: "")
      let PlayCount = NSLocalizedString("PlayCount", comment: "")
      let Rating = NSLocalizedString("Rating", comment: "")
      let titles = [Latest, PlayCount, Rating]
      let frame = CGRect(x: 5, y: 57, width: view.frame.width - 10, height: 40)

      segmentedControl = TwicketSegmentedControl(frame: frame)
      segmentedControl?.setSegmentItems(titles)
      segmentedControl?.delegate = self

      view.addSubview(segmentedControl!)
   }
      
      
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
      
   @objc func TapUserImageButtonInterNetTableView(_ sender: UIButton) {
      let rowNum = sender.tag
      print("\(rowNum)番目のcellがタップされました")
         
      let OtherUsersProfileSB = UIStoryboard(name: "OtherUsersProfileViewControllerSB", bundle: nil)
      let OtherUsersProfileVC = OtherUsersProfileSB.instantiateViewController(withIdentifier: "OtherUsersProfileVC") as! OtherUsersProfileViewController
               
      self.navigationController?.pushViewController(OtherUsersProfileVC, animated: true)
   }
      
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
