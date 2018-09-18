//
//  PickUpAndReturnViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 8/10/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PickUpAndReturnViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(PickUpAndReturnViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }

}
