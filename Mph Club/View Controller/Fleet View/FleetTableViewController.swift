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
        tableView.rowHeight = UITableView.automaticDimension
    
        addShadowToTripBox()
        customBackButton()
        
    }
    
    func customBackButton() {
         let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(FleetTableViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
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
        self.navigationController?.navigationBar.shadowImage = UIColor.gray.as1ptImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
        if self.isMovingFromParent {
            bookingMapVC.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FleetTableViewCell
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
            self.hidePreferenceBox()
        } else {
            self.unHidePreferenceBox()
        }
    }
    
    func hidePreferenceBox() {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            if self.tripPreferenceBox.frame.maxY > 149.5 {
                
            }
            
        }, completion: nil)
      
        UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.tripPreferenceBox.frame = CGRect(x: 15, y: 40, width: self.view.frame.width-25, height: 90)
            self.tableView.frame = CGRect(x: 15, y: 150, width: self.view.frame.width-25, height: self.view.frame.height-150)
        }, completion: nil)
    }
    
    
    func unHidePreferenceBox() {
        UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.tripPreferenceBox.frame = CGRect(x: 15, y: 105, width: self.view.frame.width-25, height: 90)
            self.tableView.frame = CGRect(x: 15, y: 210, width: self.view.frame.width-25, height: self.view.frame.height-210)
        }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "carDetailView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.vehicle = carList[indexPath.row]
            }
        
        }
    }
    
    
     @IBAction func unwindToFleet(segue: UIStoryboardSegue) {}


}
