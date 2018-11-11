//
//  HttpGateway.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire
import PromiseKit
import Reachability

final class HttpGateway: HttpGatewayProtocol {
    var baseUrl: String!
    var token: String?
    var header: HTTPHeaders?
    var reachability: Reachability!
    var session: SessionManager!
    
    convenience init(baseUrl: String,
                     header: HTTPHeaders?,
                     reachability: Reachability,
                     session: SessionManager) {
        self.init()
        self.baseUrl = baseUrl
        self.header = header
        self.reachability = reachability
        self.session = session
    }
}

// ===================
// MARK: - Validations
// ===================
extension HttpGateway {
    func validate(_ request: URLRequest?,
                  _ response: HTTPURLResponse,
                  _ data: Data?) -> Request.ValidationResult {
        switch response.statusCode {
        case 200..<300:
            return .success
        case 400:
            return .failure(MphErrors.Backend.other(error: data, response: response))
        case 401:
            return .failure(MphErrors.Backend.unAuthorized(error: data, response: response))
        case 403:
            return .failure(MphErrors.Backend.forbidden(error: data, response: response))
        case 404:
            return .failure(MphErrors.Backend.notFound(error: data, response: response))
        case 400..<500:
            return .failure(MphErrors.Backend.other(error: data, response: response))
        case 504:
            return .failure(MphErrors.Backend.connectionTimeout(error: data, response: response))
        case 500 ..< 600:
            return .failure(MphErrors.Backend.other(error: data, response: response))
        default:
            return .failure(MphErrors.Backend.other(error: data, response: response))
        }
    }
}

// ====================
// MARK: - GET Requests
// ====================
extension HttpGateway {
    func get(fromURL url: URLConvertible,
             parameters params: ParameterConvertible? = nil,
             adapter: RequestAdapter? = nil) -> Promise<Data> {
        guard reachability.connection != .none else {
            return Promise(error: MphErrors.Backend.noNetworkConnectivity(error: nil, response: nil))
        }
        
        if let adapter = adapter {
            session.adapter = adapter
        }
        
        var parameters: Parameters?
        if let params = params {
            do {
                parameters = try params.asParameter()
            } catch {
                return Promise(error: error)
            }
        }
        
        return session.request(url,
                               method: .get,
                               parameters: parameters,
                               encoding: URLEncoding.default)
            .validate(validate(_:_:_:))
            .responseData()
    }
}

// =====================
// MARK: - POST Requests
// =====================
extension HttpGateway {
    func post(toURL url: URLConvertible,
              parameters params: ParameterConvertible? = nil,
              adapter: RequestAdapter? = nil) -> Promise<Data> {
        guard reachability.connection != .none else {
            return Promise(error: MphErrors.Backend.noNetworkConnectivity(error: nil, response: nil))
        }
        
        if let adapter = adapter {
            session.adapter = adapter
        }
        
        var parameters: Parameters?
        if let params = params {
            do {
                parameters = try params.asParameter()
            } catch {
                return Promise(error: error)
            }
        }
        
        return session.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate(validate(_:_:_:))
            .responseData()
    }
}

// ====================
// MARK: - PUT Requests
// ====================
extension HttpGateway {
    func put(toURL url: URLConvertible,
             parameters params: ParameterConvertible? = nil,
             adapter: RequestAdapter? = nil) -> Promise<Data> {
        guard reachability.connection != .none else {
            return Promise(error: MphErrors.Backend.noNetworkConnectivity(error: nil, response: nil))
        }
        
        if let adapter = adapter {
            session.adapter = adapter
        }
        
        var parameters: Parameters?
        if let params = params {
            do {
                parameters = try params.asParameter()
            } catch {
                return Promise(error: error)
            }
        }
        
        return session.request(url,
                               method: .put,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate(validate(_:_:_:))
            .responseData()
    }
}

// =======================
// MARK: - DELETE Requests
// =======================
extension HttpGateway {
    func delete(fromURL url: URLConvertible,
                parameters params: ParameterConvertible? = nil,
                adapter: RequestAdapter? = nil) -> Promise<Data> {
        guard reachability.connection != .none else {
            return Promise(error: MphErrors.Backend.noNetworkConnectivity(error: nil, response: nil))
        }
        
        if let adapter = adapter {
            session.adapter = adapter
        }
        
        var parameters: Parameters?
        if let params = params {
            do {
                parameters = try params.asParameter()
            } catch {
                return Promise(error: error)
            }
        }
        
        return session.request(url,
                               method: .delete,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate(validate(_:_:_:))
            .responseData()
    }
}

// ============================
// MARK: - Upload File Requests
// ============================
extension HttpGateway {
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    parameters params: ParameterConvertible? = nil,
                    adapter: RequestAdapter? = nil,
                    method: HTTPMethod = .post) -> Promise<Data> {
        guard reachability.connection != .none else {
            return Promise(error: MphErrors.Backend.noNetworkConnectivity(error: nil, response: nil))
        }
        
        if let adapter = adapter {
            session.adapter = adapter
        }
        
        var parameters: Parameters?
        if let params = params {
            do {
                parameters = try params.asParameter()
            } catch {
                return Promise(error: error)
            }
        }
        
        return Promise { seal in
            session.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(file.value, withName: file.key, fileName: file.name + file.extension, mimeType: file.mimeType)
                if let parameters = parameters {
                    for (key, value) in parameters {
                        // swiftlint:disable:next force_unwrapping
                        multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                    }
                }
            }, to: url,
               method: method,
               encodingCompletion: { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload
                        .validate(self.validate(_:_:_:))
                        .responseData { (response) in
                            switch response.result {
                            case .success(let data):
                                seal.fulfill(data)
                            case .failure(let error):
                                seal.reject(error)
                            }
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
}
