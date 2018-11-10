//
//  DeliveryLocationViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/29/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import MapKit

final class DeliveryLocationViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Sections: CaseIterable {
        case currentLocation
        case locations
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register table View cell
            registerTableView()
        }
    }
    
    // MARK: Search Bar
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var timer: Timer?
    
    // MARK: Lazy Var
    private lazy var matchingItems: [MKMapItem] = []
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension DeliveryLocationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Methods
// ===============
private extension DeliveryLocationViewController {
    func registerTableView() {
        tableView.register(CurrentLocationTableViewCell.self)
        tableView.register(LocationSearchTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data source
extension DeliveryLocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Sections.allCases[section]
        //
        switch section {
        case .currentLocation:
            return 1
        case .locations:
            return matchingItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Sections.allCases[indexPath.section]
        //
        switch section {
        case .currentLocation:
            let cell: CurrentLocationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .locations:
            let cell: LocationSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContent(matchingItems[indexPath.row].placemark)
            return cell
        }
    }
}

// MARK: Delegate
extension DeliveryLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// ==================
// MARK: - Search Bar
// ==================

// MARK: Delegate
extension DeliveryLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            //  request.region = mapView.region
            let search = MKLocalSearch(request: request)
            
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.tableView.reloadData()
            }
        }
    }
}
