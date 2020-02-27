//
//  UsersCommentTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/02/22.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class UsersCommentTableViewCell: UITableViewCell {
   
   
   
   @IBOutlet weak var CommentedUsersImageViewButton: UIButton!
   @IBOutlet weak var CommentedUsersNameLabel: UILabel!
   
   @IBOutlet weak var CommentedUsersCommentLabel: UILabel!
   
   @IBOutlet weak var ReportUserButton: UIButton!
   
   
   @IBAction func TapCommentedUsersImageViewButton(_ sender: Any) {
      print("userの画像がタップされました")
   }
}
