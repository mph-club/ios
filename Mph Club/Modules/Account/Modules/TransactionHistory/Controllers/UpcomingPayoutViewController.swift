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
            // Register Header View
            registerHeaderTableView()
            // Register Cell View
            registerTableViewCell()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Mock Data
    private let transactions = [Transaction(fullName: "Mike L.",
                                            price: "$966.00",
                                            carName: "Maserati Granturism",
                                            year: "2016",
                                            payoutStatus: .faild,
                                            payoutAccount: "(******2329)"),
                                Transaction(fullName: "Ciara S.",
                                            price: "$1,345.00",
                                            carName: "Maserati Granturism",
                                            year: "2016",
                                            payoutStatus: .inProgress,
                                            payoutAccount: "(******2329)"),
                                Transaction(fullName: "Ciara S.",
                                            price: "$1,345.00",
                                            carName: "Maserati Granturism",
                                            year: "2016",
                                            payoutStatus: .inProgress,
                                            payoutAccount: "(******2329)")]
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
    func registerHeaderTableView() {
        tableView.register(TransactionHistoryHeaderTableViewCell.self)
    }
    
    func registerTableViewCell() {
        tableView.register(TransactionHistoryTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data source
extension UpcomingPayoutViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TransactionHistoryHeaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionHistoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(transactions[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension UpcomingPayoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// ===========================
// MARK: - StoryboardInitiable
// ===========================
extension UpcomingPayoutViewController: StoryboardInitiable {}
