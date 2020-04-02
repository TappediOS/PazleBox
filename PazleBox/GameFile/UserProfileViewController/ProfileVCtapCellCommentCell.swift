//
//  ProfileVCtapCellCommentCell.swift
//  PazleBox
//
//  Created by jun on 2020/02/26.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class ProfileVCtapCellCommentCell: UITableViewCell {
   
   @IBOutlet weak var UsersImageButton: UIButton!
   @IBOutlet weak var UserNameLabel: UILabel!
   @IBOutlet weak var UsersComments: UILabel!
   
   
   @IBOutlet weak var UsersCommentReportButton: UIButton!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      SetUpUsersProfileImage()
      SetUpCommentedUsersNameLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   func SetUpCommentedUsersNameLabel() {
      UserNameLabel.adjustsFontSizeToFitWidth = true
      UserNameLabel.minimumScaleFactor = 0.4
   }
   
   func SetUpUsersProfileImage() {
      UsersImageButton.layer.cornerRadius = UsersImageButton.frame.width / 2
      UsersImageButton.layer.masksToBounds = true
   }

   @IBAction func TapUsersImageButton(_ sender: Any) {
      //print("コメントしたユーザのプロフィール画像がタップされた")
   }
   
   
   @IBAction func TapUserReportButton(_ sender: Any) {
      //print("コメントしたユーザの報告ボタンがタップされた")
   }
}
