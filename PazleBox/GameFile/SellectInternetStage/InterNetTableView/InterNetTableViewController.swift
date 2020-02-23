//
//  InterNetTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/02/20.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class InterNetTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var InterNetTableView: UITableView!
   var RefleshControl = UIRefreshControl()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.InterNetTableView.delegate = self
      self.InterNetTableView.dataSource = self
      
      SetUpRefleshControl()
   }
   
   func SetUpRefleshControl() {
      self.InterNetTableView.refreshControl = self.RefleshControl
      self.RefleshControl.addTarget(self, action: #selector(self.ReloadDataFromFireStore(sender:)), for: .valueChanged)
   }
   
   @objc func ReloadDataFromFireStore(sender: UIRefreshControl) {
      RefleshControl.endRefreshing()
   }
}

