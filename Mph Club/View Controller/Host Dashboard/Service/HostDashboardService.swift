//
//  HostDashboardService.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

final class HostDashboardService {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = HostDashboardService()
    private init() {}
}

// ===============
// MARK: - Methods
// ===============
extension HostDashboardService {
    func getMyCars() -> Promise<ParentVechicles> {
        return Network.network
            .get(fromURL: Endpoints.HostDashboard.getMyCars)
            .then(ParentVechicles.jsonDecode)
            .recover(MphClubErrors.handle)
    }
    
    func updateUser() -> Promise<Void> {
        return Network.network
            .post(toURL: Endpoints.Authentication.updateUser, parameters: UpdateUserParameter())
            .asVoid()
            .recover(MphClubErrors.handle)
    }
}
