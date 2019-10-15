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
   
   var PiceArray: [PiceInfo] = Array()
   var StageArray: [[Contents]] = Array()
   
   @IBOutlet weak var StageCollectionView: UICollectionView!
   //こいつがCollecti on viewのレイアウトを決めている
   let sectionInsets = UIEdgeInsets(top: 10.0, left: 6.0, bottom: 5.0, right: 6.0)
   let itemsPerRow: CGFloat = 3 //Cellを横に何個入れるか
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
      
      self.StageCollectionView.delegate = self
      self.StageCollectionView.dataSource = self
   }
   
   
   /// Collection ViewのCellがタップされた後にステージ情報を取得する関数
   /// - Parameter CellNum: セル番号
   func LoadStageInfomation(CellNum: Int) {
      let PiceList = SavedStageDataBase.GetPiceFromDataNumberASList(DataNum: CellNum)
      let FieldYList = SavedStageDataBase.GetFieldYFromDataNumberASList(DataNum: CellNum)
      //EXファイルに存在している
      PiceArray = GetPiceArrayFromPiceList(PiceList: PiceList)
      StageArray = GetPiceArrayFromPiceList(FieldYList: FieldYList)
   }
   
   
   /// GameVCをプレゼントする関数
   func PresentGameViewController() {
      let GameVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      GameVC.LoadPiceArray(PiceArray: PiceArray)
      GameVC.LoadStageArray(StageArray: StageArray)
      GameVC.modalPresentationStyle = .fullScreen
      self.present(GameVC, animated: true, completion: {
         print("プレゼント終わった")
      })
   }
}

