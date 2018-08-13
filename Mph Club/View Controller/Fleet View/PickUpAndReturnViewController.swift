//
//  PickUpAndReturnViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 8/10/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PickUpAndReturnViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.backArrowIcon), style: .plain, target: self, action: #selector(PickUpAndReturnViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }

}
