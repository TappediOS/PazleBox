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

class SellectCreateStageViewController: UIViewController {
   
   let SavedStageDataBase = UserCreateStageDataBase()
   var MaxDataNumInDB: Int = 0
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
      
      InitSavedStageDataFromDB()
      InitButton()
   }
   
   private func GetPiceArrayFromPiceList(PiceList: List<PiceInfo>) -> [PiceInfo] {
      var PiceArray: [PiceInfo] = Array()
      for Pice in PiceList {
         let PiceInfomation = PiceInfo()
         PiceInfomation.PiceW = Pice.PiceW
         PiceInfomation.PiceH = Pice.PiceH
         PiceInfomation.ResX = Pice.ResX
         //転置してるから11から引く必要がある
         //ResPownはのYは下から数えるから
         PiceInfomation.ResY = 11 - Pice.ResY
         PiceInfomation.PiceName = Pice.PiceName
         PiceInfomation.PiceColor = Pice.PiceColor
         PiceArray.append(PiceInfomation)
      }
      return PiceArray
   }
   
   private func GetPiceArrayFromPiceList(FieldYList: List<FieldYInfo>) -> [[Contents]] {
      var StageArry: [[Contents]] = Array()
      for FieldY in FieldYList {
         var StageXInfo: [Contents] = Array()
         
         if FieldY.X0 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X1 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X2 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X3 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X4 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X5 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X6 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X7 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         if FieldY.X8 == 0 {
            StageXInfo.append(Contents.Out)
         }else{
            StageXInfo.append(Contents.In)
         }
         
         
         StageArry.append(StageXInfo)
      }
      return StageArry
   }
   
   private func InitSavedStageDataFromDB() {
      MaxDataNumInDB = SavedStageDataBase.GetMAXDataNumOfDataBaseDataCount()
      
      let ImageData = SavedStageDataBase.GetImageDataFromDataNumberASNSData(DataNum: 0)
      
      let PiceList = SavedStageDataBase.GetPiceFromDataNumberASList(DataNum: 0)
      PiceArray = GetPiceArrayFromPiceList(PiceList: PiceList)
      
      let FieldYList = SavedStageDataBase.GetFieldYFromDataNumberASList(DataNum: 0)
      StageArray = GetPiceArrayFromPiceList(FieldYList: FieldYList)
      
      let ImageView = UIImageView(frame: CGRect(x: 30, y: 200, width: 300, height: 450))
      
      if let data = ImageData {
         let Image = UIImage(data: data as Data)
         ImageView.image = Image
         
         view.addSubview(ImageView)
      }
      
      
      
   }
   
   private func InitButton() {
      let addNumberButton = UIButton()
      addNumberButton.backgroundColor = UIColor.blue
      addNumberButton.setTitle("+", for: UIControl.State.normal)
      let viewWidth = self.view.frame.width
      let viewHeight = self.view.frame.height
      addNumberButton.frame = CGRect(x: viewWidth/2, y: viewHeight/2, width: 160, height: 80)
      addNumberButton.center = self.view.center
      addNumberButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
      self.view.addSubview(addNumberButton)
   }
   
   @objc func didTapButton() {
      NotificationCenter.default.post(name: .StopHomeViewBGM, object: nil, userInfo: nil)
          
         //遷移先のインスタンス
         //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
          
      let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      vc2.LoadPiceArray(PiceArray: PiceArray)
      vc2.LoadStageArray(StageArray: StageArray)
         
      //これを追加して重ならないようにするiOS13以降に自動適用される。
      vc2.modalPresentationStyle = .fullScreen
      self.present(vc2, animated: true, completion: {
         print("プレゼント終わった")
         //self.ChangeHeroIDForBack()
         //self.CanPresentToSegeSellectViewFromHomeView = true
      })
   }
}
