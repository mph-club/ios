//
//  ExploreFacade.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

final class ExploreFacade {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = ExploreFacade()
    private init() {}
    
    // ================
    // MARK: - Services
    // ================
    private let exploreService = ExploreService.shared
}

// ========================
// MARK: - Service Requests
// ========================
extension ExploreFacade {}
