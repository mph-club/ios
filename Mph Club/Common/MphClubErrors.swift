//
//  MphClubErrors.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

enum MphClubErrors: Error, LocalizedError {
    case connectionTimeout
    case forbidden(messages: [String]?)
    case noNetworkConnectivity
    case notFound(messages: [String]?)
    case other(messages: [String]?)
    case unAuthorized(messages: [String]?)
    
    var errorDescription: String? {
        switch self {
        case .connectionTimeout:
            return "No Network Access"
        case .forbidden(let messages):
            return messages?.joined(separator: "\n") ?? "Forbidden"
        case .noNetworkConnectivity:
            return "Turn on cellular data or use Wi-Fi to access RedSix"
        case .notFound(let messages):
            return messages?.joined(separator: "\n") ?? "Not Found"
        case .other(let messages):
            return messages?.joined(separator: "\n") ?? "Unknown Error"
        case .unAuthorized(let messages):
            return messages?.joined(separator: "\n") ?? "Unauthorized"
        }
    }
}

// ======================
// MARK: - Error Handling
// ======================
extension MphClubErrors {
    static func handle<T>(_ error: Error) -> Promise<T> {
        guard let backendError = error as? MphErrors.Backend else { return Promise(error: error) }
        var result: Promise<T>!
        
        func parseErrorMessages(_ errorData: Data?) -> [String]? {
            guard let errorData = errorData,
                let response = try? JSONDecoder.default.decode([String: [String]].self, from: errorData),
                let messages = response["errors"] else { return nil }
            
            return messages
        }
        
        switch backendError {
        case .connectionTimeout:
            result = Promise(error: MphClubErrors.connectionTimeout)
        case .forbidden(let errorData, _):
            result = Promise(error: MphClubErrors.forbidden(messages: parseErrorMessages(errorData)))
        case .noNetworkConnectivity:
            result = Promise(error: MphClubErrors.noNetworkConnectivity)
        case .notFound(let errorData, _):
            result = Promise(error: MphClubErrors.notFound(messages: parseErrorMessages(errorData)))
        case .other(let errorData, _):
            result = Promise(error: MphClubErrors.other(messages: parseErrorMessages(errorData)))
        case .unAuthorized(let errorData, _):
            result = Promise(error: MphClubErrors.unAuthorized(messages: parseErrorMessages(errorData)))
        default:
            break
        }
        
        return result
    }
}
