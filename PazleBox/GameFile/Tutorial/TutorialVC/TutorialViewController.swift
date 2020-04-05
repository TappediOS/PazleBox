//
//  TutorialViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import TapticEngine
import FlatUIKit
import SnapKit
import SCLAlertView
import Firebase
import NVActivityIndicatorView

class TutorialViewController: UIViewController, UIGestureRecognizerDelegate {
   
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
     
   var DontMoveNodeNum = 0
   var ShouldMoveNodeNum = 0
     
   //くるくる回るview
   var LoadActivityView: NVActivityIndicatorView?
     
     
   //いま対応してるのは，23,32,33,43,
   let photos = ["33p7Red", "33p21Blue","23p13Green","43p10Red","23p5Red",
   "23p14Green","43p19Red","33p34Red","23p12Green","23p11Red",
   "43p26Blue", "33p8Green","43p8Green","33p25Blue","33p28Green",
   "32p12Blue","32p3Red","43p32Blue","33p33Red","32p5Red",
   "33p3Blue", "33p23Green","43p21Green","43p26Blue","43p28Blue",
   "33p34Red","43p35Green","23p4Red","33p1Blue","32p13Green"]
     
   let sectionInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: -17)
   let itemsPerRow: CGFloat = 1 //Cellを横に何個入れるか
   
   var CanUseAreaHeight: CGFloat = 0
   
   var isLockColleViewANDTrashPice = false
   
   let HeroID = HeroIDs()
   let GameSound = GameSounds()
   
   var BackGroundImageView: BackGroundImageViews?
   
   
   var BalloonView: TutorialBalloon?
   var BalloonViewRect = CGRect()
   
   var tapImage: TapImage?
   
   //MARK:- Piceがおける最大値
   let MaxCanPutPiceNum = 7
   var isMaxPutPice = false
   
   var tutorialManager = TutorialManager()
        
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitViewSetting()
      InitBackgroundImageView()
      InitBackTileImageView()
      GetStartBackImageViewY()
      
      InitNotification()
      
      InitFinishCreatePuzzleButton()
      InitFinishChouseResPuzzleButton()
      InitTrashView()
      InitOptionButton()
      InitInfoLabel()
      
      InitLoadActivityView()
      
      InitOnPiceView()
      
      CrearCheckedStage()
      
      InitBalloonViewRect()
      InitBalloonView()
      
      InitTapImage()
      
      InitCollectionView()
      
      SetUpEachObjetForTutorial()
      
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
   
   deinit {
      print("tutorialデイニットされたーーーー!!!!!")
   }
     
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)

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
         //print("\nゴミ箱の上にあった. PiceArryNum = \(SentNum)")
         //print("(\(PiceEndX) , \(PiceStarY)\n)")
         //チュートリアルの場合は必ずfalseが帰るようにしてピースを削除させなくする
         //return true
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
         
         //もしPiceがゴミ箱の上に乗ってて，かつ，ロックされてなかったら削除する
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
            //ユーザがおきたい場所にピースを置くことに成功したときの処理
            PiceImageArray[SentNum].UpdateBeforXY()
            
            //置くときに最大なら置けなくする。
            if PiceImageArray.count == MaxCanPutPiceNum {
               isMaxPutPice = true
               collectionView.alpha = 0.45
            }
            
            
            //MARK:- Tutorial
            //ピースおき終わったよって教えてあげる。
            if tutorialManager.getState() == .operationTapPiceViewFirst {
               tutorialManager.finishDragAndDropPiceFirst()
            } else if tutorialManager.getState() == .operationTapPiceViewSecond {
               tutorialManager.finishDragAndDropPiceSecond()
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
      let PiceName: String = photos[CellNum].pregReplace(pattern: "(Green|Blue|Red)", with: "")
      let PiceStyle = photos[CellNum].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")
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
      
      //チュートリアルで１回目の時はタップできないようにする。
      if tutorialManager.getState() == .operationCollectionViewFirst {
         GreenPiceImageView.isUserInteractionEnabled = false
         RedPiceImageView.isUserInteractionEnabled = false
         BluePiceImageView.isUserInteractionEnabled = false
      }
      
      view.addSubview(GreenPiceImageView)
      view.addSubview(RedPiceImageView)
      view.addSubview(BluePiceImageView)
      
      WorkPlacePiceImageArray.append(GreenPiceImageView)
      WorkPlacePiceImageArray.append(RedPiceImageView)
      WorkPlacePiceImageArray.append(BluePiceImageView)

      
      ShowOnPiceView()
      
      //画像を置き終わったら，終わった旨をTutorialManagerに伝える。
      if tutorialManager.getState() == .operationCollectionViewFirst {
         tutorialManager.finishTapCollectionViewFirst()
      } else {
         tutorialManager.finishTapCollectionViewSecond()
      }
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
      let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
      let ComleateView = SCLAlertView(appearance: Appearanse)
      //TODO:- ローカライズすること
      ComleateView.addButton(NSLocalizedString("チュートリアルを終了", comment: "")){
         if self.FinishChouseResPuzzleButton?.isHidden == false{
            self.FinishChouseResPuzzleButton?.hero.id = self.HeroID.CreateBackAndCreatingFinButton
         }
         self.dismiss(animated: true)
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
         Analytics.logEvent("TapHomeCreateing", parameters: nil)
      }
      
      ComleateView.addButton(NSLocalizedString("Cansel", comment: "")){
         self.Play3DtouchHeavy()
         self.GameSound.PlaySoundsTapButton()
      }
      
      let title = NSLocalizedString("Pouse", comment: "")
      let subTitle = NSLocalizedString("チュートリアルを終了しますか？", comment: "")   //TODO:- ローカライズすること
      ComleateView.showInfo(title, subTitle: subTitle)
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
      
      //MARK:- Tutorial
      //FinButton押したことをManageに通知
      tutorialManager.finishTapFinButton()
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
      
      //MARK:- Tutorial終了
      tutorialManager.finishTapFinChoseResButton()
   }
   


   
   //MARK: Tutorial
   //MARK:- Viewがタップされたときのイベント
   //チュートリアルの進行に使用する。
   @objc func TappedView(_ sender: UITapGestureRecognizer) {
      print("TapView")
      tutorialManager.TapTutorialView()
   }
   
   
   @objc func AdvanceTutorialCatchNotification(notificaton: Notification) {
      print("\n-----チュートリアルを進めます。-----\n")
      let tutorialNum = tutorialManager.getTutorialNum()
      BalloonView?.advance(advanceTutorialNum: tutorialNum)
   }
   
   @objc func TurnOnCollectionViewCatchNotification(notificaton: Notification) {
      print("\n-----CollectionViewをオンにします-----\n")
      self.collectionView.isUserInteractionEnabled = true
   }
   
   @objc func TurnOffCollectionViewCatchNotification(notificaton: Notification) {
      print("\n-----CollectionViewをオフにします-----\n")
      self.collectionView.isUserInteractionEnabled = false
   }
   
   @objc func TurnOnFinButtonCatchNotification(notificaton: Notification) {
      print("\n-----FinButtonをオンにします-----\n")
      self.FinishCreatePuzzleButton?.isEnabled = true
   }
   
   @objc func TurnOffFinButtonCatchNotification(notificaton: Notification) {
      print("\n-----FinButtonをオフにします-----\n")
      self.FinishCreatePuzzleButton?.isEnabled = false
   }
   
   @objc func TurnOnChoseResButtonCatchNotification(notificaton: Notification) {
      print("\n-----ChoseResButtonをオンにします-----\n")
      self.FinishChouseResPuzzleButton?.isEnabled = true
   }
   
   @objc func TurnOffChoseResButtonCatchNotification(notificaton: Notification) {
      print("\n-----ChoseResButtonをオフにします-----\n")
      self.FinishChouseResPuzzleButton?.isEnabled = false
   }
   
   @objc func TuronOnPiceImageViewCatchNotification (notificaton: Notification) {
      print("\n-----PiceViewをタップできるようににします-----\n")
      for pice in WorkPlacePiceImageArray {
         pice.isUserInteractionEnabled = true
      }
   }
   
   @objc func StartAnimationCollectionViewFirstCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(CollectionView)スタート　１回目-----\n")
      tapImage?.appearImageView()
      let frame = collectionView.frame
      tapImage?.changePosition(posiX: frame.midX, posiY: (frame.midY + frame.minY) / 2)
      tapImage?.startAnimation()
   }
   
   @objc func StartAnimationCollectionViewSecondCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(CollectionView)スタート　2回目-----\n")
      tapImage?.appearImageView()
      let frame = collectionView.frame
      tapImage?.changePosition(posiX: (frame.midX + frame.minX) / 2, posiY: (frame.midY + frame.minY) / 2)
      tapImage?.startAnimation()
   }
   
   @objc func StartAnimationFinButtonCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(FinButton)スタート-----\n")
      tapImage?.appearImageView()
      let frame = FinishCreatePuzzleButton?.frame
      tapImage?.changePosition(posiX: frame!.minX + 12, posiY: (frame!.midY + frame!.minY) / 2)
      tapImage?.startAnimation()
   }
   
   @objc func StartAnimationResButtonCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(ResButton)スタート-----\n")
      tapImage?.appearImageView()
      let frame = FinishChouseResPuzzleButton?.frame
      tapImage?.changePosition(posiX: frame!.minX + 12, posiY: (frame!.midY + frame!.minY) / 2)
      tapImage?.startAnimation()
   }
   
   @objc func StartAnimationDragAndDropFirstCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(DragDrop)スタート 1回目-----\n")
      guard WorkPlacePiceImageArray.count == 3 else {
         print("3じゃない")
         return
      }
      tapImage?.appearImageView()
      //配列には，[緑, 赤，青]の順で入っていることに注意。
      let frame = WorkPlacePiceImageArray[0].frame
      self.view.bringSubviewToFront(self.tapImage!)
      let posiX = (frame.maxX + frame.minX) / 2 - (frame.maxX - frame.minX) / 2
      tapImage?.changePosition(posiX: posiX , posiY: (frame.midY + frame.minY) / 2)
      tapImage?.startDragAndDropAnimationFirst()
   }
   
   @objc func StartAnimationDragAndDropSecondCatchNotification (notificaton: Notification) {
      print("\n-----アニメーション(DragDrop)スタート 2回目-----\n")
      guard WorkPlacePiceImageArray.count == 3 else {
         print("3じゃない")
         return
      }
      tapImage?.appearImageView()
      //配列には，[緑, 赤，青]の順で入っていることに注意。
      let frame = WorkPlacePiceImageArray[2].frame
      self.view.bringSubviewToFront(self.tapImage!)
      let posiX = (frame.maxX + frame.minX) / 2 - (frame.maxX - frame.minX) / 2
      tapImage?.changePosition(posiX: posiX, posiY: (frame.midY + frame.minY) / 2)
      tapImage?.startDragAndDropAnimationSecond()
   }
   
   @objc func ClearTapImageViewCatchNotification (notificaton: Notification) {
      print("\n-----アニメーションを非表示にする-----\n")
      tapImage?.stopAnimation()
      tapImage?.clearImageView()
   }
   
   @objc func FinishTutorialCatchNotification (notificaton: Notification) {
      print("\n-----チュートリアル終わり-----\n")
      NotificationCenter.default.post(name: .stopBGMforTutorial, object: nil)
      self.view.fadeOut(type: .Slow, completed: {
         self.dismiss(animated: false, completion: {
            NotificationCenter.default.post(name: .showTabBar, object: nil)
         })
      })
      
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}
