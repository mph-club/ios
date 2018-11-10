//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit

final class BookingSearchLoacationViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showFleetView
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
    
    // MARK: Search Bar
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var userLocation = String()
    private var timer: Timer?
    
    // MARK: Lazy Var
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
        return locationManager
    }()
    //
    private lazy var matchingItems: [MKMapItem] = []
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension BookingSearchLoacationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: Navigation
extension BookingSearchLoacationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}

// ===============
// MARK: - Actions
// ===============
private extension BookingSearchLoacationViewController {}

// ===============
// MARK: - Methods
// ===============
private extension BookingSearchLoacationViewController {
    func configView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        //
    }
    
    func registerTableView() {
        tableView.register(LocationSearchTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension BookingSearchLoacationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(matchingItems[indexPath.row].placemark)
        return cell
    }
}

// MARK: Delegate
extension BookingSearchLoacationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if not Fl show alert
        let placemark = matchingItems[indexPath.row].placemark
        let locationName = matchingItems[indexPath.row].name ?? ""
        
        if placemark.administrativeArea == "FL" {
            print("exists")
            dropPinZoomIn(placemark, locationName: locationName)
        } else {
            // pop up not allowed
            let alertView = fireAlert(title: "mph club message", message: "Sorry, currently only servicing FL")
            //
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //
            alertView.addActions([okAction])
            //
            present(alertView, animated: true, completion: nil)
        }
    }
}

// ==================
// MARK: - Search Bar
// ==================

// MARK: Delegate
extension BookingSearchLoacationViewController: UISearchBarDelegate {
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

// =================================
// MARK: - Search Controller Delegat
// =================================
extension BookingSearchLoacationViewController: UISearchControllerDelegate {}

// =================================
// MARK: - Location Manager Delegate
// =================================
extension BookingSearchLoacationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geocoder = CLGeocoder()
        // swiftlint:disable:next force_unwrapping
        geocoder.reverseGeocodeLocation(manager.location!) { response, _ in
            self.userLocation = response?.first?.areasOfInterest?.first ?? ""
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

// =================================
// MARK: - Booking Handle Map Search
// =================================
private extension BookingSearchLoacationViewController {
    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String) {
        performSegue(withIdentifier: Segue.showFleetView)
    }
    
    func saveCarLocation(_ placemark: CLPlacemark) {
        do {
            let location = try locationDetailModel.createLocation(placemark)
            print("Success! location created. \(location)")
        } catch LocationDetail.InputError.inputMissing {
            print("Input Missing")
        } catch {
            print("Something went wrong, please try again!")
        }
        
    }
    
}
