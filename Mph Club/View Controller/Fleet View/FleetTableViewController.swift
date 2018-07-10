//
//  FleetTableViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

struct Car {
    let carImage: String
    let carTitle: String
}

class FleetTableViewController: UITableViewController {

  //  var newBackButton = UIBarButtonItem()
    
    var carList = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.navigationItem.hidesBackButton = true
//        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
//
//        newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: #selector(FleetTableViewController.back(sender:)))
//        self.tabBarController?.navigationItem.leftBarButtonItem = newBackButton
        
       
        carList.append(Car(carImage: "Mercedes-Maybach-6-Cabriolet-HP", carTitle: "Test"))
        carList.append(Car(carImage: "Mercedes-Maybach-6-Cabriolet-HP", carTitle: "Test"))
        carList.append(Car(carImage: "Mercedes-Maybach-6-Cabriolet-HP", carTitle: "Test"))
        
        tableView.estimatedRowHeight = 363
        tableView.rowHeight = UITableViewAutomaticDimension
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.tabBarController?.navigationItem.hidesBackButton = false
          self.navigationController?.setNavigationBarHidden(false, animated: animated)


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        newBackButton.isEnabled = false
//        newBackButton.tintColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FleetTableViewCell

        // Configure the cell...
        
        cell.carImage.image = UIImage(named: carList[indexPath.row].carImage)
        cell.titleLabel.text = carList[indexPath.row].carTitle
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
