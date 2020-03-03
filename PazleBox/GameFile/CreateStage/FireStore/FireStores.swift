//
//  FireStores.swift
//  PazleBox
//
//  Created by jun on 2019/11/24.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import TapticEngine


class Firestores {
   
   var UID: String = ""
   var db: Firestore!
   
   init(uid: String) {
      print("uid = \(uid)")
      self.UID = uid
      
      db = Firestore.firestore()
   }
   
   public func AddStageData(StageArrayForContents: [[Contents]], MaxPiceNum: Int, PiceArry: [PiceImageView], ImageData: NSData?, StageTitle: String) {
      
      var docData: [String: Any] = ["addUser" : self.UID,
                                    "addDate" : Timestamp(date: Date()),
                                    "PlayCount" : 0,
                                    "ReviewAve" : 0,
                                    "ReviewCount" : 0]
      
      docData.updateValue(StageTitle, forKey: "StageTitle")
      docData.updateValue(MaxPiceNum, forKey: "MaxPiceNum")
      docData.updateValue(ImageData!, forKey: "ImageData")
      
      
      
      var PiceCount = 0
      for Pice in PiceArry {
         PiceCount += 1
         let PiceInfoN: String = "PiceInfo" + String(PiceCount)
         
         var PiceInfoArray = Array<Any>()
         PiceInfoArray.append(Pice.PiceWideNum)
         PiceInfoArray.append(Pice.PiceHeightNum)
         PiceInfoArray.append(Pice.PositionX!)
         PiceInfoArray.append(Pice.PositionY!)
         PiceInfoArray.append(Pice.selfName.pregReplace(pattern: "(Green|Blue|Red)", with: ""))
         PiceInfoArray.append(Pice.selfName.pregReplace(pattern: "[0-9]+p[0-9]+", with: ""))
         
        docData.updateValue(PiceInfoArray, forKey: PiceInfoN)
      }
      
      var FieldCount = 0
      for x in 0 ... 11 {
         FieldCount += 1
         let FieldN: String = "Field" + String(FieldCount)
         var FieldArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
         for y in 0 ... 8 {
            if StageArrayForContents[11 - x][y] == .In {
               FieldArray[y] = 1
            }
         }
         
         docData.updateValue(FieldArray, forKey: FieldN)
      }
      
//      for (key, value) in docData {
//         print("key: \(key)")
//         print("value: \(value)\n")
//      }
      
      let imageDataSize = Double(ImageData?.length ?? 0)
      print("\n-------- 保存する画像の容量 ----------")
      print(" Byte:  \(imageDataSize)")
      print("KByte:  \(imageDataSize * 0.001)")
      print("MByte:  \(imageDataSize * 0.001 * 0.001)")
      print("GByte:  \(imageDataSize * 0.001 * 0.001 * 0.001)")
      print("-------- 保存する画像の容量 ----------\n")
      
      
      // Add a new document with a generated id.
      var ref: DocumentReference? = nil
      ref = db.collection("Stages").addDocument(data: docData) { err in
         if let err = err {
            print("\nError adding document: \(err)\n")
            self.sentErrSetntStageToFireStore()
            self.sentFirebaseLogEvent(MaxPiceNum: MaxPiceNum)
         } else {
            print("\n\nDocument added with ID: \(ref!.documentID)\n")
            self.sentSuccessSentStageToFireStore()
         }
      }
   }
   
   private func sentErrSetntStageToFireStore () {
      NotificationCenter.default.post(name: .ErrSentStageToFireStore, object: nil, userInfo: nil)
   }
   
   private func sentSuccessSentStageToFireStore() {
      NotificationCenter.default.post(name: .SuccessSentStageToFireStore, object: nil, userInfo: nil)
   }
   
   private func sentFirebaseLogEvent(MaxPiceNum: Int) {
      Analytics.logEvent(AnalyticsEventShare, parameters: ["MaxPiceNum": MaxPiceNum,
                                                           "UserID": self.UID])
   }
   
  
}
