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


struct Vehicle {
    var title: String
    var img: String
    var price: Int
    var trips: Int
    var miles: Int
}

class FleetTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  //  var newBackButton = UIBarButtonItem()
    
    var carList = [Vehicle]()
    @IBOutlet weak var tripPreferenceBox: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var bookingMapVC: BookingMapViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carList.append(Vehicle(title: "Porsche Panamera 2017", img: "panamera", price: 240, trips: 10, miles: 11))
        carList.append(Vehicle(title: "Maserati Granturismo 2016", img: "maserati", price: 140, trips: 8, miles: 4))
        carList.append(Vehicle(title: "Mercedes-Benz G-Class 2014", img: "gwagon", price: 440, trips: 5, miles: 6))
        
        tableView.estimatedRowHeight = 363
        tableView.rowHeight = UITableViewAutomaticDimension
    
        addShadowToTripBox()
        customBackButton()
        
    }
    
    func customBackButton() {
         let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(FleetTableViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        self.navButtonBorder(isOn: true)
    }
    
    func navButtonBorder(isOn: Bool) {
//        if let navigationController = self.navigationController {
//
//            // Set the color you want here
//            let navigationBar = navigationController.navigationBar
//
//
//            if isOn == true {
//                let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height - 0.25, width: navigationBar.frame.size.width, height: 0.3))
//                navBorder.backgroundColor = UIColor.lightGray
//                navBorder.isOpaque = true
//                self.navigationController?.navigationBar.addSubview(navBorder)
//            } else {
//                let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height - 0.25, width: navigationBar.frame.size.width, height: 0))
//                navBorder.backgroundColor = UIColor.clear
//                navBorder.isOpaque = false
//                self.navigationController?.navigationBar.addSubview(navBorder)
//
//
//            }
//
//
//        }
     
    }
    
    @objc func close() {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    
    func addShadowToTripBox() {
        tripPreferenceBox.layer.shadowColor = UIColor.gray.cgColor
        tripPreferenceBox.layer.shadowOpacity = 0.5
        tripPreferenceBox.layer.shadowOffset = CGSize.zero
        tripPreferenceBox.layer.shadowRadius = 5
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navButtonBorder(isOn: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navButtonBorder(isOn: false)
        if self.isMovingFromParentViewController {
            bookingMapVC.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carList.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FleetTableViewCell

        // Configure the cell...
        
        
        cell.carImage.image = UIImage(named: carList[indexPath.row].img)
        cell.titleLabel.text = carList[indexPath.row].title
        cell.priceLabel.text = "\(carList[indexPath.row].price)"
        cell.tripLabel.text = "\(carList[indexPath.row].trips) Trips"
        cell.milesLabel.text = "\(carList[indexPath.row].miles) mil"
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
    
    var num = Int()
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
              //  self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
                
                
                // Move trip preference box up
                if self.tripPreferenceBox.frame.maxY > 149.5 {
//                    if velocity > 400.0 {
//                        self.num += -10
//                    } else if velocity > 200.0 {
//                        self.num += -3
//                    } else {
//                        self.num += -3
//                    }
                    //   print("Moving down: \(scrollView.panGestureRecognizer.velocity(in: tableView))")
                    
                    
                    
                    
                 //   self.tripPreferenceBox.transform = CGAffineTransform(translationX: 0, y: CGFloat(self.num))
                    
                    
                }
                
                
                
              //  self.tableView.frame = CGRect(x: 15, y: 40, width: 360, height: 400)
                
                
            }, completion: nil)
            
            
            
            UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.tripPreferenceBox.frame = CGRect(x: 15, y: 40, width: self.view.frame.width-25, height: 90)
                self.tableView.frame = CGRect(x: 15, y: 150, width: self.view.frame.width-25, height: self.view.frame.height-150)
            }, completion: nil)
            
            
            
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                //self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.tripPreferenceBox.frame = CGRect(x: 15, y: 105, width: self.view.frame.width-25, height: 90)
                self.tableView.frame = CGRect(x: 15, y: 210, width: self.view.frame.width-25, height: self.view.frame.height-210)
            }, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "carDetailView" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.vehicle = carList[indexPath.row]
            }
            
//            if segue.destination is DetailViewController {
//
//
//            }
        }
    }
    
    
     @IBAction func unwindToFleet(segue: UIStoryboardSegue) {}

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
