//
//  AboutYourCarContainerViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AboutYourCarContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImg: UIImage = UIImage(named: "arrowLeft28Px")!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(CarEligibilityViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func close() {
        self.performSegue(withIdentifier: "unwindToCheckList", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
