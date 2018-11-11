//
//  ListingTabVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ListingTabVC: UIViewController {
    
    @IBOutlet weak var addCarBarButton: UIBarButtonItem!
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var firstTimeView: UIView!
    @IBOutlet weak var hostBoardView: UIView!
    
    
    @IBOutlet weak var listingTableView: UIView!
    @IBOutlet weak var requestView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check if cars have been listed
        // if YES change view
        if true {
             self.firstTimeView.isHidden = true
             self.hostBoardView.isHidden = false
            
             self.listingTableView.isHidden = false
             self.requestView.isHidden = true
        } else {
             self.firstTimeView.isHidden = false
             self.hostBoardView.isHidden = true
        }
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func addOwnCar(_ sender: UIBarButtonItem) {
        Constant.viewIndex = 0
        Constant.carKey = ""
        performSegue(withIdentifier: "showAddCar", sender: nil)
    }

}


extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
