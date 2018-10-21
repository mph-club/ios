//
//  BookingLocationDetail.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import MapKit

struct BookingLocationDetail {
    // =============
    // MARK: - Enums
    // =============
    enum InputError: Error {
        case inputMissing
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    var title: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
}

// ===============
// MARK: - Methods
// ===============
extension BookingLocationDetail {
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
