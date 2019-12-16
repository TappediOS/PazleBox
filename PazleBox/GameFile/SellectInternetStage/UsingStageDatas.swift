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
import NVActivityIndicatorView
import SnapKit

class SellectInternetStageViewController: UIViewController {
   
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
   
   //それぞれFirestoreでとってきてだいにゅうする。
   var LatestStageDatas: [([String: Any])] = Array()
   var RatedStageDatas: [([String: Any])] = Array()
   var PlayCountStageDatas: [([String: Any])] = Array()
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   //Firestoreからどれだけとってくるかのやつ。
   let MaxGetStageNumFormDataBase = 18
   
   var db: Firestore!

   @IBOutlet weak var StageCollectionView: UICollectionView!
   
   //こいつがCollecti on viewのレイアウトを決めている
   let sectionInsets = UIEdgeInsets(top: 13.0, left: 6.0, bottom: 5.0, right: 6.0)
   //Cellを横に何個入れるか
   let itemsPerRow: CGFloat = 3
   
   //ステージが選択できるかどうか
   var CanSellectStage: Bool = true
   
   var BackButton: FUIButton?
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var PlayStageData = PlayStageRefInfo()
   
   var LoadActivityView: NVActivityIndicatorView?
   
   var segmentedControl: TwicketSegmentedControl?
      
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      InitViewSetting()
     
      InitLoadActivityView()
      
      SetUpFireStoreSetting()
            
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
   
   //safeArea取得するために必要。
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
   
      SNPSBackButton()
      SNPSegment()
   }
   
   //MARK:- SNPの設定。
   func SNPSBackButton() {
      BackButton!.snp.makeConstraints{ make in
         let Height:CGFloat = 35
         make.height.equalTo(Height)
         make.width.equalTo(Height * 2.2)
         make.leading.equalTo(self.view.snp.leading).offset(10)
         if #available(iOS 11, *) {
            print("safeArea.top = \(self.view.safeAreaInsets.top)")
            make.top.equalTo(self.view.snp.top).offset(self.view.safeAreaInsets.top + 3)
         } else {
            //iOS11以下は，X系が存在していない。
            make.top.equalTo(self.view.snp.top).offset(20)
         }
      }
   }
   
   
   func SNPSegment() {
      segmentedControl!.snp.makeConstraints{ make in
         let Height:CGFloat = 35
         
         make.height.equalTo(Height)
         make.leading.equalTo(self.view.snp.leading).offset(5)
         make.width.equalTo(self.view.frame.width - 10)
         make.top.equalTo((self.BackButton?.snp.bottom)!).offset(4.5)
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      print("ステージ選択できる状態にします。")
      CanSellectStage = true
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
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 9 //横幅 viewWide / X　になる。
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / spalete * (spalete - 1) - Viewsize * 0.45
      let StartY = self.view.frame.height - Viewsize - Viewsize * 0.45
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
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
            
             //ローディングアニメーションの停止
            self.StopLoadingAnimation()
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
   
   
   private func  InitAccessibilityIdentifires() {
      StageCollectionView?.accessibilityIdentifier = "SellectInternetStageVC_StageCollectionView"
      BackButton?.accessibilityIdentifier = "SellectInternetStageVC_BackButton"
   }
   
   //MARK:- セグメントのInit
   //TODO:- frameを変更すること。
   //TODO:- タイトルの名前をローカライズすること。
   private func InitSegmentedControl() {
      let titles = ["Latest", "Play Count", "Rated"]
      let frame = CGRect(x: 5, y: 57, width: view.frame.width - 10, height: 40)

      segmentedControl = TwicketSegmentedControl(frame: frame)
      segmentedControl?.setSegmentItems(titles)
      segmentedControl?.delegate = self

      view.addSubview(segmentedControl!)
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
   

   
   @objc func TapCloseButtonCatchNotification(notification: Notification) -> Void {
      print("TapCloseButton Catch Notification")
      self.GameSound.PlaySoundsTapButton()
      CanSellectStage = true
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

