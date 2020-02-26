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
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   @IBAction func TapUsersImageButton(_ sender: Any) {
      print("コメントしたユーザのプロフィール画像がタップされた")
   }
   
   
   @IBAction func TapUserReportButton(_ sender: Any) {
      print("コメントしたユーザの報告ボタンがタップされた")
   }
   
   
   
}
