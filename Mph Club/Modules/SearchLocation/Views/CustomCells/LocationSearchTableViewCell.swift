//
//  LocationSearchTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import MapKit

final class LocationSearchTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var iconImage: UIImageView!
    
    // MARK: Label
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension LocationSearchTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension LocationSearchTableViewCell {
    func setContent(_ placemark: MKPlacemark) {
        if placemark.name?.contains("Airport") ?? false {
            iconImage.image = UIImage(named: "plane")
        } else if placemark.name?.contains("mph club") ?? false {
            iconImage.image = UIImage(named: "lion-28px")
        } else {
            iconImage.image = UIImage(named: "pin")
        }
        
        placeLabel.text = placemark.name
        addressLabel.text = parseAddress(placemark)
    }
    
    private func parseAddress(_ selectedItem: CLPlacemark) -> String {
        
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
            format: "%@%@%@%@%@%@%@",
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
}

// =====================
// MARK: - Reusable View
// =====================
extension LocationSearchTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension LocationSearchTableViewCell: NibLoadableView {}
