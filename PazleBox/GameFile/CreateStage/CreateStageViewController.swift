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

class CleateStageViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   var OnPiceView = UIView()
   
   var BackImageView: BackTileImageView?
   
   var FinishCreatePuzzleButton: FUIButton?
   var FinishChouseResPuzzleButton: FUIButton?
   
   var TrashImageView = UIImageView()
   
   
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
   
   let photos = ["33p22Blue", "33p21Blue","43p21Blue","43p2Green","23p5Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue",
   "33p34Blue","43p35Blue","43p36Red","43p25Blue","43p31Blue",
   "33p22Blue", "33p21Blue","43p21Blue","43p2Green","32p3Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue"]
   
   let sectionInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: -17)
   let itemsPerRow: CGFloat = 1 //Cellを横に何個入れるか
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
      GetStartBackImageViewY()
      
      InitNotification()
      
      InitFinishCreatePuzzleButton()
      InitFinishChouseResPuzzleButton()
      InitTrashView()
      
      InitOnPiceView()
      
      CrearCheckedStage()
      
      InitMochUserSellectedImageView()
      
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
 
      collectionView.backgroundColor = UIColor.flatWhite()
      collectionView.delegate = self
      collectionView.dataSource = self
      
      collectionView.collectionViewLayout.invalidateLayout()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      ReSetUpOnPiceView()
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
   
   private func InitBackTileImageView() {
      BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView!)
   }
   
   private func GetStartBackImageViewY() {
      let TileWide = self.view.frame.width / 10
      let Inter = TileWide / 10
      let ViewHeight = 12 * (TileWide + Inter)
      StartBackImageViewY = self.view.frame.height - ViewHeight - TileWide / 2
      print("BackView開始のY座標は　\(StartBackImageViewY)")
   }
   
   private func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(PiceUpPiceImageView(notification:)), name: .PickUpPiceImageView, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(MovedPiceCatchNotification(notification:)), name: .PiceMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchStartCatchNotification(notification:)), name: .PiceTouchStarted, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchMovedCatchNotification(notification:)), name: .PiceTouchMoved, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PiceTouchEndedCatchNotification(notification:)), name: .PiceTouchEnded, object: nil)
   }
   
   private func InitFinishCreatePuzzleButton() {
      FinishCreatePuzzleButton = FUIButton(frame: CGRect(x: view.frame.width / 20 * 5, y: 150, width: view.frame.width / 20 * 5, height: 50))
      FinishCreatePuzzleButton?.setTitle("owari", for: .normal)
      FinishCreatePuzzleButton?.addTarget(self, action: #selector(self.TapFinishiButton), for: .touchUpInside)
      FinishCreatePuzzleButton?.titleLabel?.adjustsFontSizeToFitWidth = true
      FinishCreatePuzzleButton?.titleLabel?.adjustsFontForContentSizeCategory = true
      FinishCreatePuzzleButton?.buttonColor = UIColor.turquoise()
      FinishCreatePuzzleButton?.shadowColor = UIColor.greenSea()
      FinishCreatePuzzleButton?.shadowHeight = 3.0
      FinishCreatePuzzleButton?.cornerRadius = 6.0
      FinishCreatePuzzleButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      FinishCreatePuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      FinishCreatePuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      view.addSubview(FinishCreatePuzzleButton!)
   }
   
   private func InitFinishChouseResPuzzleButton() {
      FinishChouseResPuzzleButton = FUIButton(frame: CGRect(x: view.frame.width / 20 * 5, y: 150, width: view.frame.width / 20 * 5, height: 50))
      FinishChouseResPuzzleButton?.setTitle("onn", for: .normal)
      FinishChouseResPuzzleButton?.addTarget(self, action: #selector(self.TapFinChouseResPuzzleButton), for: .touchUpInside)
      FinishChouseResPuzzleButton?.titleLabel?.adjustsFontSizeToFitWidth = true
      FinishChouseResPuzzleButton?.titleLabel?.adjustsFontForContentSizeCategory = true
      FinishChouseResPuzzleButton?.buttonColor = UIColor.turquoise()
      FinishChouseResPuzzleButton?.shadowColor = UIColor.greenSea()
      FinishChouseResPuzzleButton?.shadowHeight = 3.0
      FinishChouseResPuzzleButton?.cornerRadius = 6.0
      FinishChouseResPuzzleButton?.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
      FinishChouseResPuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
      FinishChouseResPuzzleButton?.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
      FinishChouseResPuzzleButton?.isHidden = true
      view.addSubview(FinishChouseResPuzzleButton!)
   }
   
   private func InitTrashView() {
      //TrashImageView.addTarget(self, action: #selector(self.TapOptionButton), for: .touchUpInside)
      TrashImageView.image = UIImage(named: "Trash_Black128.png")

      view.addSubview(TrashImageView)
      
      TrashImageView.snp.makeConstraints{ make in
         make.height.equalTo(50)
         make.width.equalTo(50)
         make.trailing.equalTo(self.view.snp.trailing).offset(-8)
         if #available(iOS 11, *) {
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(7)
         } else {
           make.top.equalTo(self.view.snp.top).offset(7)
         }
      }
   }
   
   private func InitOnPiceView() {
      let Flame = CGRect(x: view.frame.width / 20, y: 50, width: view.frame.width / 25 * 23, height: 50)
      OnPiceView = UIView(frame: Flame)
      OnPiceView.backgroundColor = UIColor.flatWhite()
      OnPiceView.isHidden = true
      view.addSubview(OnPiceView)
   }
   
   private func ReSetUpOnPiceView() {
      let SafeAreaTop: CGFloat = self.view.safeAreaInsets.top
      print("safeareaのトップは　\(SafeAreaTop)")
      let CollectionviewHeight = collectionView.frame.height
      print("CollectionViewの高さは \(CollectionviewHeight)")
      let SafeAndCollectionH = SafeAreaTop + CollectionviewHeight
      let CanUseAreaHeight = StartBackImageViewY - SafeAndCollectionH
      print("使える高さは \(CanUseAreaHeight)")
      
      var ViewPedding: CGFloat = 0
      
      if SafeAreaTop > 40 {
         ViewPedding = 38
      }else{
         ViewPedding = 3
      }
      
      let StartY = SafeAndCollectionH + ViewPedding
      let Height = CanUseAreaHeight - ViewPedding * 2
      
      
      let Flame = CGRect(x: view.frame.width / 25, y: StartY, width: view.frame.width / 25 * 23, height: Height)
      OnPiceView.frame = Flame
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

   private func InitMochUserSellectedImageView() {
      
   }
   
   private func ShowPiceImageArryInfo() {
      for tmp in PiceImageArray {
         print("PiceImageView.selfName = \(tmp.selfName)")
         print("-> (X , Y) = (\(String(describing: tmp.PositionX)) , \(String(describing: tmp.PositionY)))")
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
      PiceImageArray[SentNum].removeFromSuperview()
      PiceImageArray.remove(at: SentNum)
      Play3DtouchSuccess()
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
         
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["ArryNum"] as! Int
         print("送信者番号: \(SentNum)")
         
         //もしPiceがゴミ箱の上に乗ってたら
         if isPiceOnGarbageBox(SentNum: SentNum) == true {
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
   
   func TappedCell(CellNum: Int) {
      //画像の名前を色を除いて取得
      //例えば，23p43Blueの場合は23p43を抽出する
      let PiceName: String = photos[CellNum].pregReplace(pattern: "(Green|Blue|Red)", with: "")
      print("TapName = \(PiceName)")
      
      
      
      let PiceStyle = photos[CellNum].pregReplace(pattern: "p[0-9]+(Green|Blue|Red)", with: "")
      print("PiceStyle = \(PiceStyle)")
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
   }
   
   @objc func TapFinishiButton() {
      print("FinPutButtonタップされたよ")
      guard PiceImageArray.count != 0 else {
         print("Piceが1つも選ばれてません")
         return
      }
      
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
         return
      }
      
      FinishChouseResPuzzleButton?.isHidden = true
      
      
      SaveStageUserCreated()
   }
   
   func trimmingImage(_ image: UIImage, trimmingArea: CGRect) -> UIImage {
       let imgRef = image.cgImage?.cropping(to: trimmingArea)
       let trimImage = UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
       return trimImage
   }
   
   private func SaveStageViewUseScreenshot() -> NSData {
      //コンテキスト開始
      UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
      //viewを書き出す
      self.view.drawHierarchy(in: view.frame, afterScreenUpdates: false)
      // imageにコンテキストの内容を書き出す
      let GetAllViewImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
      //コンテキストを閉じる
      UIGraphicsEndImageContext()
            
      if let UseImage = GetAllViewImage.cropping(to: ( BackImageView?.GetRectForScreenshot() )!) {
         let ResizeW = UseImage.size.width * 0.65
         let ResizeH = UseImage.size.height * 0.65
         let RetruenImage = UseImage.ResizeUIImage(width: ResizeW, height: ResizeH)
         return RetruenImage?.pngData() as! NSData
      }else{
         fatalError()
      }
   }
   
   private func SaveStageUserCreated() {
      let SaveDataBase = UserCreateStageDataBase()
      let ImageData: NSData = SaveStageViewUseScreenshot()
      
      SaveDataBase.AddStage(StageArrayForContents: FillContentsArray, MaxPiceNum: PiceImageArray.count,
                            PiceArry: PiceImageArray, ImageData: ImageData)
      
      self.dismiss(animated: true, completion: {
         print("セーブ完了")
      })
   }
   
   func Play3DtouchLight()  { TapticEngine.impact.feedback(.light) }
   func Play3DtouchMedium() { TapticEngine.impact.feedback(.medium) }
   func Play3DtouchHeavy()  { TapticEngine.impact.feedback(.heavy) }
   func Play3DtouchError() { TapticEngine.notification.feedback(.error) }
   func Play3DtouchSuccess() { TapticEngine.notification.feedback(.success) }
}

