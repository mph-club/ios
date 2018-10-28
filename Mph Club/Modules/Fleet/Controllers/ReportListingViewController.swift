//
//  ReportListingViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ReportListingViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showThanksReport
    }
    
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
    
    // MARK: Private
    private var currentIndexPath: IndexPath?
    
    // MARK: Mock Data
    private var reportItems = [Report(title: "Inappropriate or offensive content.", isSelected: false),
                               Report(title: "Misleading/suspicious information.", isSelected: false),
                               Report(title: "Spam", isSelected: false),
                               Report(title: "Other", isSelected: false)]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ReportListingViewController {
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
        //
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ReportListingViewController {
    @IBAction func submitTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.showThanksReport)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension ReportListingViewController {
    func registerTableView() {
        tableView.register(ReportTableViewCell.self)
        tableView.register(ReportOtherTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension ReportListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (reportItems.count - 1) == indexPath.row {
            let cell: ReportOtherTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContent(reportItems[indexPath.row])
            return cell
        } else {
            let cell: ReportTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContent(reportItems[indexPath.row])
            return cell
        }
    }
}

// MARK: Delegate
extension ReportListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (reportItems.count - 1) == indexPath.row {
            return 304
        } else {
            return 96
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentIndexPath = self.currentIndexPath {
            reportItems[currentIndexPath.row].isSelected = false
        }
        //
        currentIndexPath = indexPath
        //
        reportItems[indexPath.row].isSelected = true
        //
        tableView.reloadData()
    }
}
