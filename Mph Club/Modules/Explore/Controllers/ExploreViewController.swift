//
//  ExploreViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ExploreViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showMapView
    }
    
    
    private enum Section: String {
        case topRentals = "Top rentals"
        case luxurySUVs = "Luxury SUVs"
        case luxurySedans = "Luxury Sedans"
        case exotics = "Exotics"
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register Header View
            registerHeaderTableView()
        }
    }
    
    // MARK: View
    @IBOutlet private weak var headerView: UIView!
    
    // MARK: Image View
    @IBOutlet private weak var headerImageView: UIImageView!
    
    // MARK: Button
    @IBOutlet private weak var searchButton: UIButton!
    
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private let sections: [Section] = [.topRentals, .luxurySUVs, .luxurySedans, .exotics]
    
    // MARK: Overrides
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ExploreViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
    }
}

// MARK: - Navigation
extension ExploreViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ExploreViewController {}

// ===============
// MARK: - Methods
// ===============
private extension ExploreViewController {
    func configView() {
        // Hidden navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Set header View height
        headerView.frame.size.height = view.frame.height / 2
    }
    
    func registerHeaderTableView() {
        tableView.register(ExploreHeaderTableViewCell.self)
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension ExploreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension ExploreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: ExploreHeaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
        header.setContent(sections[section].rawValue)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: Delegate
extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
