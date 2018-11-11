//
//  Vehicles.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct Vehicles: Decodable {
    // =============
    // MARK: - Enums
    // =============
    enum VehiclesStatus: String, Decodable {
        case pending = "PENDING"
        case approved = "APPROVED"
        case denied = "DENIED"
        case none = ""
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    let id: String
    let make: String?
    let model: String?
    let year: Int?
    let trim: String?
    let color: String?
    let doors: Int?
    let seats: Int?
    let vin: String?
    let description: String?
    let dayMax: Int?
    let dayMin: Int?
    let vehicleType: String?
    let miles: Int?
    let licensePlate: String?
    let status: VehiclesStatus
    let photos: [URL]?
    let createdTime: String?
    let updatedBy: String?
    let updatedTime: String?
    let user: String?
    let isPublished: Bool?
    let address: String?
    let city: String?
    let state: String?
    let viewIndex: Int?
    let place: String?
    let zipCode: String?
    let transmission: String?
}
