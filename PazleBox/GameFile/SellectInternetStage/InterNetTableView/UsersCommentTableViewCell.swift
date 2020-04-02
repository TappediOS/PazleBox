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
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      SetUpCommentedUsersProfileImage()
      SetUpCommentedUsersNameLabel()
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   func SetUpCommentedUsersProfileImage() {
      CommentedUsersImageViewButton.layer.cornerRadius = self.CommentedUsersImageViewButton.frame.width / 2
      CommentedUsersImageViewButton.layer.masksToBounds = true
   }
   
   func SetUpCommentedUsersNameLabel() {
      CommentedUsersNameLabel.adjustsFontSizeToFitWidth = true
      CommentedUsersNameLabel.minimumScaleFactor = 0.4
   }
   
   @IBAction func TapCommentedUsersImageViewButton(_ sender: Any) {
      //print("userの画像がタップされました")
   }
}
