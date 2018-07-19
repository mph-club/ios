//
//  ProgressViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var checkForEligible: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button1 = UIBarButtonItem(image: UIImage(named: "close28Px"), style: .plain, target: self, action: #selector(ProgressViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToProgress(segue: UIStoryboardSegue) {}
    @IBAction func unwindToCheckList(segue: UIStoryboardSegue) {}
    
    
//    @IBAction func close(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
//    }
    
    

}