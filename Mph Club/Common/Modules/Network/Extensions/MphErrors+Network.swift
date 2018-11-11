//
//  MphErrors+Network.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/10/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

extension MphErrors {
    public enum Backend: Error {
        /// When internet connection failes
        case connectionTimeout(error: Data?, response: HTTPURLResponse?)
        /// When session is not valid
        case unAuthorized(error: Data?, response: HTTPURLResponse?)
        /// When no such url found
        case notFound(error: Data?, response: HTTPURLResponse?)
        /// When access if forbbiden
        case forbidden(error: Data?, response: HTTPURLResponse?)
        /// When other errors happen
        case other(error: Data?, response: HTTPURLResponse?)
        /// when the network is not reachable
        case noNetworkConnectivity(error: Data?, response: HTTPURLResponse?)
        ///
        case parsingJson
    }
}
