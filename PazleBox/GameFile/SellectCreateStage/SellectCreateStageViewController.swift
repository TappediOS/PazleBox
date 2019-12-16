//
//  SellectCreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/07.
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
import NVActivityIndicatorView

class SellectCreateStageViewController: UIViewController {
   
   //let SavedStageDataBase = UserCreateStageDataBase()
   
   //こいつにCollectionVeiwで表示するやつを入れる。
   var UsingStageDatas: [([String: Any])] = Array()
   
   
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   //Firestoreからどれだけとってくるかのやつ。
   let MaxGetStageNumFormDataBase = 21
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
   
   var LoadActivityView: NVActivityIndicatorView?
      
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      self.hero.isEnabled = true
      
      self.StageCollectionView.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      InitLoadActivityView()
      SetUpFireStoreSetting()
      //自分の取得する
      GetMyStageDataFromDataBase()
      
      InitBackButton()
      
      InitHeroID()
      InitAccessibilityIdentifires()
      
      InitNotificationCenter()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      print("ステージ選択できる状態にします。")
      CanSellectStage = true
   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   private func  InitAccessibilityIdentifires() {
      StageCollectionView?.accessibilityIdentifier = "SellectCreateStageVC_StageCollectionView"
      BackButton?.accessibilityIdentifier = "SellectCreateStageVC_BackButton"
   }
   
   private func InitLoadActivityView() {
      let spalete: CGFloat = 9 //横幅 viewWide / X　になる。
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / spalete * (spalete - 1) - Viewsize * 0.35
      let StartY = self.view.frame.height - Viewsize - Viewsize * 0.35
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
   
   
   

   //MARK:- 自分のステージデータを取得する。
   private func GetMyStageDataFromDataBase() {
      print("自分のデータの取得開始")
      self.StartLoadingAnimation() //ローディングアニメーションの再生。
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      print("UID = \(uid)")
      db.collection("Stages")
         .whereField("addUser", isEqualTo: uid)
         .limit(to: MaxGetStageNumFormDataBase)
         .getDocuments() { (querySnapshot, err) in
            if let err = err {
               print("データベースからのデータ取得エラー: \(err)")
            } else {
               for document in querySnapshot!.documents {
                  //GetRawData()はEXファイルに存在している。
                  self.UsingStageDatas.append(self.GetRawData(document: document))
               }
            }
            print("myデータの取得完了")
            //初めて開いた時はUsingにLatestを設定するから単に代入するのみ。
            //Segmentタップした時に別の関数でCollecti onVie をリロードする。
            print("Delegate設定します。")
            
            //読み取りが終わってからデリゲードを入れる必要がある
            self.StageCollectionView.delegate = self
            self.StageCollectionView.dataSource = self
            
            //ローディングアニメーションの停止。
            self.StopLoadingAnimation()
      }
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
         Analytics.logEvent("PlayCreateStageCount", parameters: nil)
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
   
   //TODO:- ローカライズしろよ
   private func  ShowDeleteView(CellNum: Int) {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)

      ComleateView.addButton(NSLocalizedString("Delete", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         self.DeleteDocumentForFireStore(CellNum: CellNum)
         ComleateView.removeFromParent()
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")){
         self.Play3DtouchHeavy()
         ComleateView.removeFromParent()
         self.CanSellectStage = true
      }
      ComleateView.showWarning("ステージの削除", subTitle: "削除したステージは復元できません")
   }
    
   //MARK:- FireStoreからデータを削除する関数
   //TODO:- ローカライズしろよ
   private func DeleteDocumentForFireStore(CellNum: Int) {
      
      let docID = UsingStageDatas[CellNum]["documentID"] as! String
      let addUser = UsingStageDatas[CellNum]["addUser"] as! String
      print("\n\n---データの削除開始---\n\n")
      print("docID = \(docID)")
      print("addUser = \(addUser)")
      print("uid = \(String(describing: UserDefaults.standard.string(forKey: "UID")))")
      
      db.collection("Stages").document(docID).delete() { err in
         if let err = err {
            print("\n削除するのにエラーが発生:\n\(err)")
            self.CanSellectStage = true
            return
         }else {
            print("削除成功しました。")
            self.UsingStageDatas.remove(at: CellNum)
            self.StageCollectionView.reloadData()
            let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: true)
            let ComleateView = SCLAlertView(appearance: Appearanse)
            ComleateView.showSuccess("Success", subTitle: "ステージ削除完了")
            self.CanSellectStage = true
         }
      }
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
