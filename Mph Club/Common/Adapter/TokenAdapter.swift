//
//  TokenAdapter.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import Alamofire

final class TokenAdapter {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = TokenAdapter()
    private init() {}
}

// =======================
// MARK: - Request Adapter
// =======================
extension TokenAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var tempURLRequest = urlRequest
        tempURLRequest.addValue(Constant.accessToken, forHTTPHeaderField: "Authorization")
        
        return tempURLRequest
    }
}
