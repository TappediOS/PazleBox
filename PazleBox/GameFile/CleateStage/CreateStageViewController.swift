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

class CleateStageViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   var OnPiceView = UIView()
   
   var RedFlame = CGRect()
   var GreenFlame = CGRect()
   var BlueFlame = CGRect()
   
   var MochUserSellectedImageView = UIImageView()
   
   var WorkPlacePiceImageArray: [PiceImageView] = Array()
   var PiceImageArray: [PiceImageView] = Array()
   
   //Piceがかぶってないかをチェックする配列
   var CheckedStage: [[Contents]] = Array()
   let CleanCheckedStage = CleanCheckStage()
   
   let photos = ["33p22Blue", "33p21Blue","43p21Blue","43p2Green","21p1Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue",
   "33p34Blue","43p35Blue","43p36Red","43p25Blue","43p31Blue",
   "33p22Blue", "33p21Blue","43p21Blue","43p2Green","21p1Red",
   "43p34Blue","43p19Blue","43p12Red","23p12Blue","43p14Blue",
   "23p11Blue", "33p7Blue","43p8Green","43p5Blue","43p41Blue",
   "32p12Blue","43p16Blue","43p12Blue","43p25Blue","43p14Blue",
   "33p3Blue", "33p23Blue","43p21Green","43p26Blue","43p28Blue"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      InitBackTileImageView()
      
      InitNotification()
      
      InitOnPiceView()
      InitRedFlame()
      InitGreenFlame()
      InitBlueFlame()
      
      CrearCheckedStage()
      
      InitMochUserSellectedImageView()
      
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
 
      collectionView.backgroundColor = UIColor.flatWhite()
      collectionView.delegate = self
      collectionView.dataSource = self
      
      collectionView.collectionViewLayout.invalidateLayout()
   }
   
   private func InitBackTileImageView() {
      let BackImageView = BackTileImageView(frame: self.view.frame)
      self.view.addSubview(BackImageView)
   }
   
   private func InitNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(PiceUpPiceImageView(notification:)), name: .PickUpPiceImageView, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(MovedPiceCatchNotification(notification:)), name: .PiceMoved, object: nil)
   }
   
   private func InitOnPiceView() {
      let Flame = CGRect(x: view.frame.width / 20, y: 150, width: view.frame.width / 25 * 23, height: 85)
      OnPiceView = UIView(frame: Flame)
      OnPiceView.backgroundColor = UIColor.flatWhite()
      OnPiceView.isHidden = true
      view.addSubview(OnPiceView)
   }
   
   private func ShowOnPiceView() {
      self.OnPiceView.isHidden = false
   }
   
   private func NotShowOnPiceView() {
      self.OnPiceView.isHidden = true
   }

   private func InitRedFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 * 9 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      RedFlame = Flame
   }
   private func InitGreenFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      GreenFlame = Flame
   }
   private func InitBlueFlame() {
      let Flame = CGRect(x: OnPiceView.frame.width / 25 * 17 + view.frame.width / 20, y: OnPiceView.frame.minY + 5, width: view.frame.width / 25 * 7, height: OnPiceView.frame.height - 5)
      BlueFlame = Flame
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
      let RightDownY = StartY - (PuzzleHight - 1)
      
      for x in LeftUpX ... RightDownX {
         for y in RightDownY ... LeftUpY {
            let ReverseY = (LeftUpY - y) + RightDownY
            if CheckedStage[ReverseY][x] == .In && PArry[y - RightDownY][x - LeftUpX] == .In {
               return true
            }
         }
      }
      return false
   }
   
   //MARK:- パズルが被ってるかを判定
   private func OverRapped(ArryNum: Int) -> Bool {
      let SentPice = PiceImageArray[ArryNum]
      let SentPuzzleInfo = SentPice.GetOfInfomation()
      
      //はみ出てたらそもそもアウト
      //if CheckdPuzzleFillSentPazzle(StageObject: SentPuzzleInfo) == false { return true }
      
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
      // 被りなし。
      return false
   }
   
   //MARK:- 通知を受け取る
   @objc func MovedPiceCatchNotification(notification: Notification) -> Void {
      print("--- Fin Move notification ---")
      CrearCheckedStage()
         
      if let userInfo = notification.userInfo {
         let SentNum = userInfo["ArryNum"] as! Int
         print("送信者番号: \(SentNum)")
         
         //Nodeを置いた場所に他のノードがいたら，元に戻ってもらう。
         if OverRapped(ArryNum: SentNum) == true {
            if PiceImageArray[SentNum].isBeforPositionIsNothing() {
               print("Before未設定なので消します")
               PiceImageArray[SentNum].removeFromSuperview()
               PiceImageArray.remove(at: SentNum)
            }else{
               PiceImageArray[SentNum].ReBackPicePosition()
            }
         }
   
         CrearCheckedStage()
      }else{ print("通知受け取ったけど、中身nilやった。") }
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
         ShowPiceImageArryInfo()
         #endif
      }else{ print("Nil きたよ") }
   }
   
   func TappedCell(CellNum: Int) {
      //画像の名前を色を除いて取得
      //例えば，23p43Blueの場合は23p43を抽出する
      let PiceName: String = photos[CellNum].pregReplace(pattern: "(Green|Blue|Red)", with: "")
      print("TapName = \(PiceName)")
      
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
}

extension CleateStageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("データベースのデータ数は,\(photos.count)")
      return photos.count
   }
   
   //cellをそれぞれ返す
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
      
      for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
      }
      
      print("セルの生成します \(indexPath.item)")
      
      let ImageView = UIImageView()
      ImageView.frame = cell.contentView.frame
      ImageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: photos[indexPath.item], ofType: "png")!)?.ResizeUIImage(width: 64, height: 64)
      
      cell.contentView.addSubview(ImageView)
      
      return cell
   }
   
   func RemoveAllFromWorkArry() {
      guard WorkPlacePiceImageArray.count != 0 else { return }
      
      //Viewからけして
      for Pice in WorkPlacePiceImageArray {
         Pice.removeFromSuperview()
      }
      //配列きれいにして
      WorkPlacePiceImageArray.removeAll()
      //OnViewもけしす
      NotShowOnPiceView()
   }
   
   // Cell が選択された場合
   // ここで値を渡して画面遷移を行なっている。
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("Cell tap \(indexPath.item)")
      
      ///もしCellタップしたときにOnViewがあったら全部消す。
      RemoveAllFromWorkArry()
      
      TappedCell(CellNum: indexPath.item)
//      if let TappedCell = collectionView.cellForItem(at: indexPath) {
//         TappedCell.content
//      }
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
       return 5
   }
}
