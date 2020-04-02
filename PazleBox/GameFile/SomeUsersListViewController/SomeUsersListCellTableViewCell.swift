//
//  SomeUsersListCellTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/03/17.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SomeUsersListTableViewCell: UITableViewCell {
   
   @IBOutlet weak var UsersProfileImageView: UIImageView!
   @IBOutlet weak var UsersNameLabel: UILabel!
   
   var ListUsersUID = ""

   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      SetUpUsersProfileImageView()
   }

   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
   }
   
   func SetUpUsersProfileImageView() {
      UsersProfileImageView.layer.cornerRadius = UsersProfileImageView.frame.width / 2
      UsersProfileImageView.layer.masksToBounds = true
   }
}
