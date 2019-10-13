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
   private let sectionInsets = UIEdgeInsets(top: 10.0, left: 6.0, bottom: 5.0, right: 6.0)
   private let itemsPerRow: CGFloat = 3
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
      
      self.StageCollectionView.delegate = self
      self.StageCollectionView.dataSource = self
   }
   
   private func LoadStageInfomation(CellNum: Int) {
      let PiceList = SavedStageDataBase.GetPiceFromDataNumberASList(DataNum: CellNum)
      let FieldYList = SavedStageDataBase.GetFieldYFromDataNumberASList(DataNum: CellNum)
      //EXファイルに存在している
      PiceArray = GetPiceArrayFromPiceList(PiceList: PiceList)
      StageArray = GetPiceArrayFromPiceList(FieldYList: FieldYList)
   }
   
   private func PresentGameViewController() {
      let GameVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersGameView") as! UsersGameViewController

      GameVC.LoadPiceArray(PiceArray: PiceArray)
      GameVC.LoadStageArray(StageArray: StageArray)
      GameVC.modalPresentationStyle = .fullScreen
      self.present(GameVC, animated: true, completion: {
         print("プレゼント終わった")
      })
   }
}

