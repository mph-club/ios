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
        case presentListCar
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
            // Register Cell View
            registerTableView()
        }
    }
    
    // MARK: View
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var footerView: UIView!
    @IBOutlet private weak var headerGradientView: UIView!
    @IBOutlet private weak var customNavigationBar: UIView!
    
    // MARK: Image View
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var logoImageView: UIImageView!
    
    // MARK: Button
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searchBarButton: UIButton!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private let sections: [Section] = [.topRentals, .luxurySUVs, .luxurySedans, .exotics]
    //
    private var searchButtonPosition: CGPoint = .zero
    private var currentAlpha: CGFloat = 0.0
    
    // MARK: Lazy var
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                                UIColor.black.withAlphaComponent(0.09).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor,
                                UIColor.black.withAlphaComponent(0.80).cgColor]
        return gradientLayer
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        navigationController?.setNavigationBarHidden(true, animated: false)
        //
        customNavigationBar.alpha = currentAlpha
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // update gradient layer
        gradientLayer.frame = headerGradientView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Get search bar position
        if searchButtonPosition == .zero {
            searchButtonPosition = searchButton.convert(searchButton.bounds.origin, to: nil)
        }
        //
        if searchButton.convert(searchButton.bounds.origin, to: nil).y >= 0 {
            //
            searchBarButton.frame.origin = CGPoint(x: searchBarButton.frame.origin.x, y: searchButtonPosition.y)
            //
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: searchButtonPosition.y)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.setNavigationBarHidden(false, animated: true)
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
private extension ExploreViewController {
    @IBAction func searchTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.showMapView)
    }
    
    @IBAction func luxurayVehicleTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.presentListCar)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension ExploreViewController {
    func configView() {
        // Set header View height
        headerView.frame.size.height = view.frame.height / 2
        // add gradient layer
        headerGradientView.layer.addSublayer(gradientLayer)
    }
    
    func registerHeaderTableView() {
        tableView.register(ExploreHeaderTableViewCell.self)
    }
    
    func registerTableView() {
        tableView.register(ExploreTableViewCell.self)
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension ExploreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentSearchButtonPosition = searchButton.convert(searchButton.bounds.origin, to: nil)
        // set current alpha
        currentAlpha = (searchButtonPosition.y - currentSearchButtonPosition.y) / searchButtonPosition.y
        //
        customNavigationBar.alpha = currentAlpha
        //
        if currentSearchButtonPosition.y >= 0 {
            searchBarButton.frame.origin = CGPoint(x: searchBarButton.frame.origin.x, y: currentSearchButtonPosition.y)
            //
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: currentSearchButtonPosition.y)
        } else {
            searchBarButton.frame.origin = CGPoint(x: searchBarButton.frame.origin.x, y: 0)
            //
            titleLabel.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: 0)
        }
    }
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
        let cell: ExploreTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
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

// ===============================
// MARK: - Navigation Bar Delegate
// ===============================
extension ExploreViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
}
