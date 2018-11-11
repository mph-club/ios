//
//  Network.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire

final class Network {
    
    /// network instance to access http methodes
    public static let network = NetworkConfigurator.shared.network
    public static let isReachable = NetworkConfigurator.shared.isReachable
    
    /// set httpUrl to make httpRequest
    ///
    /// - Parameter httpUrl: remote url
    public static func set(httpUrl: String = "",
                           timeoutIntervalForRequest: TimeInterval = 60,
                           adapter: RequestAdapter? = nil) {
        NetworkConfigurator.shared.baseUrl = httpUrl
        NetworkConfigurator.shared.timeoutIntervalForRequest = timeoutIntervalForRequest
        NetworkConfigurator.shared.adapter = adapter
    }
    
}
