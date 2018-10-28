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
    
    private enum Segue: String {
        case showCalendar
        case showPickUpAndReturn
        case showCarFeatures
        case showCarGuideline
        case showRenterReviews
        case showOwnedProfile
        case showReportAListing
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
    
    // MARK: Collection View
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            // Register collection view cell
            registerCollectionViewCell()
        }
    }
    
    // MARK: View
    @IBOutlet private weak var customNavigationBar: UIView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var endOfHeaderView: UIView!
    
    // MARK: Image View
    @IBOutlet private weak var headerImageView: UIImageView!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Public
    var currentVehicle: Vehicle?
    
    // MARK: Private
    private var currentAlpha: CGFloat = 0.0
    private let ownedByItems = ["Guidelines", "Report this listing"]
    
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
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWithWhiteTint
        //
        UIApplication.shared.statusBarView?.backgroundColor = nil
        //
        customNavigationBar.alpha = currentAlpha
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        if endOfHeaderView.convert(endOfHeaderView.bounds.origin, to: nil).y >= 0 {
            //
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: headerView.bounds.height)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
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
    
    func registerCollectionViewCell() {
        collectionView.registerCell(ExploreCarCollectionViewCell.self)
    }
    
    func setContent() {
        headerImageView.image = UIImage(named: currentVehicle?.img ?? "")
        //
        titleLabel.text = currentVehicle?.title
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension CarDetailViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endOfHeaderViewPosition = endOfHeaderView.convert(endOfHeaderView.bounds.origin, to: nil)
        //
        currentAlpha = (headerView.bounds.height - endOfHeaderViewPosition.y) / headerView.bounds.height
        //
        customNavigationBar.alpha = currentAlpha
        //
        if endOfHeaderViewPosition.y >= 0 {
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: endOfHeaderViewPosition.y)
        } else {
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: 0)
        }
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
            cell.delegate = self
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
                cell.setContent(ownedByItems[indexPath.row - 1])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        //
        switch section {
        case .tripDate:
            performSegue(withIdentifier: Segue.showCalendar)
        case .location:
            performSegue(withIdentifier: Segue.showPickUpAndReturn)
        case .renterReviews:
            performSegue(withIdentifier: Segue.showRenterReviews)
        case .ownedBy:
            if indexPath.row == 0 {
                performSegue(withIdentifier: Segue.showOwnedProfile)
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: Segue.showCarGuideline)
            } else {
                performSegue(withIdentifier: Segue.showReportAListing)
            }
        default:
            break
        }
    }
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension CarDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExploreCarCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

// MARK: Delegate
extension CarDetailViewController: UICollectionViewDelegate {}

// MARK: Delegate Flow Layout
extension CarDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.9534050179, height: collectionView.frame.height)
    }
}

// ====================================================
// MARK: - Car Detail Features Table View Cell Delegate
// ====================================================
extension CarDetailViewController: CarDetailFeaturesTableViewCellDelegate {
    func showAllFeature(_ cell: CarDetailFeaturesTableViewCell) {
        performSegue(withIdentifier: Segue.showCarFeatures)
    }
}
