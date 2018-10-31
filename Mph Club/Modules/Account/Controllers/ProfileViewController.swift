//
//  ProfileViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Section: String, CaseIterable {
        case renterReview = "RENTER REVIEWS"
        case verifiedInfo = "VERIFIED INFO"
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
    @IBOutlet private weak var headerView: UIView!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var titleLabelPosition = CGPoint.zero
    
    // MARK: Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Mock Data
    private var verifiedInfoItems = ["Phone number verified",
                                     "18 Reviews",
                                     "Email address verified",
                                     "Approved to drive",
                                     "Listed a car"]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWith(alpha: 0.0)
        //
        UIApplication.shared.statusBarView?.backgroundColor = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Get title label position
        if titleLabelPosition == .zero {
            titleLabelPosition = titleLabel.convert(titleLabel.frame.origin, to: nil)
        }
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
private extension ProfileViewController {
    func registerHeaderTableView() {
        tableView.register(CarDetailHeaderTableViewCell.self)
    }
    
    func registerTableView() {
        tableView.register(CarDetailRenterTableViewCell.self)
        tableView.register(VerifiedInfoTableViewCell.self)
    }
    
    func registerCollectionViewCell() {
        collectionView.registerCell(ExploreCarCollectionViewCell.self)
    }
    
    func configView() {
        headerView.frame.size.height = tableView.frame.height / 2
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            tableView.backgroundColor = .black
        } else {
            tableView.backgroundColor = .white
        }
        //
        let currentTitleLabelPosition = titleLabel.convert(titleLabel.frame.origin, to: nil)
        // set current alpha
        let currentAlpha = (titleLabelPosition.y - currentTitleLabelPosition.y) / titleLabelPosition.y
        // change navigation bar view color
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWith(alpha: currentAlpha)
        // change status bar view color
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.black.withAlphaComponent(currentAlpha)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        //
        switch section {
        case .renterReview:
            return 1
        case .verifiedInfo:
            return verifiedInfoItems.count
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
        case .renterReview:
            let cell: CarDetailRenterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .verifiedInfo:
            let cell: VerifiedInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContent(verifiedInfoItems[indexPath.row])
            return cell
        }
    }
}

// MARK: Delegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExploreCarCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

// MARK: Delegate
extension ProfileViewController: UICollectionViewDelegate {}

// MARK: Delegate Flow Layout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.9534050179, height: collectionView.frame.height)
    }
}
