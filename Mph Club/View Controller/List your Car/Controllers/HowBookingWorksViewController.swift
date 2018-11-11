//
//  HowBookingWorksViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class HowBookingWorksViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setBottomBorder()
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            print("reach bottom")
        }
        
        if (scrollView.contentOffset.y <= 0){
            print("reach top")
            self.removeBottomBorder()
        }
        
        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
        }
    }
    
    
    func setBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    
    @IBAction func unwindToHowBookingWorks(segue: UIStoryboardSegue) {}

}
