//
//  NetworkConfigurator.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire
import Reachability

final class NetworkConfigurator: NetworkProtocol {
    private init() {}
    
    // ==========================
    // MARK: - Variables
    // ==========================
    static let shared = NetworkConfigurator()
    
    var network: HttpGatewayProtocol {
        return HttpGateway(baseUrl: baseUrl,
                           header: header,
                           reachability: reachability,
                           session: session)
    }
    
    var baseUrl: String = ""
    var timeoutIntervalForRequest: TimeInterval = 60
    var adapter: RequestAdapter?
    
    var isReachable: Bool {
        return reachability.connection != .none
    }
    
    // =========================
    // MARK: - Private Variables
    // =========================
    private var header: HTTPHeaders? {
        let result: HTTPHeaders? = [
            "Content-Type": "application/json"
        ]
        return result
    }
    
    // ==============================
    // MARK: - Private Lazy Variables
    // ==============================
    private lazy var reachability: Reachability = {
        guard let this = Reachability() else {
            fatalError("reachability not available")
        }
        this.allowsCellularConnection = true
        return this
    }()
    
    private lazy var session: SessionManager = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeoutIntervalForRequest
        let session = SessionManager(configuration: sessionConfig)
        session.adapter = adapter
        return session
    }()
    
}
