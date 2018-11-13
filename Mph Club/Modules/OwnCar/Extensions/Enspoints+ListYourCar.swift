//
//  Enspoints+ListYourCar.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

extension Endpoints {
    enum ListYourCar: Endpoint {
        case addOwnCar
        case addPhoto
        
        var path: String {
            switch self {
            case .addOwnCar:
                return "/listCar"
            case .addPhoto:
                return "/uploadPhoto"
            }
        }
        
        var url: String {
            return "\(Endpoints.APIVersion.version1.url)\(path)"
        }    }
}
