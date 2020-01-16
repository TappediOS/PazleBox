//
//  ManageLeaderboard.swift
//  PazleBox
//
//  Created by jun on 2019/05/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import GameplayKit
import Realm
import RealmSwift
import Firebase
import StoreKit
import SCLAlertView

class ManageLeadearBoards {
   
   //構造体にしとけ
   let MaxStarCount = 450
   
   //ID一覧
   let CLEAR1_ID = "1_STAGE_CLEAR"
   let CLEAR5_ID = "5_STAGE_CLEAE"
   let CLEAR10_ID = "10_STAGE_CLEAR"
   let CLEAR25_ID = "25_STAGE_CLEAE"
   let CLEAR50_ID = "50_STAGE_CLEAE"
   let CLEAR100_ID = "100_STAGE_CLEAR"
   let CLEAR150_ID = "150_STAGE_CLEAE"
   
   let CLEAR_STAGE_NUM_DEADERBOARD_ID = "ClearStageNumLeaderBoard"
   let COLLECTED_STAR_NUM_DEADERBOARD_ID = "CollectNumberOfStarsLeaderBoad"
   let NUM_OF_PLAYED_STAGE_USER_CREATED = "NumOfPlayedStageUserCreated"
   let NUM_OF_YOU_CREATED_STAGE_PLAYED = "NumOfYouCreatedStagePlayed"
   
   let userDefaults = UserDefaults.standard
   let realm = try! Realm()
   
   init() {
      
      InitUserDefaults()
   }
   
   //MARK:- userdefaultの初期化
   private func InitUserDefaults() {
      userDefaults.register(defaults: ["SumOfClearStageNum": 0])
      userDefaults.register(defaults: ["SumOfCollectedStarNum": 0])
      userDefaults.register(defaults: ["SumOfStagePlayed": 0])
      userDefaults.register(defaults: ["SumOfStageYouCretedHasBeenPlayed": 0])
      
      userDefaults.register(defaults: ["Clear1": false])
      userDefaults.register(defaults: ["Clear5": false])
      userDefaults.register(defaults: ["Clear10": false])
      userDefaults.register(defaults: ["Clear25": false])
      userDefaults.register(defaults: ["Clear50": false])
      userDefaults.register(defaults: ["Clear100": false])
      userDefaults.register(defaults: ["Clear150": false])
      
      print("\n合計ステージクリア数　\(String(describing: userDefaults.object(forKey: "SumOfClearStageNum")))")
      print("集めた星の数　\(String(describing: userDefaults.object(forKey: "SumOfCollectedStarNum")))\n")
      print("作ったステージをプレイした回数　\(String(describing: userDefaults.object(forKey: "SumOfClearStageNum")))")
      print("作ったステージがプレイされた回数　\(String(describing: userDefaults.object(forKey: "SumOfClearStageNum")))")
      
      print("\n達成項目1   \(String(describing: userDefaults.object(forKey: "Clear1")))")
      print("達成項目5   \(String(describing: userDefaults.object(forKey: "Clear5")))")
      print("達成項目10  \(String(describing: userDefaults.object(forKey: "Clear10")))")
      print("達成項目25  \(String(describing: userDefaults.object(forKey: "Clear25")))")
      print("達成項目50  \(String(describing: userDefaults.object(forKey: "Clear50")))")
      print("達成項目100 \(String(describing: userDefaults.object(forKey: "Clear100")))")
      print("達成項目150 \(String(describing: userDefaults.object(forKey: "Clear150")))\n")
   }
   
   
   //MARK:- 集めた星の数をgamecenterに送信する
   private func SentNumberOfCollectedStarToLeaderBoard(NewRecordOfCollectedStarNum: Int, BeforeRecord: Int){
      
      //スコアの初期化
      let SentCollectStarScore = GKScore(leaderboardIdentifier: COLLECTED_STAR_NUM_DEADERBOARD_ID)
      
      if GKLocalPlayer.local.isAuthenticated == false {
         print("ユーザはゲームセンターにログインしていません")
         return
      }
      
      //Int64にキャスト変換してセット
      SentCollectStarScore.value = Int64(NewRecordOfCollectedStarNum)
      //ここには送信する最高記録を保存
      userDefaults.set(NewRecordOfCollectedStarNum, forKey: "SumOfCollectedStarNum")
      print()
      
      GKScore.report([SentCollectStarScore], withCompletionHandler: { (error) in
         if error != nil {
            print("error, cant sent new score of Collected Star Num...\(String(describing: error))")
            print("")
            //エラーったら前の記録を保存
            self.userDefaults.set(BeforeRecord, forKey: "SumOfCollectedStarNum")
            Analytics.logEvent("SentNumOfCollectStarERROR", parameters: nil)
         }
         
      })
   }
   
   
   //MARK: 集めた星の数を調査する
   public func CheckUserUpdateNumberOfCollectedStar() {
      //各難易度で星を3つとったステージ数を取得
      let EasyStar3 = realm.objects(EasyStageClearInfomation.self).filter("CountOfUsedHint == 0").count
      let NormalStar3 = realm.objects(NormalStageClearInfomation.self).filter("CountOfUsedHint == 0").count
      let HardStar3 = realm.objects(HardStageClearInfomation.self).filter("CountOfUsedHint == 0").count
      
      //各難易度で星を2つとったステージ数を取得
      let EasyStar2 = realm.objects(EasyStageClearInfomation.self).filter("CountOfUsedHint == 1").count
      let NormalStar2 = realm.objects(NormalStageClearInfomation.self).filter("CountOfUsedHint == 1").count
      let HardStar2 = realm.objects(HardStageClearInfomation.self).filter("CountOfUsedHint == 1").count
      
      //各難易度で星を1つとったステージ数を取得
      let EasyStar1 = realm.objects(EasyStageClearInfomation.self).filter("CountOfUsedHint == 2").count
      let NormalStar1 = realm.objects(NormalStageClearInfomation.self).filter("CountOfUsedHint == 2").count
      let HardStar1 = realm.objects(HardStageClearInfomation.self).filter("CountOfUsedHint == 2").count
      
      //各難易度の星の総数
      let SumOfEasy = EasyStar1 * 1 + EasyStar2 * 2 + EasyStar3 * 3
      let SumOfNormal = NormalStar1 * 1 + NormalStar2 * 2 + NormalStar3 * 3
      let SumOfHard = HardStar1 * 1 + HardStar2 * 2 + HardStar3 * 3
      
      print("\n--- Easy Stage ---")
      print("3 Star -> \(EasyStar3)")
      print("2 Star -> \(EasyStar2)")
      print("1 Star -> \(EasyStar1)")
      print("Sum -> \(SumOfEasy)")
      print("--------------------")
      
      print("\n--- Normal Stage ---")
      print("3 Star -> \(NormalStar3)")
      print("2 Star -> \(NormalStar2)")
      print("1 Star -> \(NormalStar1)")
      print("Sum -> \(SumOfNormal)")
      print("--------------------")
      
      print("\n--- Hard Stage ---")
      print("3 Star -> \(HardStar3)")
      print("2 Star -> \(HardStar2)")
      print("1 Star -> \(HardStar1)")
      print("Sum -> \(SumOfHard)")
      print("--------------------\n")
      
      //ぜーーんぶの星の数
      let AllCollectedStarNum = SumOfEasy + SumOfNormal + SumOfHard
      //現在の最高記録
      let NowSavedAllCollectedStarNum = userDefaults.object(forKey: "SumOfCollectedStarNum") as! Int
      
      print("集めた星の数の合計           \(AllCollectedStarNum)")
      print("現在保存されている星の数の合計 \(NowSavedAllCollectedStarNum)\n")
      
      if AllCollectedStarNum > NowSavedAllCollectedStarNum {
         print("星の数を更新したのでリーダボードに送信をします")
         SentNumberOfCollectedStarToLeaderBoard(NewRecordOfCollectedStarNum: AllCollectedStarNum, BeforeRecord: NowSavedAllCollectedStarNum)
         Analytics.logEvent("UpdateCollectedStarNum", parameters: nil)
      }else{
         print("星の数の記録は更新されませんでした。")
      }
   }
   
   
   
   //MARK:- クリアしたステージの数をgamecenterに送信する
   private func SentNumberOfClearStageToLeaderBoard(NewRecordOfStageClearNum: Int, BeforeRecord: Int){
      
      let SentStageClearScore = GKScore(leaderboardIdentifier: CLEAR_STAGE_NUM_DEADERBOARD_ID)
      
      if GKLocalPlayer.local.isAuthenticated == false {
         print("ユーザーはゲームセンターにログインしていません")
         return
      }
      
      
      SentStageClearScore.value = Int64(NewRecordOfStageClearNum)
      userDefaults.set(NewRecordOfStageClearNum, forKey: "SumOfClearStageNum")
      print()
      
      GKScore.report([SentStageClearScore], withCompletionHandler: { (error) in
         if error != nil {
            print("error, cant sent new score of Clear Stage num...\(String(describing: error))")
            print("")
            self.userDefaults.set(BeforeRecord, forKey: "SumOfClearStageNum")
            Analytics.logEvent("SentNumOfClearStageERROR", parameters: nil)
         }
         
      })
   }
   
   private func SentCreatedStagesHaveBeenPlayed(NewRecord: Int, BeforeRecord: Int) {
      let SentScore = GKScore(leaderboardIdentifier: NUM_OF_PLAYED_STAGE_USER_CREATED)
      
      if GKLocalPlayer.local.isAuthenticated == false {
         print("ユーザーはゲームセンターにログインしていません")
         return
      }
      
      SentScore.value = Int64(NewRecord)
      userDefaults.set(NewRecord, forKey: "SumOfStagePlayed")
      print()
      
      GKScore.report([SentScore], withCompletionHandler: { (error) in
         if error != nil {
            print("error, cant sent new score of Clear Stage num...\(String(describing: error))")
            self.userDefaults.set(BeforeRecord, forKey: "SumOfStagePlayed")
         }
         
      })
   }
   
   private func SentUserCreatedStagesHaveBeenPlayed(NewRecord: Int, BeforeRecord: Int) {
      let SentScore = GKScore(leaderboardIdentifier: NUM_OF_YOU_CREATED_STAGE_PLAYED)
      
      if GKLocalPlayer.local.isAuthenticated == false {
         print("ユーザーはゲームセンターにログインしていません")
         return
      }
      
      SentScore.value = Int64(NewRecord)
      userDefaults.set(NewRecord, forKey: "SumOfStageYouCretedHasBeenPlayed")
      print()
      
      GKScore.report([SentScore], withCompletionHandler: { (error) in
         if error != nil {
            print("error, cant sent new score of Clear Stage num...\(String(describing: error))")
            self.userDefaults.set(BeforeRecord, forKey: "SumOfStageYouCretedHasBeenPlayed")
         }
         
      })
   }
   
   //MARK: クリアしたステージ数を調査する
   public func CheckUserUpdateNumberOfClearStage() {
      
      let EasyResult = realm.objects(EasyStageClearInfomation.self).filter("Clear == true")
      let NormalResult = realm.objects(NormalStageClearInfomation.self).filter("Clear == true")
      let HardResult = realm.objects(HardStageClearInfomation.self).filter("Clear == true")
      
      
      let EasyClearCount = EasyResult.count
      let NormalClearCount = NormalResult.count
      let HardClearCount = HardResult.count
      let AllClearCount = EasyClearCount + NormalClearCount + HardClearCount
      let NowSavedAllStageClearCount = userDefaults.object(forKey: "SumOfClearStageNum") as! Int
      
      print("\nEasy\(EasyClearCount)")
      print("Normal \(NormalClearCount)")
      print("Hard \(HardClearCount)")
      print("全てのステージのクリア数           \(AllClearCount)")
      print("現在保存されているステージのクリア数 \(NowSavedAllStageClearCount)\n")
      
      
      if AllClearCount > NowSavedAllStageClearCount {
         print("記録を更新しました。送信を行います")
         SentNumberOfClearStageToLeaderBoard(NewRecordOfStageClearNum: AllClearCount, BeforeRecord: NowSavedAllStageClearCount)
         Analytics.logEvent("UpdateClearStageNum", parameters: nil)
         print("チャレンジを達成したかどうかの確認を行います")
         CheckUpdateUserChallenge(AllClearCount: AllClearCount)
      }else{
         print("ステージクリア数は更新されませんでした.")
      }
   }
   
   //MARK:- （あるユーザが)作ったステージがプレイされた回数をGameCenterに送る。
   //私が作ったステージは関係ない。
   //これは,FireStoreでのUserのフォルダにあるやつを送っている。
   public func CheckUserCreatedStagesHaveBeenPlayed(playedCount: Int) {
      let nowCount = userDefaults.integer(forKey: "SumOfStagePlayed")
      
      print("現在保存されているプレイされた回数の最大値: \(nowCount)")
      print("送るかを考えるプレイされた回数　　　　　　: \(playedCount)")
      
      if nowCount > playedCount {
         print("超えてないので送らない。")
         return
      }
      
      print("記録を更新しました。送信を行います")
      SentCreatedStagesHaveBeenPlayed(NewRecord: playedCount, BeforeRecord: nowCount)
      Analytics.logEvent("UpdateUserCreatedStagesHaveBeenPlayed", parameters: nil)
   }
   
   //MARK:- ユーザによって作られたステージをプレイした回数をGameCenterに送る。
   //これは,FireStoreでのUserのフォルダにあるやつを送っている。
   //iudでもう一回クエリしないといけないめんどくさいやつ。
   public func CheckSomeUserCreatedStagesHaveBeenPlayed(playCount: Int) {
      let nowCount = userDefaults.integer(forKey: "SumOfStagePlayed")
      
      print("現在保存されているプレイされた回数の最大値: \(nowCount)")
      print("送るかを考えるプレイされた回数　　　　　　: \(playCount)")
      
      if nowCount > playCount {
         print("超えてないので送らない。")
         return
      }
      
      print("記録を更新しました。送信を行います")
      SentUserCreatedStagesHaveBeenPlayed(NewRecord: playCount, BeforeRecord: nowCount)
      Analytics.logEvent("UpdateUserCreatedStagesHaveBeenPlayed", parameters: nil)
   }
   
   private func AppStoreReview() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton(NSLocalizedString("ThankYou", comment: "")){
         print("tap")
         Analytics.logEvent("TapThanYouButtonFor10", parameters: nil)
         if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            Analytics.logEvent("AppStoreReviewOKFor10", parameters: nil)
         }
         else{
            Analytics.logEvent("AppStoreReviewNOFor10", parameters: nil)
         }
         
      }
      ComleateView.addButton(NSLocalizedString("Ohthankyou", comment: "")){
         print("tap")
         Analytics.logEvent("UserTap_OhThanks...For10", parameters: nil)
      }
      ComleateView.showSuccess(NSLocalizedString("Clear10Stage", comment: ""), subTitle: NSLocalizedString("Congrats", comment: ""))

   }
   
   private func CelebrationForClear100StageAndAppStoreReview() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton(NSLocalizedString("ThankYou", comment: "")){
         print("tap")
         Analytics.logEvent("TapThanYouButtonFor100", parameters: nil)
         if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            Analytics.logEvent("AppStoreReviewOKFor100", parameters: nil)
         }
         else{
            Analytics.logEvent("AppStoreReviewNOFor100", parameters: nil)
         }
         
      }
      ComleateView.addButton(NSLocalizedString("Ohthankyou", comment: "")){
         print("tap")
         Analytics.logEvent("UserTap_OhThanks...For100", parameters: nil)
      }
      ComleateView.showSuccess(NSLocalizedString("Clear10Stage", comment: ""), subTitle: NSLocalizedString("Congrats", comment: ""))
   }
   
   //MARK:- GameCneterのチャレンジが達成されたか見る
   private func CheckUpdateUserChallenge(AllClearCount: Int) {
      
      switch AllClearCount {
      case 1:
         if userDefaults.object(forKey: "Clear1") as! Bool == false{
            userDefaults.set(true, forKey: "Clear1")
            AchievedGameCenter(AchievedItemID: CLEAR1_ID)
            Analytics.logEvent("Achieve1Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR1_ID
            ])
         }
      case 5:
         if userDefaults.object(forKey: "Clear5") as! Bool == false{
            userDefaults.set(true, forKey: "Clear5")
            AchievedGameCenter(AchievedItemID: CLEAR5_ID)
            Analytics.logEvent("Achieve5Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR5_ID
               ])
            
            
         }
      case 10:
         if userDefaults.object(forKey: "Clear10") as! Bool == false{
            userDefaults.set(true, forKey: "Clear10")
            AchievedGameCenter(AchievedItemID: CLEAR10_ID)
            Analytics.logEvent("Achieve10Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR10_ID
               ])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
               self.AppStoreReview()
            }
         }
      case 25:
         if userDefaults.object(forKey: "Clear25") as! Bool == false{
            userDefaults.set(true, forKey: "Clear25")
            AchievedGameCenter(AchievedItemID: CLEAR25_ID)
            Analytics.logEvent("Achieve25Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR25_ID
               ])
         }
      case 50:
         if userDefaults.object(forKey: "Clear50") as! Bool == false{
            userDefaults.set(true, forKey: "Clear50")
            AchievedGameCenter(AchievedItemID: CLEAR50_ID)
            Analytics.logEvent("Achieve50Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR50_ID
               ])
         }
      case 100:
         if userDefaults.object(forKey: "Clear100") as! Bool == false{
            userDefaults.set(true, forKey: "Clear100")
            AchievedGameCenter(AchievedItemID: CLEAR100_ID)
            Analytics.logEvent("Achieve100Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR100_ID
               ])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
               self.CelebrationForClear100StageAndAppStoreReview()
            }
            
         }
      case 150:
         if userDefaults.object(forKey: "Clear150") as! Bool == false{
            userDefaults.set(true, forKey: "Clear150")
            AchievedGameCenter(AchievedItemID: CLEAR150_ID)
            Analytics.logEvent("Achieve150Clear", parameters: nil)
            Analytics.logEvent(AnalyticsEventUnlockAchievement, parameters: [
               AnalyticsParameterAchievementID : CLEAR150_ID
               ])
         }
         
      default:
         print("達成項目は更新しません")
      }
   }
   
   //MARK: 達成したチャレンジを送信する
   private func AchievedGameCenter(AchievedItemID: String) {
      let Achieve = GKAchievement(identifier: AchievedItemID)
      
      if GKLocalPlayer.local.isAuthenticated == false {
         print("ユーザはゲームセンターにログインしていません")
         return
      }
      
      if Achieve.isCompleted == true {
         print("このチャレンジもう達成してるよー")
         print("ここでブレークポイントきたら，なんか間違ってる")
         return
      }
      
      print("達成項目の送信を行います  達成項目ID: \(AchievedItemID)")
      
      Achieve.percentComplete = 100
      Achieve.showsCompletionBanner = true
      
      GKAchievement.report([Achieve]) { (error) -> Void in
         if error != nil {
            print("---達成項目の送信失敗しました...---: \(String(describing: error))")
            Analytics.logEvent("AchievedGameCenterERROR", parameters: nil)
         }
      }
   }
   
}

