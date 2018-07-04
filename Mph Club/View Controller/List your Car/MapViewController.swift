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
    func dropPinZoomIn(_ placemark:MKPlacemark, locationName: String)
}

protocol LocationSearchTableDelegate {
    func displayAddressSelected(_ locationDetail: LocationDetail)
}

class MapViewController: UIViewController {
    
    var addressDelegate: LocationSearchTableDelegate?
    
 //   var carLocation = String()
    
    var locationDetailProperty = LocationDetail()
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func button3(_ sender: AnyObject) {
        getDirections()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    
    @IBAction func dismissMapView(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    
    @objc func getDirections(){
        print("Hit next")
        
        addressDelegate?.displayAddressSelected(locationDetailProperty)
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        
        // call delegate LocationSearchTableDelegate
      //  self.dismiss(animated: true, completion: nil)
        
   //     navigationController?.popToRootViewController(animated: true)
        
        // Change this and go back to List your car and using delegate or call back populate text field with address.
        
//        guard let selectedPin = selectedPin else { return }
//        let mapItem = MKMapItem(placemark: selectedPin)
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}

extension MapViewController: HandleMapSearch {
    

    func dropPinZoomIn(_ placemark: MKPlacemark, locationName: String){
        
        saveCarLocation(placemark, locationName: locationName)
        
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    
    func saveCarLocation(_ placemark: MKPlacemark, locationName: String)  {
        // Get placemark title
        // Get address
        // Get zip code
        // get suite
        // store in dictionary
        
//        print(placemark.addressDictionary!["Street"]!)
//        print(placemark.addressDictionary!["City"]!)
//        print(placemark.addressDictionary!["State"]!)
//        print(placemark.addressDictionary!["ZIP"]!)
//        print(placemark.addressDictionary!["Country"]!)
        
        var locationDetail = LocationDetail()
        locationDetail.title = locationName
        
        guard let unwrappedStreet = placemark.addressDictionary!["Street"] else { return }
        locationDetail.address = unwrappedStreet as! String
        
        
        guard let unwrappedCity = placemark.addressDictionary!["City"] else { return }
        locationDetail.city = unwrappedCity as! String
        
        guard let unwrappedState = placemark.addressDictionary!["State"] else { return }
        locationDetail.state = unwrappedState as! String
        
        guard let unwrappedZip = placemark.addressDictionary!["ZIP"] else { return }
        locationDetail.zipCode = unwrappedZip as! String
        
        guard let unwrappedCountry = placemark.addressDictionary!["Country"] else { return }
        locationDetail.country = unwrappedCountry as! String
        
        locationDetail.fullAddress = placemark.title!

        locationDetailProperty = locationDetail
        
//        for item in placemark.title! {
//            print(item)
//        }
    }
    
}

struct LocationDetail {
    var title = String()
    var address = String()
    var city = String()
    var state = String()
    var zipCode = String()
    var fullAddress = String()
    var country = String()
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
        button?.addTarget(self, action: #selector(MapViewController.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }
}
