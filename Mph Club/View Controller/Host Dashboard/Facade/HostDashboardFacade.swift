//
//  HostDashboardFacade.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

final class HostDashboardFacade {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = HostDashboardFacade()
    private init() {}
    
    // ================
    // MARK: - Services
    // ================
    private let hostDashboardService = HostDashboardService.shared
}

// ========================
// MARK: - Service Requests
// ========================
extension HostDashboardFacade {
    func getMyCars() -> Promise<ParentVechicles> {
        return hostDashboardService.getMyCars()
    }
    
    func updateUser() -> Promise<Void> {
        return hostDashboardService.updateUser()
    }
}
