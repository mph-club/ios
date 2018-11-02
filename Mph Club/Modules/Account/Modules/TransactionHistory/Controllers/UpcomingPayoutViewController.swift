//
//  UpcomingPayoutViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class UpcomingPayoutViewController: UIViewController {
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
extension UpcomingPayoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension UpcomingPayoutViewController {}

// ===============
// MARK: - Methods
// ===============
private extension UpcomingPayoutViewController {
    func registerTableViewCell() {}
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data source
extension UpcomingPayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: Delegate
extension UpcomingPayoutViewController: UITableViewDelegate {}

// ===========================
// MARK: - StoryboardInitiable
// ===========================
extension UpcomingPayoutViewController: StoryboardInitiable {}
