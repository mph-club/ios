//
//  Enpoints+HostDashboard.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

extension Endpoints {
    enum HostDashboard: Endpoint {
        case getMyCars
        
        var path: String {
            switch self {
            case .getMyCars:
                return "/getMyCars"
            }
        }
        
        var url: String {
            return "\(Endpoints.APIVersion.version1.url)\(path)"
        }
    }
}

extension Endpoints {
    enum Authentication: Endpoint {
        case updateUser
        
        var path: String {
            switch self {
            case .updateUser:
                return "/updateUser"
            }
        }
        
        var url: String {
            return "\(Endpoints.APIVersion.version1.url)\(path)"
        }
    }
}
