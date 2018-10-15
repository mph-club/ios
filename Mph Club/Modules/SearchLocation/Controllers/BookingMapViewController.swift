//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit

protocol BookingHandleMapSearch: class {
    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String)
}

protocol BookingLocationSearchTableDelegate: class {
    func displayAddressSelected(_ locationDetail: Location)
}

final class BookingMapViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var searchBarContainer: UIView!
    
    // MARK: Search Bar
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private let locationManager = CLLocationManager()
    private var locationDetailProperty = Location()
    private var selectedPin: CLPlacemark?
    private var resultSearchController: UISearchController!
    private var userLocation = String()
    
    // MARK: Delegate
    weak var addressDelegate: BookingLocationSearchTableDelegate?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension BookingMapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //doneButton.isEnabled = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "BookingLocationSearchTable") as? BookingLocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        searchBar = resultSearchController?.searchBar
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.searchBarContainer.bounds.size.height)
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        searchBar.sizeToFit()
        searchBar.placeholder = "Enter any city, airport or address in FL"
        searchBar.delegate = self
        resultSearchController.delegate = self
        
        searchBar.setValue("Clear", forKey: "_cancelButtonText")
        
        self.searchBarContainer.addSubview((resultSearchController?.searchBar) ?? UIView())
        setBottomBorder()
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        locationSearchTable?.handleMapSearchDelegate = self
        
        //        self.resultSearchController.isActive = true
        //        self.resultSearchController.searchBar.becomeFirstResponder()
        
    }
    
    func didPresentSearchController(_ resultSearchController: UISearchController) {
        //   resultSearchController.searchBar.setShowsCancelButton(false, animated: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // resultSearchController.searchBar.setShowsCancelButton(false, animated: false)
    }
    
    private func setBottomBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 20, y: Int(self.searchBarContainer.layer.bounds.size.height)-15, width: Int(self.searchBarContainer.layer.bounds.size.width)-40, height: 1)
        self.searchBarContainer.layer.addSublayer(border)
    }
    
    @objc func getDirections() {
        self.performSegue(withIdentifier: "goToFeed", sender: self)
    }
    
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
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func goToFeed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToFeed", sender: self)
    }
}

extension BookingMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let geocoder = CLGeocoder()
        
        // swiftlint:disable:next force_unwrapping
        geocoder.reverseGeocodeLocation(manager.location!, completionHandler: { response, _ in
            
            if let unwrapped = response {
                if let address = unwrapped.first {
                    if let uw = address.areasOfInterest {
                        self.userLocation = uw[0]
                    }
                    // self.userLocation = address.areasOfInterest![0]
                }
            }
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension BookingMapViewController: BookingHandleMapSearch {
    
    func searchBarNotEmpty() {
        let searchBar = resultSearchController?.searchBar
        if !(searchBar?.text?.isEmpty ?? true) {
            // doneButton.isEnabled = true
        }
    }
    
    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String) {
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    func saveCarLocation(_ placemark: CLPlacemark) {
        
        do {
            let location = try locationDetailModel.createLocation(placemark)
            print("Success! location created. \(location)")
            locationDetailProperty = location
        } catch LocationDetail.InputError.inputMissing {
            print("Input Missing")
        } catch {
            print("Something went wrong, please try again!")
        }
        
    }
    
}

var bookinglocationDetailModel = BookingLocationDetail()

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
