//
//  UserProfileViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/24.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   
   @IBOutlet weak var UserProfileTableView: UITableView!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      UserProfileTableView.delegate = self
      UserProfileTableView.dataSource = self
   }
}

extension UserProfileViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 20
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersSgageCell")! as UITableViewCell
      
      return cell
   }
   
   //ヘッダーの高さを設定
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return 200
   }
   
   //ヘッダーに使うUIViewを返す
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
      let view = UIView()
      view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
      if #available(iOS 13.0, *) {
         view.backgroundColor = .secondarySystemBackground
      } else {
         // Fallback on earlier versions
      }
      let headerLabel = UILabel()
      headerLabel.frame =  CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 50)
      headerLabel.text = "This is Headers label"
      headerLabel.textColor = UIColor.white
      headerLabel.textAlignment = NSTextAlignment.center
      view.addSubview(headerLabel)
      return view
   }
}
