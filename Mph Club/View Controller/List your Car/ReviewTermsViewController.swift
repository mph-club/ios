//
//  ReviewTermsViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/23/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ReviewTermsViewController: UIViewController {

    @IBOutlet weak var declineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navButton1 = UIBarButtonItem(image: UIImage(named: "close28Px"), style: .plain, target: self, action: #selector(ReviewTermsViewController.close))
        navButton1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = navButton1
        
        // border to button
        declineButton.layer.borderWidth = 2
        declineButton.layer.borderColor = UIColor.black.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decline(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
