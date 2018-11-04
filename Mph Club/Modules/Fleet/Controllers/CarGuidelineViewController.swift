//
//  CarGuidelineViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarGuidelineViewController: UIViewController {
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
    
    // MARK: Mock Data
    private var guidelineItems = ["A deposit will be required.",
                                  "A minimum of 3 days is required to rent this car.",
                                  "No somking"]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CarGuidelineViewController {
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
private extension CarGuidelineViewController {
    func registerTableView() {
        tableView.register(CarGuidelineTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension CarGuidelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guidelineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarGuidelineTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(guidelineItems[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension CarGuidelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
