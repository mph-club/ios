//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String)
}

protocol LocationSearchTableDelegate: class {
    func displayAddressSelected(_ locationDetail: Location)
}

final class MapViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Map View
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Button
    @IBOutlet weak var doneButton: UIButton!
    
    // ==================
    // MARK: - Properties
    // ==================
    var locationDetailProperty = Location()
    var selectedPin: CLPlacemark?
    var resultSearchController: UISearchController!
    let locationManager = CLLocationManager()
    
    // MARK: Delegate
    weak var addressDelegate: LocationSearchTableDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isEnabled = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "LocationSearchTable") as? LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable?.mapView = mapView
        locationSearchTable?.handleMapSearchDelegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    @objc func getDirections() {
        addressDelegate?.displayAddressSelected(locationDetailProperty)
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
}

private extension MapViewController {
    @IBAction func dismissMapView(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    // Done btn
    @IBAction func button3(_ sender: AnyObject) {
        getDirections()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}

extension MapViewController: HandleMapSearch {
    
    func searchBarNotEmpty() {
        let searchBar = resultSearchController?.searchBar
        if !(searchBar?.text?.isEmpty ?? true) {
            doneButton.isEnabled = true
            doneButton.tintColor = UIColor.black
        }
    }

    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String) {
        searchBarNotEmpty()

        saveCarLocation(placemark)
        
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        // swiftlint:disable:next force_unwrapping
        annotation.coordinate = placemark.location!.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        // swiftlint:disable:next force_unwrapping
        let region = MKCoordinateRegion.init(center: placemark.location!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func saveCarLocation(_ placemark: CLPlacemark)  {
        
        do {
            let location = try bookinglocationDetailModel.createLocation(placemark)
            print("Success! location created. \(location)")
            locationDetailProperty = location
        } catch LocationDetail.InputError.inputMissing {
            print("Input Missing")
        } catch {
            print("Something went wrong, please try again!")
        }
    
        
    }
    
}

var locationDetailModel = BookingLocationDetail()

struct Location {
    var title: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
}

struct LocationDetail {
    
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

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
//        pinView.pinTintColor = UIColor.orange
//        pinView.canShowCallout = true
//        let smallSquare = CGSize(width: 30, height: 30)
//        var button: UIButton?
//        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
//        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
//        button?.addTarget(self, action: #selector(MapViewController.getDirections), for: .touchUpInside)
//        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }
}
