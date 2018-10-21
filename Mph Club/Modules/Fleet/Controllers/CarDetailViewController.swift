//
//  CarDetailViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Section: String, CaseIterable {
        case title
        case tripDate = "TRIP DATES"
        case location = "PICK UP AND RETURN"
        case miles = "MILES INCLUDED"
        case description
        case features = "FEATURES"
        case renterReviews = "RENTER REVIEWS"
        case ownedBy = "OWEND BY"
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register Header View
            registerHeaderTableView()
            // Register Cell View
            registerTableView()
        }
    }
    
    // MARK: View
    @IBOutlet private weak var headerView: UIView!
    
    // MARK: Image View
    @IBOutlet private weak var headerImageView: UIImageView!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Public
    var currentVehicle: Vehicle?
    
    // MARK: Overrides
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CarDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        navigationController?.setNavigationBarHidden(false, animated: true)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparent(alpha: 0.0)
        //
        UIApplication.shared.statusBarView?.backgroundColor = nil
    }
}

// ===============
// MARK: - Actions
// ===============
private extension CarDetailViewController {}

// ===============
// MARK: - Methods
// ===============
private extension CarDetailViewController {
    func registerHeaderTableView() {
        tableView.register(CarDetailHeaderTableViewCell.self)
    }
    
    func registerTableView() {
        tableView.register(CarDetailTitleTableViewCell.self)
        tableView.register(CarDetailDateTableViewCell.self)
        tableView.register(CarDetailLocationTableViewCell.self)
        tableView.register(CarDetailMilesTableViewCell.self)
        tableView.register(CarDetailDescriptionTableViewCell.self)
        tableView.register(CarDetailFeaturesTableViewCell.self)
        tableView.register(CarDetailRenterTableViewCell.self)
        tableView.register(CarDetailOwnedTitleTableViewCell.self)
        tableView.register(CarDetailOwnedItemTableViewCell.self)
    }
    
    func setContent() {
        headerImageView.image = UIImage(named: currentVehicle?.img ?? "")
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension CarDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        //
        switch section {
        case .ownedBy:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CarDetailHeaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
        header.setContent(Section.allCases[section].rawValue)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        //
        switch section {
        case .title:
            let cell: CarDetailTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContent(currentVehicle)
            return cell
        case .tripDate:
            let cell: CarDetailDateTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .location:
            let cell: CarDetailLocationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .miles:
            let cell: CarDetailMilesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .description:
            let cell: CarDetailDescriptionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .features:
            let cell: CarDetailFeaturesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .renterReviews:
            let cell: CarDetailRenterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .ownedBy:
            if indexPath.row == 0 {
                let cell: CarDetailOwnedTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            } else {
                let cell: CarDetailOwnedItemTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            }
        }
    }
}

// MARK: Delegate
extension CarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = Section.allCases[section]
        //
        switch section {
        case .title, .description:
            return 0
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Section.allCases[indexPath.section]
        //
        switch section {
        case .title:
            return 112
        case .tripDate:
            return 106
        case .location:
            return 64
        case .miles:
            return 80
        case .description:
            return UITableView.automaticDimension
        case .features:
            return 89
        case .renterReviews:
            return 225
        case .ownedBy:
            if indexPath.row == 0 {
                return 180
            } else {
                return 60
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
