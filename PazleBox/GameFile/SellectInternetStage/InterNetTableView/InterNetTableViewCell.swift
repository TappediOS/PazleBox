//
//  InterNetTableViewCell.swift
//  PazleBox
//
//  Created by jun on 2020/02/20.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class InterNetTableViewCell: UITableViewCell {
   
   
   @IBOutlet weak var UserImageViewButton: UIButton!
   
   @IBOutlet weak var UserNameLabel: UILabel!
   
   @IBOutlet weak var PuzzleTitleLabel: UILabel!
   
   @IBOutlet weak var RatedImageView: UIImageView!
   @IBOutlet weak var RatedLabel: UILabel!
   
   @IBOutlet weak var PlayCountImageView: UIImageView!
   @IBOutlet weak var PlayCountLabel: UILabel!
   
   @IBOutlet weak var CreatedDayLabel: UILabel!
   
   @IBOutlet weak var GameScreenshotImageView: UIImageView!
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      
      SetUpUsersStageTitlelLabel()
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   func SetUpUsersStageTitlelLabel() {
      PuzzleTitleLabel.adjustsFontSizeToFitWidth = true
      PuzzleTitleLabel.minimumScaleFactor = 0.4
   }
   
   
   @IBAction func TapUserImageViewButton(_ sender: Any) {
      //print("tableview cell の中のUserimageがタップされました")
   }
   
}
