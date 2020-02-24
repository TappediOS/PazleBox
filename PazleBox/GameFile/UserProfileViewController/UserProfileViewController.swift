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
}
