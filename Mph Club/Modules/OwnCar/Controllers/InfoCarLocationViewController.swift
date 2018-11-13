//
//  InfoCarLocationViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class InfoCarLocationViewController: UIViewController {}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension InfoCarLocationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWithBlackTint
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWithWhiteTint
    }
}
