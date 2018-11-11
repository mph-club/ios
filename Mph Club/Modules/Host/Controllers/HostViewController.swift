//
//  HostViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class HostViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Custom Segment View
    @IBOutlet private weak var segmentView: CustomSegmentView! {
        didSet {
            //
            segmentView.items = ["REQUEST", "VEHICLES", "HISTORY"]
            //
            segmentView.selectedIndex = 1
        }
    }
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension HostViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension HostViewController {
    @IBAction func addOwnCar(_ sender: UIBarButtonItem) {
        Constant.viewIndex = 0
        Constant.carKey = ""
        performSegue(withIdentifier: "showAddCar", sender: nil)
    }
}
