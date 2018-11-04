//
//  RenterReviewsViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class RenterReviewsViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register Cell View
            registerTableView()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension RenterReviewsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .whiteNavigationBar
        //
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// ===============
// MARK: - Methods
// ===============
private extension RenterReviewsViewController {
    func registerTableView() {
        tableView.register(CarDetailRenterTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension RenterReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailRenterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

// MARK: Delegate
extension RenterReviewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
