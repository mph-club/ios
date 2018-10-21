//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit

final class BookingMapViewController: UIViewController {
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
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var userLocation = String()
    
    // MARK: Lazy Var
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        // Setup the Scope Bar
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    //
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
extension BookingMapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: Navigation
extension BookingMapViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FleetTableViewController {
            destinationVC.bookingMapVC = self
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension BookingMapViewController {
    @IBAction func dismissMapView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension BookingMapViewController {
    func configView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        //
        navigationItem.searchController = searchController
    }
    
    func registerTableView() {
        tableView.register(LocationSearchTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension BookingMapViewController: UITableViewDataSource {
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
extension BookingMapViewController: UITableViewDelegate {
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
            self.present(fireAlert(title: "mph club message", message: "Sorry, currently only servicing FL"), animated: true)
        }
    }
}

// ===============================
// MARK: - Search Results Updating
// ===============================
extension BookingMapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.setShowsCancelButton(false, animated: false)
        
        guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
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

// ===========================
// MARK: - Search Bar Delegate
// ===========================
extension BookingMapViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
}

// =================================
// MARK: - Search Controller Delegat
// =================================
extension BookingMapViewController: UISearchControllerDelegate {}

// =================================
// MARK: - Location Manager Delegate
// =================================
extension BookingMapViewController: CLLocationManagerDelegate {
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
private extension BookingMapViewController {
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

struct BookingLocation {
    var title: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
}

struct BookingLocationDetail {
    var title: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
    
    enum InputError: Error {
        case inputMissing
    }
    
    func createLocation(_ placemark: CLPlacemark) throws -> Location {
        if placemark.subThoroughfare == nil {
            
            guard let unwrappedCity = placemark.locality else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedState = placemark.administrativeArea else {
                throw InputError.inputMissing
            }
            
            return Location(title: "",
                            address: "",
                            city: unwrappedCity,
                            state: unwrappedState,
                            zipCode: "",
                            country: "")
            
        } else {
            
            guard let unwrappedCity = placemark.locality else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedState = placemark.administrativeArea else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedSubThoroughfare = placemark.subThoroughfare else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedThoroughfare = placemark.thoroughfare else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedZip = placemark.postalCode else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedPlace = placemark.name else {
                throw InputError.inputMissing
            }
            
            guard let unwrappedCountry = placemark.country else {
                throw InputError.inputMissing
            }
            
            return Location(title: unwrappedPlace,
                            address: unwrappedSubThoroughfare + " " + unwrappedThoroughfare,
                            city: unwrappedCity,
                            state: unwrappedState,
                            zipCode: unwrappedZip,
                            country: unwrappedCountry)
            
        }
    }
}
