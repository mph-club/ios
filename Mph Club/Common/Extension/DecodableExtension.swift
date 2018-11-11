//
//  DecodableExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

extension Decodable {
    
    /// Decodes json data to this model
    ///
    /// - Parameter data: JSON data to decode
    /// - Returns: An instance of this model
    /// - Throws: If the data is not valid JSON, this method throws the dataCorrupted error. If a value within the JSON fails to decode, this method throws the corresponding error.
    static func jsonDecode(data: Data) throws -> Self {
        return try JSONDecoder.default.decode(Self.self, from: data)
    }
    
    /// Decodes json data to this model
    ///
    /// - Parameter data: JSON data to decode
    /// - Returns: Promise of new instance of this model
    static func jsonDecode(data: Data) -> Promise<Self> {
        return Promise { seal in
            do {
                seal.fulfill(try jsonDecode(data: data))
            } catch {
                seal.reject(error)
            }
        }
    }
    
}
