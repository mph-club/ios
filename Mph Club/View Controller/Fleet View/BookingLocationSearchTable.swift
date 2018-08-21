//
//  LocationSearchTable.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/28/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import MapKit



class BookingLocationSearchTable: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    weak var handleMapSearchDelegate: BookingHandleMapSearch?
    var matchingItems: [MKMapItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func parseAddress(_ selectedItem: CLPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! BookingSearchCell
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark
        
        if (selectedItem.name?.contains("Airport"))! {
            cell.iconImage.image = UIImage(named: "plane")
        } else if (selectedItem.name?.contains("mph club"))! {
            cell.iconImage.image = UIImage(named: "lion-28px")
        } else {
            cell.iconImage.image = UIImage(named: "pin")
        }
        
        cell.placeLabel.text = selectedItem.name
        cell.addressLabel.text = parseAddress(selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if not Fl show alert
        
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark as CLPlacemark
        
        let selectedItem2 = matchingItems[(indexPath as NSIndexPath).row].name!

        if selectedItem.administrativeArea! == "FL" {
            print("exists")
            
            handleMapSearchDelegate?.dropPinZoomIn(selectedItem, locationName: selectedItem2)
            dismiss(animated: true, completion: nil)
        } else {
            // pop up not allowed
            self.present(fireAlert(title: "mph club message", message: "Sorry, currently only servicing FL"), animated: true)
           
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}



extension BookingLocationSearchTable: UISearchResultsUpdating {
    
   
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchController.searchBar.setShowsCancelButton(false, animated: false)
        
        guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearchRequest()
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




