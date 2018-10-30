//
//  PickUpAndReturnViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import MapKit

final class PickUpAndReturnViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showDeliveryLocation
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: MapView
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register table view cell
            registerTableViewCell()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var currentIndexPath: IndexPath?
    
    // MARK: Mock Data
    private var locationItems = [PickUpLocation(title: "CAR LOCATION", address: "Miami Lakes, FL, 33015", description: "Exact location provided after you book your trip.", price: nil, isSelected: false),
                                 PickUpLocation(title: "AIRPORT", address: "MIA - Miami, FL", description: "Miami International Airport.", price: "$50", isSelected: false),
                                 PickUpLocation(title: "DELIVERY", address: "Enter a delivery address", description: "Mike doesn’t deliver this car more than 10 miles.", price: "$80", isSelected: false)]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension PickUpAndReturnViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .whiteNavigationBar
        //
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
}

// ===============
// MARK: - Actions
// ===============
private extension PickUpAndReturnViewController {}

// ===============
// MARK: - Methods
// ===============
private extension PickUpAndReturnViewController {
    func registerTableViewCell() {
        tableView.register(PickUpLocationTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension PickUpAndReturnViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PickUpLocationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if (locationItems.count - 1) == indexPath.row {
            cell.setContent(.delivery, pickUpLocation: locationItems[indexPath.row])
        } else {
            cell.setContent(.default, pickUpLocation: locationItems[indexPath.row])
        }
        return cell
    }
}

// MARK: Delegate
extension PickUpAndReturnViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (locationItems.count - 1) == indexPath.row {
            if let currentIndexPath = self.currentIndexPath {
                locationItems[currentIndexPath.row].isSelected = false
            }
            //
            tableView.reloadData()
            //
            performSegue(withIdentifier: Segue.showDeliveryLocation)
        } else {
            if let currentIndexPath = self.currentIndexPath {
                locationItems[currentIndexPath.row].isSelected = false
            }
            //
            currentIndexPath = indexPath
            //
            locationItems[indexPath.row].isSelected = true
            //
            tableView.reloadData()
        }
    }
}

// ================
// MARK: - Map View
// ================

// MARK: Delegate
extension PickUpAndReturnViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // Show user location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}
