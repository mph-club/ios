//
//  AddCarParameters.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct AddOwnCarParameters: Encodable {
    let make: String?
    let model: String?
    let year: Int?
    let miles: Int?
    let transmission: String?
    let address: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let place: String?
    let viewIndex: Int?
    let id: String?
}

// =============================
// MARK: - Parameter Convertible
// =============================
extension AddOwnCarParameters: ParameterConvertible {}
