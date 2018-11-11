//
//  ParameterConvertible.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire
import PromiseKit

protocol ParameterConvertible {
    var jsonEncoder: JSONEncoder { get }
    
    func asParameter() throws -> Parameters
    func asParameter() -> Promise<Parameters>
}

extension ParameterConvertible {
    public var jsonEncoder: JSONEncoder {
        return JSONEncoder.default
    }
    
    func asParameter() -> Promise<Parameters> {
        return Promise { seal in
            do {
                let parameters: Parameters = try asParameter()
                seal.fulfill(parameters)
            } catch {
                seal.reject(error)
            }
        }
    }
    
}

typealias Parameter = ParameterConvertible & Encodable

extension ParameterConvertible where Self: Encodable {
    func asParameter() throws -> Parameters {
        do {
            let data = try jsonEncoder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters
            guard let parameter = jsonObject else {
                throw ParameterConvertableErrors.castAnyToDictionaryFailed
            }
            return parameter
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
    }
}

extension Dictionary: ParameterConvertible {
    func asParameter() throws -> Parameters {
        guard let parameters = self as? Parameters else { throw ParameterConvertableErrors.castAnyToDictionaryFailed }
        return parameters
    }
}

enum ParameterConvertableErrors: Error {
    case castAnyToDictionaryFailed
}
