//
//  CreateStageViewController.swift
//  PazleBox
//
//  Created by jun on 2019/07/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import TapticEngine
import FlatUIKit
import SnapKit
import SCLAlertView
import Firebase
import FirebaseFirestore
import NVActivityIndicatorView

class CleateStageViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   var OnPiceView = UIView()
   
   var BackImageView: BackTileImageView?
   
   var FinishCreatePuzzleButton: FUIButton?
   var FinishChouseResPuzzleButton: FUIButton?
   
   var TrashImageView = UIImageView()
   var OptionButton = UIButton()
   
   var InfoLabel = UILabel()
   
   var StartBackImageViewY: CGFloat = 0
   
   var GreenFlame = CGRect()
   var RedFlame = CGRect()
   var BlueFlame = CGRect()
   
   var RedFlame1_1 = CGRect()
   var GreenFlame1_1 = CGRect()
   var BlueFlame1_1 = CGRect()
   
   var RedFlame2_3 = CGRect()
   var GreenFlame2_3 = CGRect()
   var BlueFlame2_3 = CGRect()
   
   var RedFlame3_2 = CGRect()
   var GreenFlame3_2 = CGRect()
   var BlueFlame3_2 = CGRect()
   
   var RedFlame4_3 = CGRect()
   var GreenFlame4_3 = CGRect()
   var BlueFlame4_3 = CGRect()
   
   var MochUserSellectedImageView = UIImageView()
   
   var WorkPlacePiceImageArray: [PiceImageView] = Array()
   var PiceImageArray: [PiceImageView] = Array()
   
   //Piceがかぶってないかをチェックする配列
   var CheckedStage: [[Contents]] = Array()
   let CleanCheckedStage = CleanCheckStage()
   
   var FillContentsArray: [[Contents]] = Array()
   
   var StageTitle: String = ""
   
   var DontMoveNodeNum = 0
   var ShouldMoveNodeNum = 0
   
   //くるくる回るview
   var LoadActivityView: NVActivityIndicatorView?
   
   var db: Firestore!
   var userName: String = ""
   var userProfileURL: String = ""
   var usersFcmToken: String = ""
   var TimeLineShowList = Array<Any>()
   
   let UsersUID = UserDefaults.standard.string(forKey: "UID")
   
   //いま対応してるのは，23,32,33,43,
   let DefaultPiceSet = ["23p2Blue", "23p3Green", "23p5Red", "23p7Green", "23p11Red",
                         "23p12Green", "23p13Green", "32p1Red", "32p2Blue", "32p5Blue",
                         "32p7Green", "32p10Red", "32p12Green", "32p13Red", "33p1Blue",
                         "33p2Red", "33p3Green", "33p6Red", "33p12Blue", "33p14Blue",
                         "33p24Green", "33p28Green", "33p37Blue", "43p9Green", "43p26Blue",
                        ]
   
   let PiceSet1 = ["23p1Red", "23p4Green", "23p6Red", "23p8Red", "23p9Blue",
                  "23p10Green", "23p14Green", "32p3Blue", "32p4Red","32p6Blue",
                  "32p8Red", "32p9Green", "32p10Blue", "32p14Blue", "33p5Blue",
                  "33p16Green", "33p23Red", "43p1Green", "43p2Blue", "43p6Red",
                  ]
   
   
   let PiceSet2 = ["33p8Red", "33p9Red", "33p10Blue", "33p11Red", "33p13Green",
                   "33p15Green", "33p17Blue", "33p19Green", "33p20Green", "33p22Red",
                   "33p25Red", "33p26Blue", "33p27Blue", "33p43Green", "33p44Red",
                   "43p3Blue", "43p4Green", "43p5Green", "43p7Red", "43p8Red",
   ]

   
   let PiceSet3 = ["33p7Green", "33p29Blue", "33p30Blue", "33p31Green", "33p32Green",
                   "33p33Blue", "33p34Red", "33p35Red", "33p36Green", "33p38Blue",
                   "43p10Red", "43p11Green", "43p12Blue", "43p13Red", "43p14Red",
                   "43p15Green", "43p16Red", "43p17Green", "43p18Red", "43p19Blue",
                   "43p20Green", "43p21Red", "43p22Blue", "43p23Blue", "43p24Red",
                  ]
   
   
   let PiceSet4 = ["33p18Red", "33p39Blue", "33p40Blue", "33p41Red", "33p42Blue",
                   "43p25Green", "43p27Red", "43p28Green", "43p29Blue", "43p30Red",
                   "43p31Green", "43p32Blue", "43p33Red", "43p34Red", "43p35Green",
                   "43p36Green", "43p37Blue", "43p38Blue", "43p39Green", "43p40Red",
                   "43p41Red", "43p42Red", "43p43Blue", "43p44Red", "43p45Red",
                   "43p46Blue", "43p47Green", "43p48Blue", "43p49Red", "43p50Green",
                  ]
   
   var UsingPiceSet = Array<String>()
   
   
   
   
   
   
   let sectionInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
   let itemsPerRow: CGFloat = 1 //Cellを横に何個入れるか
   
   var CanUseAreaHeight: CGFloat = 0
   
   var isLockColleViewANDTrashPice = false
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var BackGroundImageView: BackGroundImageViews?
   
   //MARK:- Piceがおける最大値
   let MaxCanPutPiceNum = 7
   var isMaxPutPice = false
      
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.hero.isEnabled = true
      
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
      
      InitBackgroundImageView()
      InitBackTileImageView()
      GetStartBackImageViewY()
      
      InitNotification()
      
      SetUpFireStoreSetting()
      GetUsersInfomationFromFireStore()
      
      InitFinishCreatePuzzleButton()
      InitFinishChouseResPuzzleButton()
      InitTrashView()
      InitOptionButton()
      InitInfoLabel()
      
      InitLoadActivityView()
      
      InitOnPiceView()
      
      CrearCheckedStage()
      
      InitUsingPiceSet()
      SetUpCollectionView()
      
      InitHeroID()
      InitAccessibilityIdentifires()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      ReSetUpOnPiceView()
      
      SNPOptionButton()
      SNPFinishCreatePuzzleButton()
      SNPFinishChouseResPuzzleButton()
      SNPFInfoLabel()
      
      InitRedFlame1_1()
      InitGreenFlame1_1()
      InitBlueFlame1_1()
      
      InitRedFlame2_3()
      InitGreenFlame2_3()
      InitBlueFlame2_3()
      
      InitRedFlame3_2()
      InitGreenFlame3_2()
      InitBlueFlame3_2()
      
      InitRedFlame4_3()
      InitGreenFlame4_3()
      InitBlueFlame4_3()
   }
   
   override func viewDidAppear(_ animated: Bool) {

   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)

   }
   
   private func SetUpFireStoreSetting() {
      let settings = FirestoreSettings()
      Firestore.firestore().settings = settings
      db = Firestore.firestore()
   }
   
   //MARK:- サーバから名前とプロ画のURLを取得する
   private func GetUsersInfomationFromFireStore() {
      let uid = UserDefaults.standard.string(forKey: "UID") ?? ""
      db.collection("users").document(uid).getDocument { (document, err) in
         if let err = err {
            print("データベースからのデータ取得エラー: \(err)")
            self.Play3DtouchError()
         }
         
         if let document = document, document.exists {
            //ドキュメントが存在していたらセットアップをする
            if let userName = document.data()?["name"] as? String {
               self.userName = userName
            }
            if let downLoadUrlAsString = document.data()?["downloadProfileURL"] as? String {
               print("データベースからえたプロ画のURL = \(downLoadUrlAsString)")
               self.userProfileURL = downLoadUrlAsString
            }
            if let fcmToken = document.data()?["FcmToken"] as? String {
               self.usersFcmToken = fcmToken
            }
            if let TimeLineShowList = document.data()?["Follower"] as? Array<Any> {
               self.TimeLineShowList = TimeLineShowList
               self.TimeLineShowList.append(self.UsersUID ?? "")
            }
         } else {
            print("Document does not exist")
         }
         print("ユーザネームとプロ画URLのデータの取得完了")
      }
   }
   
   private func ShowOnPiceView() {
      self.OnPiceView.isHidden = false
   }
   
   func NotShowOnPiceView() {
      self.OnPiceView.isHidden = true
   }

   //MARK:- チェックする配列を初期化する
   private func CrearCheckedStage() {
      CheckedStage = CleanCheckedStage.Checked
   }
   
   //MARK:- 配列の情報を出力
   private func ShowCheckStage() {
      for x in 0 ... 11 {
         print()
         for y in 0 ... 8 {
            if CheckedStage[11 - x][y] == .Out {
               print("\(CheckedStage[11 - x][y]) ", terminator: "")
            }else{
               print("\(CheckedStage[11 - x][y])  ", terminator: "")
            }
         }
      }
      print()
      print()
   }
   
   private func ShowPiceImageArryInfo() {
      for tmp in PiceImageArray {
         print("PiceImageView.selfName = \(tmp.selfName)")
         print("-> (X , Y) = (\(String(describing: tmp.PositionX)) , \(String(describing: tmp.PositionY)))")
      }
   }
   
   private func InitLoadActivityView() {
      //右下に表示するときはこれを使ったらいいよ。
      //let spalete: CGFloat = 9 //横幅 viewWide / X　になる。
      //let Viewsize = self.view.frame.width / spalete
      //let StartX = self.view.frame.width / spalete * (spalete - 1) - Viewsize * 0.45
      //let StartY = self.view.frame.height - Viewsize - Viewsize * 0.45
      let spalete: CGFloat = 5 //横幅 viewWide / X　になる。
      let Viewsize = self.view.frame.width / spalete
      let StartX = self.view.frame.width / 2 - (Viewsize / 2)
      let StartY = self.view.frame.height / 2 - (Viewsize / 2)
      let Rect = CGRect(x: StartX, y: StartY, width: Viewsize, height: Viewsize)
      LoadActivityView = NVActivityIndicatorView(frame: Rect, type: .ballSpinFadeLoader, color: UIColor.flatMint(), padding: 0)
      self.view.addSubview(LoadActivityView!)
   }
   
   //MARK:- ローディングアニメーション再生
   private func StartLoadingAnimation() {
      print("ローディングアニメーション再生")
      self.view.bringSubviewToFront(self.LoadActivityView!)
      self.LoadActivityView?.startAnimating()
      return
   }
   
   public func StopLoadingAnimation() {
      print("ローディングアニメーション停止")
      if LoadActivityView?.isAnimating == true {
         self.LoadActivityView?.stopAnimating()
      }
   }
   
   private func SentCheckedStageFill(StageObject: [String : Any]) -> Bool {
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
      
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY + (PuzzleHight - 1)
      
      for x in LeftUpX ... RightDownX {
         for y in LeftUpY ... RightDownY {
            //let ReverseY = (LeftUpY - y) + RightDownY
            if CheckedStage[y][x] == .In && PArry[y - LeftUpY][x - LeftUpX] == .In {
               return true
            }
         }
      }
      return false
   }
   
   private func CheckdPuzzleFillSentPazzle(StageObject: [String : Any]) {
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
        
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY + (PuzzleHight - 1)
        
      for x in LeftUpX ... RightDownX {
         for y in LeftUpY ... RightDownY {
            //let ReverseY = (LeftUpY - y) + RightDownY
            CheckedStage[y][x] = PArry[y - LeftUpY][x - LeftUpX]
         }
      }
  }
   
   //MARK:- 送信された座標に他のパズル(.In)があるかどうかを判定。
   private func PuzzleAwayyy(AwayX: Int, AwayY: Int, Pice: PiceImageView) -> Bool {
      if AwayX > 0 { return true }
      if AwayY > 0 { return true }
      
      let PuzzleWide = Pice.PiceWideNum
      let PuzzleHight = Pice.PiceHeightNum
      
      if PuzzleWide + AwayX  <= 0 { return true }
      if PuzzleHight + AwayY <= 0 { return true }
      
      return false
   }
   
   private func ExsitsPuzzle(SerchX: Int, SerchY: Int, SentNum: Int) -> Bool {
      for Pice in PiceImageArray {
         //送信者と一致したらcontinue
         if Pice == PiceImageArray[SentNum] {
            print("Puzzle:\(Pice.GetArryNum()) は送信者やからパス")
            continue
         }
         
         let AwayNumX = Pice.PositionX! - SerchX
         let AwayNumY = Pice.PositionY! - SerchY
         
         print("PiceXY: (\(Pice.PositionX!), \(Pice.PositionY!))")
         print("SerchXY: (\(SerchX), \(SerchY))")
         print("AwayNum: (\(AwayNumX), \(AwayNumY))")
         
         //離れすぎてたらcontinue
         if PuzzleAwayyy(AwayX: AwayNumX, AwayY: AwayNumY, Pice: Pice) == true {
            print("Pice:\(Pice.GetArryNum()) は離れすぎ")
            continue
         }
      
         //配列の座標に変換
         let x = -AwayNumX
         let y = -AwayNumY
         
         //一致してたら，そいつの番号を保存してTRUEを返す。
         if Pice.pAllPosi[y][x] == .In {
            ShouldMoveNodeNum = Pice.GetArryNum()
            print(".Inでした。こいつ動かします。")
            return true
         }else{
            print("あったけど .Out やったわ")
         }
      }
      return false
   }
   
   //MARK:- パズルが被ってるかを判定
   private func OverRapped(ArryNum: Int) -> Bool {
      let SentPice = PiceImageArray[ArryNum]
      let SentPuzzleInfo = SentPice.GetOfInfomation()
      
      CheckdPuzzleFillSentPazzle(StageObject: SentPuzzleInfo)
      
      for Pice in PiceImageArray {
         //自分は調べないからcontinueで飛ばす
         if Pice == SentPice {
            print("かぶった。番号-> \(Pice.GetArryNum())")
            continue
         }
         let PiceInfo = Pice.GetOfInfomation()
         //かぶってたらReturn true
         if SentCheckedStageFill(StageObject: PiceInfo) == true { return true }
      }
      
      ShowCheckStage()
      // 被りなし。
      return false
   }
   
   //MARK:- 指話したときにゴミ箱の上かどうかチェックする関数
   private func isPiceOnGarbageBox(SentNum: Int) -> Bool {
      let PiceEndX = PiceImageArray[SentNum].frame.maxX
      let PiceStarY = PiceImageArray[SentNum].frame.minY
      let CheckStandardX: CGFloat = self.view.frame.width - 60
      let CheckStandardY: CGFloat = self.view.safeAreaInsets.top + 50
      
      print("(\(PiceEndX) , \(PiceStarY))\n")
      print("(\(CheckStandardX) , \(CheckStandardY))\n")
      
      if (PiceEndX > CheckStandardX) && (PiceStarY < CheckStandardY) {
         print("\nゴミ箱の上にあった. PiceArryNum = \(SentNum)")
         print("(\(PiceEndX) , \(PiceStarY)\n)")
         return true
      }
      return false
   }
   
   //指話したときにゴミ箱の上やったから削除する関数
   private func DeletePiceOnGarbageBox(SentNum: Int) {
      if PiceImageArray.count == MaxCanPutPiceNum {
         isMaxPutPice = false
         collectionView.alpha = 1
      }
      PiceImageArray[SentNum].removeFromSuperview()
      PiceImageArray.remove(at: SentNum)
      Play3DtouchSuccess()
      Analytics.logEvent("TrashImageNum", parameters: nil)
   }
   
   private func UpdateAllPiceArryNum() {
      var SetNum = 0
      for Pice in PiceImageArray {
         Pice.UpdateArryNum(ArryNum: SetNum)
         SetNum += 1
      }
   }
   
   //MARK:- 通知を受け取る
   @objc func MovedPiceCatchNotification(notification: Notification) -> Void {
      print("--- Fin Move notification ---")
      CrearCheckedStage()
      
      if FinishChouseResPuzzleButton?.isHidden == true {
         InfoLabel.text = NSLocalizedString("SelectPice", comment: "")
      }
      
      
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["ArryNum"] as! Int
         print("送信者番号: \(SentNum)")
         
         //もしPiceがゴミ箱の上に乗ってて，かつ，ロックされてなかったら
         if isPiceOnGarbageBox(SentNum: SentNum) == true && isLockColleViewANDTrashPice == false {
            DeletePiceOnGarbageBox(SentNum: SentNum)
            UpdateAllPiceArryNum()
            return
         }
         
         PiceImageArray[SentNum].touchEndAndPutPice()
         
         //Nodeを置いた場所に他のノードがいたら，元に戻ってもらう。
         if OverRapped(ArryNum: SentNum) == true {
            //って言ってもBefor設定してなかったら削除する
            if PiceImageArray[SentNum].isBeforPositionIsNothing() {
               print("Before未設定なので消します")
               PiceImageArray[SentNum].removeFromSuperview()
               PiceImageArray.remove(at: SentNum)
               Play3DtouchError()
            }else{
               //Befor設定してたら帰る
               PiceImageArray[SentNum].ReBackPicePosition()
            }
         }else{
            PiceImageArray[SentNum].UpdateBeforXY()
            
            //置くときに最大なら置けなくする。
            if PiceImageArray.count == MaxCanPutPiceNum {
               isMaxPutPice = true
               collectionView.alpha = 0.45
            }
            
         }
   
         CrearCheckedStage()
      }else{ print("通知受け取ったけど、中身nilやった。") }
   }
   
   //MARK: .OUTをタップしたときにPuzzleからくる関数
   @objc func PiceTouchStartCatchNotification(notification: Notification) -> Void {
      print("--- Alpha Tap notification ---")
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["ArryNum"] as! Int
         let TapPosi = userInfo["TapPosi"] as! CGPoint
         let X = userInfo["X"] as! Int
         let Y = userInfo["Y"] as! Int
         print("送信者番号: \(SentNum)")
         print("タップした座標: \(TapPosi)")
         
         let SerchX = PiceImageArray[SentNum].PositionX! + X
         let SerchY = PiceImageArray[SentNum].PositionY! + Y
         
         print("SerchPoint: (\(SerchX), \(SerchY))")
         
         if ExsitsPuzzle(SerchX: SerchX, SerchY: SerchY, SentNum: SentNum) == true {
            print("探したらPiceあったよ.")
            DontMoveNodeNum = PiceImageArray[SentNum].GetArryNum()
            print("SoudlNum = \(ShouldMoveNodeNum)")
            print("DontNum  = \(DontMoveNodeNum)")
            PiceImageArray[SentNum].SelfTouchBegan()
         }else{
            print("探したけどほかのPiceなかったよ。")
            PiceImageArray[SentNum].ChangeTRUEMoveMyself()
            return
         }
         
      }else{
         print("通知受け取ったけど、中身nilやった。")
      }
      
      return
   }
   
   @objc func PiceTouchMovedCatchNotification(notification: Notification) -> Void {
      if let userInfo = notification.userInfo {
         let Dx = userInfo["Dx"] as! CGFloat
         let Dy = userInfo["Dy"] as! CGFloat
         
         let ShouldMovedNode = PiceImageArray[ShouldMoveNodeNum]
         
         ShouldMovedNode.SelfTouchMoved(Dx: Dx, Dy: Dy)
      }
   }
   
   @objc func PiceTouchEndedCatchNotification(notification: Notification) -> Void {
      let ShouldMovedNode = PiceImageArray[ShouldMoveNodeNum]
      let DontMoveNode = PiceImageArray[DontMoveNodeNum]
      
      ShouldMovedNode.SelfTouchEnded()
      
      DontMoveNode.ChangeTRUEMoveMyself()
   }
   
   private func RemovePiceUserDontPiceUp(PiceName: String) {
      var DeleArryDec = 0 //swiftの配列は削除したら自動的に前に詰めるからforで回したときにズレをふせぐ
      for tmp in 0 ... WorkPlacePiceImageArray.count - 1 {
         if WorkPlacePiceImageArray[tmp - DeleArryDec].selfName != PiceName {
            WorkPlacePiceImageArray[tmp - DeleArryDec].removeFromSuperview()
            WorkPlacePiceImageArray.remove(at: tmp - DeleArryDec)
            DeleArryDec += 1
         }
      }
   }
   
   private func ArryNumOfPiceViewUpdateFromPiceImageArry() {
      for tmp in 0 ... PiceImageArray.count - 1{
         PiceImageArray[tmp].UpdateArryNum(ArryNum: tmp)
      }
   }
   
   private func WorkForPiceUserPiceUp() {
      if WorkPlacePiceImageArray.count != 1 {
         fatalError("選択されてないPice削除したのに作業用の配列の数が1でない。")
      }
      //PickUpされたら専用の配列に格納
      PiceImageArray.append(WorkPlacePiceImageArray.first!)
      ArryNumOfPiceViewUpdateFromPiceImageArry()
      //PickUpしたPiceに対してBoolをtrueにしチェックされた状態にする
      WorkPlacePiceImageArray.first?.ChangeTRUEisPiceUp()
      //作業用の配列は全削除
      WorkPlacePiceImageArray.removeAll()
   }
   
   @objc func PiceUpPiceImageView(notification: Notification) -> Void {
      if let userInfo = notification.userInfo {
         let PiceName = userInfo["PiceName"] as! String
         print("選択されたPiceName = \(PiceName)")
         //選択されたPice以外を削除する
         RemovePiceUserDontPiceUp(PiceName: PiceName)
         //残ったPice(1つ)に対して情報を操作する
         WorkForPiceUserPiceUp()
         ////OnPiceViewを非表示に
         NotShowOnPiceView()
         #if DEBUG
         //配列の情報の表示
         //ShowPiceImageArryInfo()
         #endif
      }else{ print("Nil きたよ") }
   }
   
   //MARK:- コレクションViewのCellをタップした時の関数
   func TappedCell(CellNum: Int) {
      //画像の名前を色を除いて取得
      //例えば，23p43Blueの場合は23p43を抽出する
      let PiceName: String = UsingPiceSet[CellNum].pregReplace(pattern: "(Green|Blue|Red)", with: "")
      let PiceStyle = UsingPiceSet[CellNum].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")
      switch  PiceStyle{
      case "23":
         GreenFlame = GreenFlame2_3
         RedFlame = RedFlame2_3
         BlueFlame = BlueFlame2_3
      case "32":
         GreenFlame = GreenFlame4_3
         RedFlame = RedFlame4_3
         BlueFlame = BlueFlame4_3
      case "33":
         GreenFlame = GreenFlame1_1
         RedFlame = RedFlame1_1
         BlueFlame = BlueFlame1_1
      case "43":
         GreenFlame = GreenFlame4_3
         RedFlame = RedFlame4_3
         BlueFlame = BlueFlame4_3
      default:
         fatalError()
      }
      
      //画像を3つ表示
      let GreenPiceImageView = PiceImageView(frame: GreenFlame, name: PiceName + "Green", WindowFlame: view.frame)
      let RedPiceImageView = PiceImageView(frame: RedFlame, name: PiceName + "Red", WindowFlame: view.frame)
      let BluePiceImageView = PiceImageView(frame: BlueFlame, name: PiceName + "Blue", WindowFlame: view.frame)
      
      GreenPiceImageView.SetUPAlphaImageView()
      RedPiceImageView.SetUPAlphaImageView()
      BluePiceImageView.SetUPAlphaImageView()
      
      GreenPiceImageView.accessibilityIdentifier = "GreenPiceImageView"
      RedPiceImageView.accessibilityIdentifier = "RedPiceImageView"
      BluePiceImageView.accessibilityIdentifier = "BluePiceImageView"
      
      view.addSubview(GreenPiceImageView)
      view.addSubview(RedPiceImageView)
      view.addSubview(BluePiceImageView)
      
      WorkPlacePiceImageArray.append(GreenPiceImageView)
      WorkPlacePiceImageArray.append(RedPiceImageView)
      WorkPlacePiceImageArray.append(BluePiceImageView)

      
      ShowOnPiceView()
   }
   
   private func CompleteFillContentsArrayUseFillContentsArray(StageObject: [String: Any]) {
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
        
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY + (PuzzleHight - 1)
        
      for x in LeftUpX ... RightDownX {
         for y in LeftUpY ... RightDownY {
            //すでにIn入ってる場合はOutで塗りつぶされるのを防ぐためにifsiteru
            if FillContentsArray[y][x] == .In { continue }
            FillContentsArray[y][x] = PArry[y - LeftUpY][x - LeftUpX]
         }
      }
   }
   
   private func CompleteFillContentsArrayUseCheckedStage(StageObject: [String: Any]) {
      let StartX = StageObject["StartPointX"] as! Int
      let StartY = StageObject["StartPointY"] as! Int
        
      let PuzzleWide = StageObject["PuzzleWide"] as! Int
      let PuzzleHight = StageObject["PuzzleHight"] as! Int
      let PArry = StageObject["PArry"] as! [[Contents]]
      
      let LeftUpX = StartX
      let LeftUpY = StartY
      
      let RightDownX = StartX + (PuzzleWide - 1)
      let RightDownY = StartY + (PuzzleHight - 1)
        
      for x in LeftUpX ... RightDownX {
         for y in LeftUpY ... RightDownY {
            //すでにIn入ってる場合はOutで塗りつぶされるのを防ぐためにifsiteru
            if CheckedStage[y][x] == .In { continue }
            CheckedStage[y][x] = PArry[y - LeftUpY][x - LeftUpX]
         }
      }
   }
   
   @objc func TapOptionButton() {
      print("Tap OptionButton")
      Play3DtouchLight()
      GameSound.PlaySoundsTapButton()
      Analytics.logEvent("TapOptionBtn", parameters: nil)
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)

      ComleateView.addButton(NSLocalizedString("Home", comment: "")){
         if self.FinishChouseResPuzzleButton?.isHidden == false{
            self.FinishChouseResPuzzleButton?.hero.id = self.HeroID.CreateBackAndCreatingFinButton
         }
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         Analytics.logEvent("TapHomeCreateing", parameters: nil)
      }
      ComleateView.addButton(NSLocalizedString("Cancel", comment: "")) {
         self.Play3DtouchLight()
         self.GameSound.PlaySoundsTapButton()
      }
      
      ComleateView.showInfo(NSLocalizedString("Pouse", comment: ""), subTitle: NSLocalizedString("IfGoHome", comment: ""))
   }
   
   
   
   @objc func TapTrashView(_ sender: UITapGestureRecognizer) {
      print("Tap TrashView")
      Analytics.logEvent("TapTrashView", parameters: nil)
      guard isLockColleViewANDTrashPice == false else {
         return
      }
      Play3DtouchHeavy()
      InfoLabel.text = NSLocalizedString("TrashPice", comment: "")
   }
   
   @objc func TapFinishiButton() {
      print("FinPutButtonタップされたよ")
      guard PiceImageArray.count != 0 else {
         print("Piceが1つも選ばれてません")
         InfoLabel.text = NSLocalizedString("PutOneMorePice", comment: "")
         Play3DtouchError()
         GameSound.PlaySoundsTapButton()
         return
      }
      Play3DtouchMedium()
      GameSound.PlaySoundsTapButton()
      //Lockをかける
      isLockColleViewANDTrashPice = true
      collectionView.alpha = 0.45
      TrashImageView.alpha = 0.45
      
      InfoLabel.text = NSLocalizedString("DecideInitPosi", comment: "")
      
      FillContentsArray = CleanCheckedStage.Checked
      
      for Pice in PiceImageArray {
         let PiceInfo = Pice.GetOfInfomation()
         CompleteFillContentsArrayUseFillContentsArray(StageObject: PiceInfo)
      }
      
      //print(FillContentsArray)
      
      BackImageView!.GetContentArray(GetContentsArry: FillContentsArray)
      BackImageView!.ReSetUpBackTileImage()
      
      FinishCreatePuzzleButton?.isHidden = true
      FinishChouseResPuzzleButton?.isHidden = false
      Analytics.logEvent("TapFinPutBtn", parameters: nil)
   }
   
   @objc func TapFinChouseResPuzzleButton() {
      print("FinChoseResタップされたよ")
      CrearCheckedStage()
      
      for Pice in PiceImageArray {
         let PiceInfo = Pice.GetOfInfomation()
         CompleteFillContentsArrayUseCheckedStage(StageObject: PiceInfo)
      }
      
      if FillContentsArray == CheckedStage {
         print("変更しましょう")
         InfoLabel.text = NSLocalizedString("ShiftPice", comment: "")
         Play3DtouchError()
         GameSound.PlaySoundsTapButton()
         return
      }
      
      Analytics.logEvent("TapChoseResBtn", parameters: nil)
      
      Play3DtouchHeavy()
      GameSound.PlaySoundsTapButton()
      
      //二重にタッチされるのを防ぐ
      self.FinishChouseResPuzzleButton?.isEnabled = false
      self.FinishChouseResPuzzleButton?.alpha = 0.65
      
      ShowWriteStageTitleAlertView()
   }
   
   
   //MARK:- ステージ名を欠かす処理
   func ShowWriteStageTitleAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let WrriteStageAlert = SCLAlertView(appearance: Appearanse)
      let StageName = NSLocalizedString("StageName", comment: "")
      let StageTitleTextField = WrriteStageAlert.addTextField(StageName)
      
      WrriteStageAlert.addButton(NSLocalizedString("Register", comment: "")) {
         let NoName = "No Name"
         if StageTitleTextField.text!.isEmpty == false {
            self.StageTitle = StageTitleTextField.text ?? NoName
         } else {
            self.StageTitle = NoName
         }
         self.SaveStageUserCreated()
      }
      let Title = NSLocalizedString("StageName", comment: "")
      let WriteTitle = NSLocalizedString("EnterStageName", comment: "")
      WrriteStageAlert.showEdit(Title, subTitle: WriteTitle)
   }
   
   func trimmingImage(_ image: UIImage, trimmingArea: CGRect) -> UIImage {
       let imgRef = image.cgImage?.cropping(to: trimmingArea)
       let trimImage = UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
       return trimImage
   }
   
   //UIImageをNSDataにして返す関数
   private func SaveStageViewUseScreenshot() -> NSData {
      //コンテキスト開始
      UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
      //viewを書き出す
      self.view.drawHierarchy(in: view.frame, afterScreenUpdates: false)
      // imageにコンテキストの内容を書き出す
      let GetAllViewImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
      //コンテキストを閉じる
      UIGraphicsEndImageContext()
      
      //80 * 110にリサイズする。これはcellで自分で決めたから
      if let UseImage = GetAllViewImage.cropping(to: ( BackImageView?.GetRectForScreenshot() )!) {
         let ResizeW: CGFloat = 80
         let ResizeH: CGFloat = 110
         let RetruenImage = UseImage.ResizeUIImage(width: ResizeW, height: ResizeH)
         return RetruenImage?.jpegData(compressionQuality: 0.5) as! NSData
      }else{
         fatalError()
      }
   }
   
   
   //MARK:- 保存する関数
   private func SaveStageUserCreated() {
      
      //ローディングアニメーション開始
      //止める時は，下の2つの関数のいずれかで停止。
      // ErrSentStageCatchNotification()
      // SuccessSentStagePiceTouchEndedCatchNotification()
      self.StartLoadingAnimation()
      
      let SaveDataBase = UserCreateStageDataBase()
      let ImageData: NSData = SaveStageViewUseScreenshot()
      
      SaveDataBase.AddStage(StageArrayForContents: FillContentsArray, MaxPiceNum: PiceImageArray.count,
                            PiceArry: PiceImageArray, ImageData: ImageData)
      
      let UID = UserDefaults.standard.object(forKey: "UID") as! String
      let FireStore = Firestores(uid: UID)
      
      FireStore.AddStageData(StageArrayForContents: FillContentsArray, MaxPiceNum: PiceImageArray.count,
                             PiceArry: PiceImageArray, ImageData: ImageData, StageTitle: StageTitle, addUserName: self.userName, addUsersProfileURL: self.userProfileURL, UsersFcmToken: self.usersFcmToken, TimeLineShowList: self.TimeLineShowList)
      
      
   }
   
   
   //MARK:- 保存成功と失敗を受け取る関数
   @objc func ErrSentStageCatchNotification(notification: Notification) -> Void {
      print("Errした通知受け取った。")
      StopLoadingAnimation()
      Play3DtouchError()
      ShowErrSentFireStoreSaveAlertView()
      Analytics.logEvent("ErrCleateStageCount", parameters: nil)
   }
   
   @objc func SuccessSentStagePiceTouchEndedCatchNotification(notification: Notification) -> Void {
      print("成功した通知受け取った。")
      IncrementCreateStageNum()
      StopLoadingAnimation()
      Play3DtouchSuccess()
      ShowCompleteSaveAlertView()
      Analytics.logEvent("CreateStageCount", parameters: nil)
   }

   private func ShowErrSentFireStoreSaveAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
      }
      let Error = NSLocalizedString("err", comment: "")
      let errSave = NSLocalizedString("errSave", comment: "")
      let checkNet = NSLocalizedString("checkNet", comment: "")
      ComleateView.showError(Error, subTitle: errSave + "\n" + checkNet)
   }
   
   private func ShowCompleteSaveAlertView() {
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      ComleateView.addButton("OK"){
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
      }
      let Suc = NSLocalizedString("suc", comment: "")
      let sucSave = NSLocalizedString("sucSave", comment: "")
      ComleateView.showSuccess(Suc, subTitle: sucSave)
   }
   
   private func IncrementCreateStageNum() {
      let CreateStageNum: Int = UserDefaults.standard.integer(forKey: "CreateStageNum")
      print("\nステージ送信完了したので登録しているステージ数を\nインクリメントします。")
      UserDefaults.standard.set(CreateStageNum + 1, forKey: "CreateStageNum")
      let AfterCreateStageNum: Int = UserDefaults.standard.integer(forKey: "CreateStageNum")
      print("インクリメント完了しました")
      print("登録数は：　\(CreateStageNum) から　\(AfterCreateStageNum) に更新されました\n\n")
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

