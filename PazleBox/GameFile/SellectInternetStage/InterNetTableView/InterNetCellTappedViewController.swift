//
//  InterNetCellTappedViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/21.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class InterNetCellTappedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   
   @IBOutlet weak var UsersCommentTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
}

extension InterNetCellTappedViewController {
   //セクションの数を返す
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   //テーブルの行数を返す
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 20
   }
   
   //Cellを返す
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.UsersCommentTableView.dequeueReusableCell(withIdentifier: "UsersCommentCell", for: indexPath) as? UsersCommentTableViewCell
      
      
      //cell?.UserImageView.image = UIImage(named: "person.png")
      //cell?.GameScreenshotImageView.image = UIImage(named: "23p5Red.png")
      //cell?.UserNameLabel.text = "Raid on was"
      //cell?.PlayCountLabel.text = String(2 * indexPath.row + 100 - indexPath.row)

      return cell!
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // セルの選択を解除する
      tableView.deselectRow(at: indexPath, animated: true)
      
      
   }
   
   
}
