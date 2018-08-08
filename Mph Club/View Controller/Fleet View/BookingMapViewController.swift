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

protocol BookingLocationSearchTableDelegate {
    func displayAddressSelected(_ locationDetail: Location)
}

class BookingMapViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var addressDelegate: BookingLocationSearchTableDelegate?
    var locationDetailProperty = Location()
    var selectedPin: CLPlacemark?
    var resultSearchController: UISearchController!
    let locationManager = CLLocationManager()
    var userLocation = String()
    @IBOutlet weak var searchBar: UISearchBar!

    
    @IBOutlet weak var searchBarContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //doneButton.isEnabled = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
       
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "BookingLocationSearchTable") as! BookingLocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        searchBar = resultSearchController!.searchBar
        searchBar.frame = CGRect(x: 0, y: 0, width: (navigationController?.view.bounds.size.width)!, height: self.searchBarContainer.bounds.size.height)
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        searchBar.sizeToFit()
        searchBar.placeholder = "Enter any city, airport or address in FL"
        searchBar.delegate = self
        resultSearchController.delegate = self
   
        searchBar.setValue("Clear", forKey:"_cancelButtonText")
        
        self.searchBarContainer.addSubview((resultSearchController?.searchBar)!)
        setBottomBorder()
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        locationSearchTable.handleMapSearchDelegate = self
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    @IBAction func dismissMapView(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func goToFeed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToFeed", sender: self)
    }
    
    @objc func getDirections(){
        self.performSegue(withIdentifier: "goToFeed", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FleetTableViewController {
            destinationVC.bookingMapVC = self
        }
    }
    
}

extension BookingMapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(manager.location!, completionHandler: { response , error in
      
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
        let searchBar = resultSearchController!.searchBar
        if searchBar.text != "" {
           // doneButton.isEnabled = true
        }
    }
    
    func dropPinZoomIn(_ placemark: CLPlacemark, locationName: String){
        
        performSegue(withIdentifier: "goToFeed", sender: nil)
//        searchBarNotEmpty()
//
//        saveCarLocation(placemark)
//
//        // cache the pin
//        selectedPin = placemark
//        // clear existing pins
//        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = (placemark.location?.coordinate)!
//        annotation.title = placemark.name
//
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//            annotation.subtitle = "\(city) \(state)"
//        }
//
//        mapView.addAnnotation(annotation)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegionMake((placemark.location?.coordinate)!, span)
//        mapView.setRegion(region, animated: true)
    }
    
    
    func saveCarLocation(_ placemark: CLPlacemark)  {
        
        do {
            let location = try locationDetailModel.createLocation(placemark)
            print("Success! location created. \(location)")
            locationDetailProperty = location
        } catch LocationDetail.InputError.InputMissing {
            print("Input Missing")
        } catch {
            print("Something went wrong, please try again!")
        }
        
        
    }
    
}

var BookinglocationDetailModel = BookingLocationDetail()

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
        case InputMissing
    }
    
    func createLocation(_ placemark: CLPlacemark) throws -> Location {
        
        
        if placemark.subThoroughfare == nil {
            
            guard let unwrappedCity = placemark.locality else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedState = placemark.administrativeArea else {
                throw InputError.InputMissing
            }
            
            
            return Location(title: "",
                            address: "",
                            city: unwrappedCity,
                            state: unwrappedState,
                            zipCode: "",
                            country: "")
            
            
        } else {
            
            guard let unwrappedCity = placemark.locality else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedState = placemark.administrativeArea else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedSubThoroughfare = placemark.subThoroughfare else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedThoroughfare = placemark.thoroughfare else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedZip = placemark.postalCode else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedPlace = placemark.name else {
                throw InputError.InputMissing
            }
            
            guard let unwrappedCountry = placemark.country else {
                throw InputError.InputMissing
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

//extension BookingMapViewController : MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
//
//        guard !(annotation is MKUserLocation) else { return nil }
//
//        let reuseId = "pin"
//        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
//
//        //        pinView.pinTintColor = UIColor.orange
//        //        pinView.canShowCallout = true
//        //        let smallSquare = CGSize(width: 30, height: 30)
//        //        var button: UIButton?
//        //        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
//        //        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
//        //        button?.addTarget(self, action: #selector(MapViewController.getDirections), for: .touchUpInside)
//        //        pinView.leftCalloutAccessoryView = button
//
//        return pinView
//    }
//}
