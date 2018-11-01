//
//  ChangeYourEmailViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ChangeYourEmailViewController: UIViewController {}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ChangeYourEmailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
