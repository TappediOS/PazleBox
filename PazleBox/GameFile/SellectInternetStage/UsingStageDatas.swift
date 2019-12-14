//
//  SellectInternetStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/12/01.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import RealmSwift
import TapticEngine
import FlatUIKit
import Hero
import Firebase
import SCLAlertView
import TwicketSegmentedControl


class SellectInternetStageViewController: UIViewController {
   
   let SavedStageDataBase = UserCreateStageDataBase()
   
   var UsingStageDatas: [([String: Any])] = Array()
   
   var LatestStageDatas: [([String: Any])] = Array()
   var RatedStageDatas: [([String: Any])] = Array()
   var PlayCountStageDatas: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   let MaxGetStageNumFormDataBase = 15
   
   var db: Firestore!

   @IBOutlet weak var StageCollectionView: UICollectionView!
   
   //こいつがCollecti on viewのレイアウトを決めている
   let sectionInsets = UIEdgeInsets(top: 13.0, left: 6.0, bottom: 5.0, right: 6.0)
   let itemsPerRow: CGFloat = 3 //Cellを横に何個入れるか
   
   //ステージが選択できるかどうか
   var CanSellectStage: Bool = true
   
   var BackButton: FUIButton?
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var PlayStageData = PlayStageRefInfo()
      
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      InitViewSetting()
      
      SetUpFireStoreSetting()
      
      //GetALLStageDataFromDataBase()
      
      //最新，評価，回数でそれぞれ取得する
      GetLatestStageDataFromDataBase()
      GetRatedStageDataFromDataBase()
      GetPlayCountStageDataFromDataBase()
      
      
      InitBackButton()
      
      InitSegmentedControl()
      
      InitHeroID()
      InitAccessibilityIdentifires()
      
      InitNotificationCenter()
      
      
      

   }
   
   override func viewWillAppear(_ animated: Bool) {
      print("ステージ選択できる状態にします。")
      CanSellectStage = true
      //GetALLStageDataFromDataBase()
   }
   
   private func InitViewSetting() {
      self.hero.isEnabled = true
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      self.StageCollectionView.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   
   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   private func GetRawData(document: DocumentSnapshot) -> ([String: Any]) {
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
      
      //FIXME:- これはなんか取得できてない
      if let value = document["addDate"] as? Timestamp {
         print(value.dateValue())
         StageData.updateValue(value.dateValue(), forKey: "addDate")
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
      
      for data in StageData {
         //print("\(data.key) -> \(data.value)")
      }
      
      return StageData
   }
   
   //データベースからデータゲットして配列に格納
   private func GetALLStageDataFromDataBase() {
      db.collection("Stages").getDocuments() { (querySnapshot, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
         } else {
            for document in querySnapshot!.documents {
               self.LatestStageDatas.append(self.GetRawData(document: document))
            }
         }
         
         //読み取りが終わってからデリゲードを入れる必要がある
         self.StageCollectionView.delegate = self
         self.StageCollectionView.dataSource = self
      }
   }
   
   
   //FIXME:- 最新データでない可能性がある。
   private func GetLatestStageDataFromDataBase() {
      print("Latestデータの取得開始")
      db.collection("Stages").limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
      if let err = err {
         print("データベースからのデータ取得エラー: \(err)")
      } else {
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
         self.StageCollectionView.delegate = self
         self.StageCollectionView.dataSource = self
      }
   }
   
   private func GetRatedStageDataFromDataBase() {
      print("Ratedデータの取得開始")
      db.collection("Stages").whereField("ReviewAve", isGreaterThan: 2)
         .order(by: "ReviewAve")
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
   
   private func GetPlayCountStageDataFromDataBase(){
      print("PlayCountデータの取得開始")
      db.collection("Stages").whereField("PlayCount", isGreaterThan: 2)
         .order(by: "PlayCount")
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
   
   
   private func  InitAccessibilityIdentifires() {
      StageCollectionView?.accessibilityIdentifier = "SellectInternetStageVC_StageCollectionView"
      BackButton?.accessibilityIdentifier = "SellectInternetStageVC_BackButton"
   }
   
   //TODO:- frameを変更すること。
   //TODO:- タイトルの名前をローカライズすること。
   private func InitSegmentedControl() {
      let titles = ["Rated", "Play Count", "Latest"]
      let frame = CGRect(x: 5, y: 57, width: view.frame.width - 10, height: 40)

      let segmentedControl = TwicketSegmentedControl(frame: frame)
      segmentedControl.setSegmentItems(titles)
      segmentedControl.delegate = self

      view.addSubview(segmentedControl)
   }
   
   private func InitBackButton() {
      let FirstX = view.frame.width / 25
      let FirstY = view.frame.width / 25
      let width = view.frame.width / 5
      let Frame = CGRect(x: FirstX, y: FirstY * 1.95, width: width, height: width / 2.2)
      BackButton = FUIButton(frame: Frame)
      BackButton?.setTitle("←", for: UIControl.State.normal)
      BackButton?.buttonColor = UIColor.flatMintColorDark()
      BackButton?.shadowColor = UIColor.flatMintColorDark()
      BackButton?.shadowHeight = 3.0
      BackButton?.cornerRadius = 6.0
      BackButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      BackButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      BackButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      BackButton?.addTarget(self, action: #selector(self.TapBackButton(_:)), for: UIControl.Event.touchUpInside)
      BackButton?.hero.modifiers = [.arc()]
      view.addSubview(BackButton!)
   }
   
   func InitHeroID() {
      BackButton?.hero.id = HeroID.CreateFinCreateAndSellectBack
      StageCollectionView.hero.modifiers = [.cascade]
   }
   
   @objc func TapBackButton(_ sender: FUIButton) {
      Play3DtouchMedium()
      GameSound.PlaySoundsTapButton()
      self.dismiss(animated: true, completion: nil)
   }
   
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(TapPlayButtonCatchNotification(notification:)), name: .TapPlayButton, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapDeleteButtonCatchNotification(notification:)), name: .TapDeleteButton, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapCloseButtonCatchNotification(notification:)), name: .TapCloseButton, object: nil)
   }
   
   @objc func TapPlayButtonCatchNotification(notification: Notification) -> Void {
      print("TapPlayButton Catch Notification")
      
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["CellNum"] as! Int
         print("送信されたCellNum: \(SentNum)")
         
         LoadStageInfomation(CellNum: SentNum)
         PresentGameViewController()
         Analytics.logEvent("PlayInternetStageCount", parameters: nil)
      }else{
         print("誰が来たからからない")
      }
   }
   
   @objc func TapDeleteButtonCatchNotification(notification: Notification) -> Void {
      print("TapDeleteButton Catch Notification")
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["CellNum"] as! Int
         print("送信されたCellNum: \(SentNum)")
         
         ShowDeleteView(CellNum: SentNum)
         
         GameSound.PlaySoundsTapButton()
         
         
      }else{
         print("誰が来たからからない")
      }
   }
   
   @objc func TapCloseButtonCatchNotification(notification: Notification) -> Void {
      print("TapCloseButton Catch Notification")
      self.GameSound.PlaySoundsTapButton()
      CanSellectStage = true
   }
   
   private func  ShowDeleteView(CellNum: Int) {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)

      ComleateView.addButton(NSLocalizedString("Delete", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.DeleteCell(CellNum: CellNum)
         ComleateView.removeFromParent()
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")){
         self.Play3DtouchHeavy()
         ComleateView.removeFromParent()
         self.CanSellectStage = true
      }
      ComleateView.showWarning("ステージの削除", subTitle: "削除したステージは復元できません")
   }
   
   //MARK:- 削除するのをFirestoreにする
   private func DeleteCell(CellNum: Int) {
      SavedStageDataBase.DeleteUserCreateStageDataBase(at: CellNum)
      self.StageCollectionView.reloadData()
      
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: true)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.showSuccess("Success", subTitle: "ステージ削除完了")
      self.CanSellectStage = true
   }
   
   /// Collection ViewのCellがタップされた後にステージ情報を取得する関数
   /// - Parameter CellNum: セル番号
   func LoadStageInfomation(CellNum: Int) {
      //EXファイルに存在している
      //Usingの配列を使用してどデータのやり取りをする。
      //Segmentのでりゲードを利用して変更するべきである。
      PiceArray = GetPiceArrayFromDataBase(StageDic: UsingStageDatas[CellNum])
      StageArray = GetPiceArrayFromDataBase(StageDic: UsingStageDatas[CellNum])
      PlayStageData = GetPlayStageInfoFromDataBase(StageDic: UsingStageDatas[CellNum])
   }
   
   /// GameVCをプレゼントする関数
   func PresentGameViewController() {
      let GameVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      GameVC.LoadPiceArray(PiceArray: PiceArray)
      GameVC.LoadStageArray(StageArray: StageArray)
      GameVC.LoadPlayStageData(RefID: PlayStageData.RefID, stageDataForNoDocExsist: self.PlayStageData)
      GameVC.modalPresentationStyle = .fullScreen
      //HomeViewに対してBGMを消してって通知を送る
      NotificationCenter.default.post(name: .StopHomeViewBGM, object: nil, userInfo: nil)
      self.present(GameVC, animated: true, completion: {
         print("プレゼント終わった")
      })
   }
   
   
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
}

