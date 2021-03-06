//
//  UsersGameViewController.swift
//  PazleBox
//
//  Created by jun on 2019/10/07.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import GameplayKit
import SAConfettiView
import FirebaseFirestore
import Firebase
import RealmSwift
import Hero
import ChameleonFramework

class UsersGameViewController: UIViewController, GADInterstitialDelegate {
   
   var ConfettiView = SAConfettiView()
   var ClearView: GameClearView?
   
   let GameClearVeiwIntensity: Float = 0.65
   var ShowGameClearView = false
   
   var SellectStageNumber = 0

   var ViewFrame: CGRect?
   
   let GameSound = GameSounds()
   let GameBGM = BGM()
   
   let StarAnimationBetTime = 0.4659
   
   //GohomeButtonを押したとに広告表示する場合の判定
   var GoHomeForInstitialAD = false
   
   //FIXME: 構造体にしとけよ...
   let MaxStageNum = 50

   
   var Interstitial: GADInterstitial!
   let INTERSTITIAL_TEST_ID = "ca-app-pub-3940256099942544/4411468910"
   let INTERSTITIAL_ID = "ca-app-pub-1460017825820383/5793475595"
   
   //インターステーシャル広告出すまでの回数
   var InterstitialCount = 2
   var InterstitialCountBase = 2
   
   //MARK: user defaults
   var userDefaults: UserDefaults = UserDefaults.standard

   let realm = try! Realm()
   
   var UserStageArray: [[Contents]] = Array()
   var UserPiceArray: [PiceInfo] = Array()
   
   var isLockedHomeFunction: Bool = false
   
   //RefID Playcount? ReviewAve? 入ってるやつ
   var PlayStageData = PlayStageRefInfo()
   
   var db: Firestore = Firestore.firestore()
   
   let networkChecker = NetworkCheck()
   
   var PostedUsersUID = ""
   var PostedUsersName = ""
   var PostedusersProfileURL = ""
   var PostedUsersFcmToken = ""
   var CommentRefID = ""
   
   
   var usersUID = ""
   var usersName = ""
   var usersProfileURL = ""
   var usersFcmToken = ""
   
   //スワイプ無効にするやつ
   @available(iOS 11, *)
   override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
      return .bottom
   }
   
  
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
      let InitVCTimePeformance = Performance.startTrace(name: "InitUsersGameVCTime")

      ViewFrame = self.view.frame
      self.hero.isEnabled = true
   
      InitNotificationCenter()
      InitConfettiView()
      InitGameClearView()
      
      InitAllADCheck()
      
      GameSound.PlaySoundsTapButton()
      InitGameViewAndShowView()
      PlayGameBGM()
      
      InitVCTimePeformance?.stop()
   }
   
   
   private func InitAllADCheck() {
      if userDefaults.bool(forKey: "BuyRemoveAd") == false{
         InitInstitial()
         InitInstitialCount()
         InitInstitialLabelOFClearView()
      }else{
         print("課金をしているので広告の初期化は行いません")
      }
   }
   
   private func InitGameClearView() {
      ClearView = GameClearView(frame: ViewFrame!)
      ClearView?.ChangeNextButtonNameForUsersGameClearView()
      if userDefaults.bool(forKey: "BuyRemoveAd") == false{
         ClearView?.InitBannerViewGetRootViewController(SelfViewCon: self)
         ClearView?.InitBannerViewRequest()
      }
   }
   
   private func InitInstitialLabelOFClearView() {
      ClearView?.SetCountOfNextADLabel(NextCount: userDefaults.integer(forKey: "InterstitialCount"))
   }
   
   private func InitInstitial() {
      #if DEBUG
         print("Users インターステイシャル:テスト環境")
         Interstitial = GADInterstitial(adUnitID: INTERSTITIAL_TEST_ID)
         if let ADID = Interstitial.adUnitID {
            print("Usersインタースティシャルテスト広告ID読み込み完了")
            print("TestID = \(ADID)")
         }else{
            print("インタースティシャルテスト広告ID読み込み失敗")
         }
      #else
         print("インターステイシャル:本番環境")
         Interstitial = GADInterstitial(adUnitID: INTERSTITIAL_ID)
      #endif
      
      self.Interstitial.delegate = self
      Interstitial.load(GADRequest())
   }
   
   private func InitInstitialCount() {
      if userDefaults.object(forKey: "InterstitialCount") == nil {
         self.InterstitialCount = self.InterstitialCountBase
         userDefaults.set(self.InterstitialCount, forKey: "InterstitialCount")
         print("初めて起動したので\(InterstitialCountBase)をセットしました。")
      }else{
         self.InterstitialCount = userDefaults.integer(forKey: "InterstitialCount")
         print("広告の表示するまでの回数: \(self.InterstitialCount)")
      }
   }
   
   //MARK:- 選択画面でVC生成したらPresentする前にyobu
   //読み込み前に実行する
   public func LoadUsersInfo() {
      let UsersUID = UserDefaults.standard.string(forKey: "UID") ?? ""
      
      db.collection("users").document(UsersUID).getDocument() { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            return
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            if let userName = document.data()?["name"] as? String {
               self.usersName = userName
            }
            if let usersProfileURL = document.data()?["downloadProfileURL"] as? String {
               self.usersProfileURL = usersProfileURL
            }
            if let usersFcmToken = document.data()?["FcmToken"] as? String {
               self.usersFcmToken = usersFcmToken
            }
            self.usersUID = UsersUID

            
         } else {
            print("Document does not exist")
            return
         }
      }
   }
   
   public func LoadUsersNameOfPostedStages(name: String) {
      self.PostedUsersName = name
   }
   
   public func LoadLoadUsersUIDOfPostedStages(postedUsersUID: String) {
      self.PostedUsersUID = postedUsersUID
   }
   
   public func LoadUsersProfileImageURLOfPostedStages(profileURL: String) {
      self.PostedusersProfileURL = profileURL
   }
   
   public func LoadStageCommentIDofPostedStages(CommentID: String) {
      self.CommentRefID = CommentID
   }
   
   public func LoadPostedUsersFcmToken(PostedUsersFcmToken: String) {
      self.PostedUsersFcmToken = PostedUsersFcmToken
   }
   
   public func LoadStageNumber(Num: Int) {
      SellectStageNumber = Num
      userDefaults.set(Num, forKey: "StageNum")
   }
   
   public func LoadStageArray(StageArray: [[Contents]]) {
      self.UserStageArray = StageArray
   }
   
   public func LoadPiceArray(PiceArray: [PiceInfo]) {
      self.UserPiceArray = PiceArray
   }
   
   public func LoadPlayStageData(RefID: String, stageDataForNoDocExsist: PlayStageRefInfo) {
      //let Ref = db.collection("Stages").document(RefID)
      let Ref = db.document(RefID)
      
      Ref.getDocument { (document, error) in
         if let document = document, document.exists, let doc = document.data() {
            self.PlayStageData.RefID = RefID
            self.PlayStageData.PlayCount = doc["PlayCount"] as? Int
            self.PlayStageData.ReviewCount = doc["ReviewCount"] as? Int
            self.PlayStageData.ReviewAve = doc["ReviewAve"] as? CGFloat
            
            print("\nstageInfo = {")
            print("  RefId       = \(self.PlayStageData.RefID)")
            print("  PlayCount   = \(String(describing: self.PlayStageData.PlayCount))")
            print("  ReviewCount = \(String(describing: self.PlayStageData.ReviewCount))")
            print("  ReviewAve   = \(String(describing: self.PlayStageData.ReviewAve))")
            print("}\n")
         } else {
            print("Document does not exist")
            self.PlayStageData = stageDataForNoDocExsist
         }
      }
   }

   private func InitGameViewAndShowView() {
      print("Users GameSene，GameViewの初期化開始")
      if let scene = GKScene(fileNamed: "UsersGameScenePart2") {
         
         // Get the SKScene from the loaded GKScene
         if let sceneNode = scene.rootNode as! UsersGameScenePart2? {
            sceneNode.scaleMode = GetSceneScalaMode(DeviceHeight: UIScreen.main.nativeBounds.height)
            sceneNode.InitPuzzleArrayBoforeScene(SizeX: sceneNode.frame.width, SizeY: sceneNode.frame.height, PiceArray: UserPiceArray)
            sceneNode.SetStageArrayBeforeScene(StageArray: UserStageArray)
            
            if let view = self.view as! SKView? {
                  
               view.ignoresSiblingOrder = true
               let Tran = SKTransition.fade(withDuration: 2.4)

               view.presentScene(sceneNode, transition: Tran)
               
               //デバックやったら色々表示
               #if DEBUG
                  view.showsDrawCount = true
                  view.showsQuadCount = true
                  view.showsFPS = true
                  view.showsNodeCount = true
               #else
                  view.showsDrawCount = false
                  view.showsQuadCount = false
                  view.showsFPS = false
                  view.showsNodeCount = false
               #endif
            }else{fatalError()}
         }else{fatalError()}
      }else{fatalError()}
      print("Users GameSene，GameViewの初期化完了")
   }
   
   private func GetSceneScalaMode(DeviceHeight: CGFloat) -> SKSceneScaleMode {
      if UIDevice.current.userInterfaceIdiom == .pad { return .fill }
      switch DeviceHeight {
      case 2436.0:
         return .fill
      case 1792.0:
         return .fill
      case 2688.0:
         return .fill
      default:
         return .aspectFill
      }
   }
   
   //MARK: 通知の初期化
   private func InitNotificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(GameClearCatchNotification(notification:)), name: .UsersGameClear, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(SellectBackNotification(notification:)), name: .SellectBack, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapNextNotification(notification:)), name: .TapNext, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(TapHomeNotification(notification:)), name: .TapHome, object: nil)
   }
   
   //星が降ってくるVeiwの初期化
   private func InitConfettiView() {
      let Rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      ConfettiView = SAConfettiView(frame: Rect)
      ConfettiView.intensity = GameClearVeiwIntensity
      ConfettiView.type! = .star
      ConfettiView.isUserInteractionEnabled = false
   }
   
   private func StartConfetti(){
      self.view?.addSubview(ConfettiView)
      ConfettiView.startConfetti()
      ShowGameClearView = true
   }
   
   private func StopConfitti() {
      ConfettiView.stopConfetti()
      ShowGameClearView = false
//      GameClearView.removeFromSuperview()
   }
   
   
   private func StartStarAnimation(CountOfUsedHint: Int) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
         self.ClearView?.StartAnimationView1()
      }
      if CountOfUsedHint == 2 { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime) {
         self.ClearView?.StartAnimationView2()
      }
      if CountOfUsedHint == 1 { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime * Double(2)) {
         self.ClearView?.StartAnimationView3()
      }
   }
   
   private func StartConfeAnimation(CountOfUsedHint: Int) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
         self.ClearView?.StartConfe1()
      }
      if CountOfUsedHint == 2 { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime) {
         self.ClearView?.StartConfe2()
      }
      if CountOfUsedHint == 1 { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + StarAnimationBetTime * Double(2)) {
         self.ClearView?.StartConfe3()
      }
   }
   
   private func ShowGameClearViewWithStar(CountOfUsedHint: Int) {
      self.StartStarAnimation(CountOfUsedHint: CountOfUsedHint)
      self.StartConfeAnimation(CountOfUsedHint: CountOfUsedHint)
      
   }
   
   
   //MARK:- Firestoreに情報を送信する。
   //ステージのプレイ回数をインクリメント
   private func SavePlayStageCountToFireStore() {
      let RefID = PlayStageData.RefID
      let Ref = db.document(RefID)
      let playCount = PlayStageData.PlayCount
      
      print("FireStoreにPlayCount送信開始")
      print("RefID = \(RefID)")
      //PlayCountを1だけアップ
      Ref.updateData([
         "PlayCount": FieldValue.increment(Int64(1))
      ]) { err in
         if let err = err {
            print("Error: PlayCountアップデート: \(err)")
         } else {
            print("PlayCount書き込み成功! -> \(String(describing: playCount))")
         }
      }
   }
   //ユーザのプレイ回数をインクリメント
   private func SaveUsersPlayStageCountToFireStore() {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      let Ref = db.collection("users").document(uid)
      print("UID = \(uid)")
      
      Ref.updateData([
         "ClearStageCount": FieldValue.increment(Int64(1))
      ]) { err in
         if let err = err {
            print("Error: ClearStageCountアップデート: \(err)")
         } else {
            print("ClearStageCount書き込み成功!")
         }
      }
   }
   
   private func ReviewUpdate(newValue: CGFloat) {
      let RefID = PlayStageData.RefID
      let Ref = db.document(RefID)
      
      Ref.updateData([
         "ReviewAve": newValue
      ]) { err in
         if let err = err {
            print("Error: ドキュメントアップデート: \(err)")
         } else {
            print("Ave書き込み成功 -> \(newValue)")
         }
      }
   }
   
   private func ReviewCountUpdate() {
      let ReivewCount = PlayStageData.ReviewCount
      let RefID = PlayStageData.RefID
      let Ref = db.document(RefID)
      
      Ref.updateData([
         "ReviewCount": FieldValue.increment(Int64(1))
      ]) { err in
         if let err = err {
            print("Error: ドキュメントアップデート: \(err)")
            self.GoBackViewController()
         } else {
            print("Ave書き込み成功 -> \(String(describing: ReivewCount))")
            self.GoBackViewController()
         }
      }
   }
   
   private func SaveReviewAveCountToFireStore() {
      let RefID = PlayStageData.RefID
      let ThisStageReview = ClearView!.GetReView()
      let StageReviewAve = PlayStageData.ReviewAve
      //let playCount = PlayStageData.PlayCount
      let reviewCount = PlayStageData.ReviewCount
      //let Ref = db.collection("Stages").document(RefID)
      
      print("FireStoreにReview送信開始")
      print("RefID = \(RefID)")
      
      if ThisStageReview == 0 {
         print("\nステージレビューをしていません")
         self.GoBackViewController()
         return
      }
      
      print("\n---ネットーワーク状況---")
      
      
      if networkChecker.isOnline() == false {
         print("オフラインです。\n")
         self.GoBackViewController()
         return
      }else{
         print("オンラインです。\n")
      }
      
      if let count = reviewCount, let reviAve = StageReviewAve {
         if reviAve == 0 {
            //reviAve 0の時はそのまま書き込みを行う。
            ReviewUpdate(newValue: CGFloat(ThisStageReview))
            ReviewCountUpdate()
            //reviAve0の時はそのまま書き込みを行う。
         } else {
            //0以外の時は平均をとって送信
            let CGCount = CGFloat(count)
            let CGCount_Add1 = CGFloat(count + 1)
            let CGThisStageAve = CGFloat(ThisStageReview)
            
            var Average: CGFloat = reviAve + (CGThisStageAve / CGCount)
            Average *= CGCount / CGCount_Add1
          
            ReviewUpdate(newValue: Average)
            ReviewCountUpdate()
             //0以外の時は平均をとって送信
         }
      } else {
         print("PlayCountがnilだったから更新しない")
         return
      }
   }
   
   //MARK:- コメントをFirestoreに保存する処理
   private func SaveStageCommentToFireStore() {
      let isRegisterComment = ClearView?.GetisRegisterComment()
      let SentCommentToFireStore: String = ClearView?.GetSentCommentToFireStore() ?? ""
      
      if isRegisterComment == false {
         print("ユーザはコメントを登録していません\n")
         return
      } else {
         print("\n---- 送信するコメント ----")
         print(SentCommentToFireStore)
         print("---- 送信するコメント ----\n")
      }
      
      let StageCommentRef = "StageComment/" + self.CommentRefID + "/Comment/"
      let CommentID = NSUUID()
      let CommentIDStr = CommentID.uuidString
      
      
      db.collection(StageCommentRef).addDocument(data: [
         "CommentBody": SentCommentToFireStore,
         "CommentUserUID": self.usersUID,
         "CommentUsersName": self.usersName,
         "CommentUsersProfileURL": self.usersProfileURL,
         "CommentUsersFcmToken": self.usersFcmToken,
         "CommentedUsersFcmToken": self.PostedUsersFcmToken,
         "AddDate": FieldValue.serverTimestamp(),
         "CommentID": CommentIDStr,
         "isPublished": true
      ]) { err in
         if let err = err {
            print("---------- コメントをFireStoreに保存失敗  ----------\n")
            print("Error writing document: \(err.localizedDescription)")
         } else {
            print("---------- コメントをFireStoreに保存成功  ----------\n")
            Analytics.logEvent("SentComment", parameters: nil)
         }
      }
   }

   //MARK:- ゲームクリアして通知を受け取る関数
   @objc func GameClearCatchNotification(notification: Notification) -> Void {
      guard ShowGameClearView == false else { return }
      
      
      //データをFireBaseに飛ばす
      //こっちはStagesのプレイカウントを変える
      SavePlayStageCountToFireStore()
      //こっちはユーザ情報のプレイカウントを変える
      SaveUsersPlayStageCountToFireStore()

      //BGM小さくして，
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.075) {
         self.GameBGM.fade(player: self.GameBGM.FetchedPlayGameBGM,
                           fromVolume: self.GameBGM.FetchedPlayGameBGM.volume,
                           toVolume: self.GameBGM.FetchedPlayGameBGM.volume * 0.1,
                           overTime: 0.1)
      }
      //降ってくるviewの開始
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.245) {
         self.StartConfetti()
      }
      //MARK:- クリアした時に音楽を鳴らす
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         self.ClearView?.PlayGameClseraSounds()
         //クリア音を鳴らしたら，BGMを元の大きさに戻す(止まってないとき.止まってたら，つまり，AD再生してたらつけない)
         DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            if self.GameBGM.FetchedPlayGameBGM.isPlaying {
               self.GameBGM.fade(player: self.GameBGM.FetchedPlayGameBGM,
                                 fromVolume: self.GameBGM.FetchedPlayGameBGM.volume,
                                 toVolume: self.GameBGM.SoundVolume,
                                 overTime: 2)
            }
         }
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.645) {
         self.view.addSubview(self.ClearView!)
         self.view.bringSubviewToFront(self.ConfettiView)
         self.ClearView?.AddStarView1()
         self.ClearView?.AddStarView2()
         self.ClearView?.AddStarView3()
         self.ClearView?.AddKiraView1()
         self.ClearView?.AddKiraView2()
         self.ClearView?.AddKiraView3()
         self.ClearView?.AddConfiView1()
         self.ClearView?.AddConfiView2()
         self.ClearView?.AddConfiView3()
         self.ClearView?.StartClearViewAnimation()
         self.ClearView?.fadeIn(type: .Normal) { [weak self] in
            //Hintを用意してないから0nisuru
            self?.ShowGameClearViewWithStar(CountOfUsedHint: 0)
         }
      }
   }

   //MARK:- Nextボタン押されたよ
   @objc func TapNextNotification(notification: Notification) -> Void {
      GameSound.PlaySoundsTapButton()

      //課金してたらそのまま次のステージに
      if userDefaults.bool(forKey: "BuyRemoveAd") == true {
         ShowNextGame()
         return
      }
      //ヒント表示カウントが1やったら広告表示してカウンタアプデして帰る
      if userDefaults.integer(forKey: "InterstitialCount") == 0 {
         ShowInterstitial()
         return
      }
      //それ以外やったらカウンタアプデして次のステージ表示
      ShowNextGame()
      return
   }
   
   //MARK:- Homeボタンタップされたよ
   @objc func TapHomeNotification(notification: Notification) -> Void {
      GameSound.PlaySoundsTapButton()
      
      guard isLockedHomeFunction == false else {
         print("HomeButtonの2度押し禁止！")
         return
      }
      isLockedHomeFunction = true
      
      //Firestoreに保存
      //Homeに帰る処理はGoBackViewController()にきさい。
      //つまり，したの関数から飛ばす
      SaveReviewAveCountToFireStore()
      SaveStageCommentToFireStore()
   }
   
   private func GoBackViewController() {
      //課金してたらそのまま返す
      if userDefaults.bool(forKey: "BuyRemoveAd") == true {
         StopGameBGM()
         
         self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: .StartHomeViewBGM, object: nil)
         })
         return
      }
      
      //1やったら広告表示してカウンタアプデして帰る
      if userDefaults.integer(forKey: "InterstitialCount") == 0 {
         GoHomeForInstitialAD = true
         ShowInterstitial()
         UpdateInterstitialCountANDUpdateLabelCount()
         return
      }
      
      UpdateInterstitialCountANDUpdateLabelCount()
      StopGameBGM()
      self.dismiss(animated: true, completion: {
         NotificationCenter.default.post(name: .StartHomeViewBGM, object: nil)
      })
   }
   
   //MARK:- 次のステージに行くために，ClearView消したりアニメーション消したりする
   private func ShowNextGame() {
      self.StopConfitti()
      
      //並列処理するよ
      let dispatchGroup = DispatchGroup()
      let dispatchQueue = DispatchQueue.main
      
      //エンターさせて，
      dispatchGroup.enter()
      dispatchQueue.async(group: dispatchGroup) {
         [weak self] in
         self?.InitGameViewAndShowView()
         dispatchGroup.leave()   //おわったらleaveする
      }
      //全ての処理が終わったらClearViewnをfadeOutする
      dispatchGroup.notify(queue: .main) {
         self.ClearView?.fadeOut(type: .Slow){ [weak self] in
            if self?.userDefaults.bool(forKey: "BuyRemoveAd") == false {
               self?.UpdateInterstitialCountANDUpdateLabelCount()
            }
            self?.ClearView?.UnLockisLocedNextButton()
            self?.ClearView?.StopConfi()
            self?.ClearView?.StopStar()
            self?.ClearView?.StopLoadingAnimation()
            self?.ClearView?.SetUpForAnimatiomToHideEachViewAndButton()
            self?.ClearView?.removeFromSuperview()
         }
      }
   }
 
   
   private func PlayGameBGM() {
      GameBGM.fade(player: GameBGM.FetchedPlayGameBGM, fromVolume: 0, toVolume: GameBGM.SoundVolume, overTime: 2)
   }
   
   private func StopGameBGM() {
      GameBGM.fade(player: GameBGM.FetchedPlayGameBGM, fromVolume: GameBGM.SoundVolume, toVolume: 0, overTime: 1.25)
   }
   

   //MARK:- インタースティシャル広告表示する
   //インステーシャル広告表示するのはNextボタン押した時とHomeボタン押した時の2通りあるね.
   //
   private func ShowInterstitial(){
      if Interstitial.isReady {
         print("インタースティシャル広告の準備できてるからpresentする!")
         Interstitial.present(fromRootViewController: self)
         return
      }
      
      if Interstitial.isReady == false && GoHomeForInstitialAD == true {
         print("インタースティシャル広告準備できてないし，帰りたいから帰る")
         GoHomeForInstitialAD = false
         self.dismiss(animated: false, completion: {
         NotificationCenter.default.post(name: .StartHomeViewBGM, object: nil)})
         return
      }
      print("インタースティシャル広告準備できてないから次のステージに進みます")
      ShowNextGame()
   }
   
   //MARK:- 広告表示カウントとラベルの更新
   private func UpdateInterstitialCountANDUpdateLabelCount() {
      let NowInterstitialCount = userDefaults.integer(forKey: "InterstitialCount")
      
      if NowInterstitialCount == 0 {
         userDefaults.set(self.InterstitialCountBase, forKey: "InterstitialCount")
         print("InterstitialCountBaseを再設定しました：\(userDefaults.integer(forKey: "InterstitialCount"))")
      }else{
         userDefaults.set(NowInterstitialCount - 1, forKey: "InterstitialCount")
         print("InterstitialCountをインクリメントしました：\(userDefaults.integer(forKey: "InterstitialCount"))")
      }
      
      InitInstitialLabelOFClearView()
   }
   
   //MARK:- 広告のデリゲート群
   //広告の読み込みが完了した時
   func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("\n-- Interstitial広告の読み込み完了 --\n")
      //Analytics.logEvent("AdReadyOK", parameters: nil)
   }
   //広告の読み込みが失敗した時
   func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("\n-- Interstitial広告の読み込み失敗 --\n")
      //Analytics.logEvent("AdNotReady", parameters: nil)
      
   }
   //広告画面が開いた時
   func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告開いた")
      print("インタースティシャル広告開いたから，BGMストップ")
      GameBGM.fade(player: GameBGM.FetchedPlayGameBGM, fromVolume: GameBGM.FetchedPlayGameBGM.volume, toVolume: 0, overTime: 0.5)
      
   }
   //広告をクリックして開いた画面を閉じる直前
   func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告閉じる直前")
   }
   //広告をクリックして開いた画面を閉じる直後
   func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告閉じる直後")
      AudioServicesPlaySystemSound(1519)
      
      //Homeボタン押してた時はDismissしなあかんよ
      if GoHomeForInstitialAD == true {
         Analytics.logEvent("InterAdAndGoHome", parameters: nil)
         print("帰りたいから帰る")
         GoHomeForInstitialAD = false
         self.dismiss(animated: true, completion: {
         NotificationCenter.default.post(name: .StartHomeViewBGM, object: nil)})
         return
      }
      
      //この下の処理はNextButtonを押した時の処理ね
      print("インタースティシャル広告終わったから，BGM再生しますね")
      GameBGM.fade(player: GameBGM.FetchedPlayGameBGM, fromVolume: 0, toVolume: GameBGM.SoundVolume, overTime: 2)
      Analytics.logEvent("InterAdAndNext", parameters: nil)
      print("ってことで次のステージに移動します")
      ShowNextGame()
   }
   //広告をクリックした時
   func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("インタースティシャル広告ボタンクリックした")
   }
   
   //MARK:- ステージセレクト画面で戻るボタン押された時の処理
   @objc func SellectBackNotification(notification: Notification) -> Void {
      self.dismiss(animated: true, completion: nil)
      return
   }
   
    override var shouldAutorotate: Bool { return true }

   override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      if UIDevice.current.userInterfaceIdiom == .phone { return .allButUpsideDown }
      return .all
    }

    override var prefersStatusBarHidden: Bool { return true }
}
