//
//  ExInterNetCellTappedViewControllerGetRawData.swift
//  PazleBox
//
//  Created by jun on 2020/03/26.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage


extension InterNetCellTappedViewController {

   /// ドキュメントからデータを読み込み配列として返す関数
   /// - Parameter document: forぶんでDocを回したときに呼び出す。
   func GetCommentRaw(document: DocumentSnapshot) -> ([String: Any]) {
      var CommentData: [String: Any] =  ["documentID": document.documentID]
      
      if let value = document["AddDate"] as? Timestamp {
         let date: Date = value.dateValue()
         
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: .current)!
         let dataAsString: String = formatter.string(from: date)
         //print(dataAsString)
         //NOTE:- String型で保存されていることに注意！
         CommentData.updateValue((dataAsString), forKey: "AddDate")
      }
        
      if let value = document["CommentBody"] as? String {
         CommentData.updateValue(value, forKey: "CommentBody")
      }
        
      if let value = document["CommentID"] as? String {
         CommentData.updateValue(value, forKey: "ReviewAve")
      }
        
      if let value = document["CommentUserUID"] as? String {
         CommentData.updateValue(value, forKey: "CommentUserUID")
      }
        
      if let value = document["CommentUsersProfileURL"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersProfileURL")
      }
        
      if let value = document["isPublished"] as? Bool {
         CommentData.updateValue(value, forKey: "isPublished")
      }
        
      if let value = document["CommentUsersName"] as? String {
         CommentData.updateValue(value, forKey: "CommentUsersName")
      }
        
      return CommentData
   }
}
