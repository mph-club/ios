//
//  CompletedPayoutViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CompletedPayoutViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register table view cell
            registerTableViewCell()
        }
    }
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CompletedPayoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension CompletedPayoutViewController {}

// ===============
// MARK: - Methods
// ===============
private extension CompletedPayoutViewController {
    func registerTableViewCell() {}
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension CompletedPayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: Delegate
extension CompletedPayoutViewController: UITableViewDelegate {}

// ===========================
// MARK: - StoryboardInitiable
// ===========================
extension CompletedPayoutViewController: StoryboardInitiable {}
