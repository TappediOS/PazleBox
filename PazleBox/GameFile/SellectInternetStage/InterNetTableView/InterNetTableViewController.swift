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
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.InterNetTableView.delegate = self
      self.InterNetTableView.dataSource = self
   }
}

extension InterNetTableViewController {
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
      let cell = self.InterNetTableView.dequeueReusableCell(withIdentifier: "InterNetCell", for: indexPath) as? InterNetTableViewCell
      
      
      cell?.UserImageView.image = UIImage(named: "person.png")
      cell?.GameScreenshotImageView.image = UIImage(named: "23p5Red.png")
      cell?.UserNameLabel.text = "Raid on was"
      cell?.PlayCountLabel.text = "200"

      
      return cell!
   }
}
