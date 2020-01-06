//
//  UsersSettingTableViewController.swift
//  PazleBox
//
//  Created by jun on 2020/01/01.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class UsersSettingTableViewController: UITableViewController {
   
   let numOfSection = 2
   let firstNumberOfRowsInSection = 1
   let secondNumberOfRowsInSection = 2
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      SetUpView()
      
   }
   
   private func SetUpView() {
      self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1)
   }
   
   
   // MARK: - Table view data source
   // セクションの数を返します
   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      return numOfSection
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
   switch section {
      case 0:
         return firstNumberOfRowsInSection
      case 1:
         return secondNumberOfRowsInSection
      default:
         print("設定ミスってるぞ！！！")
         return 0
      }
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      print(indexPath.section)
      print(indexPath.row)
      
      switch indexPath.section {
      case 0:
         //TapUserInfo()
         print("")
      case 1:
         //TapNoAds(rowNum: indexPath.row)
         print("")
      case 2:
         //TapOther(rowNum: indexPath.row)
         print("")
      default:
         print("設定ミスってるぞ！！！")
         return
      }
      
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   
   
   
   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


   

}
