//
//  HttpGetewayProtocol.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire
import PromiseKit

// ======================================
// MARK: - HTTP Network Utilities Protocol
// =======================================

/// HTTP protocol for network layer.
protocol HttpGatewayProtocol: class {
    /// perform network get method
    ///
    /// - Parameters:
    ///   - fromURL: url string
    ///   - parameters: Parameters for request
    /// - Returns: prmoise an Optional Data
    func get(fromURL url: URLConvertible,
             parameters params: ParameterConvertible?,
             adapter: RequestAdapter?) -> Promise<Data>
    func get(fromURL url: URLConvertible,
             parameters params: ParameterConvertible?) -> Promise<Data>
    func get(fromURL url: URLConvertible) -> Promise<Data>
    
    /// perform network post method
    ///
    /// - Parameters:
    ///   - toURL: url string
    ///   - parameters: Parameters for request
    /// - Returns: prmoise an Optional Data
    func post(toURL url: URLConvertible,
              parameters params: ParameterConvertible?,
              adapter: RequestAdapter?) -> Promise<Data>
    func post(toURL url: URLConvertible,
              parameters params: ParameterConvertible?) -> Promise<Data>
    func post(toURL url: URLConvertible) -> Promise<Data>
    
    /// perform network put method
    ///
    /// - Parameters:
    ///   - toURL: url string
    ///   - parameters: Parameters for request
    /// - Returns: prmoise an Optional Data
    func put(toURL url: URLConvertible,
             parameters params: ParameterConvertible?,
             adapter: RequestAdapter?) -> Promise<Data>
    func put(toURL url: URLConvertible,
             parameters params: ParameterConvertible?) -> Promise<Data>
    func put(toURL url: URLConvertible) -> Promise<Data>
    
    /// perform network delete method
    ///
    /// - Parameters:
    ///   - fromURL: url string
    ///   - parameters: Parameters for request
    /// - Returns: prmoise an Optional Data
    func delete(fromURL url: URLConvertible,
                parameters params: ParameterConvertible?,
                adapter: RequestAdapter?) -> Promise<Data>
    func delete(fromURL url: URLConvertible,
                parameters params: ParameterConvertible?) -> Promise<Data>
    func delete(fromURL url: URLConvertible) -> Promise<Data>
    
    /// upload image to server via FormMultiPart
    ///
    /// - Parameters:
    ///   - url: url to put image to
    ///   - image: image Data
    ///   - name: name to use in form
    ///   - mimeType: image type
    ///   - progress: progress block to show percent
    /// - Returns: promises a Data
    //swiftlint:disable:next function_parameter_count
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    parameters params: ParameterConvertible?,
                    adapter: RequestAdapter?,
                    method: HTTPMethod) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    parameters params: ParameterConvertible?,
                    adapter: RequestAdapter?) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    parameters params: ParameterConvertible?,
                    method: HTTPMethod) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    adapter: RequestAdapter?,
                    method: HTTPMethod) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    parameters params: ParameterConvertible?) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    adapter: RequestAdapter?) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol,
                    method: HTTPMethod) -> Promise<Data>
    func uploadFile(toURL url: URLConvertible,
                    file: UploadFileProtocol) -> Promise<Data>
}

// ====================
// MARK: - GET Requests
// ====================
extension HttpGatewayProtocol {
    public func get(fromURL url: URLConvertible,
                    parameters params: ParameterConvertible?) -> Promise<Data> {
        return get(fromURL: url,
                   parameters: params,
                   adapter: nil)
    }
    
    public func get(fromURL url: URLConvertible) -> Promise<Data> {
        return get(fromURL: url,
                   parameters: nil,
                   adapter: nil)
    }
}

// =====================
// MARK: - POST Requests
// =====================
extension HttpGatewayProtocol {
    public func post(toURL url: URLConvertible,
                     parameters params: ParameterConvertible?) -> Promise<Data> {
        return post(toURL: url,
                    parameters: params,
                    adapter: nil)
    }
    
    public func post(toURL url: URLConvertible) -> Promise<Data> {
        return post(toURL: url,
                    parameters: nil,
                    adapter: nil)
    }
}

// ====================
// MARK: - PUT Requests
// ====================
extension HttpGatewayProtocol {
    public func put(toURL url: URLConvertible,
                    parameters params: ParameterConvertible?) -> Promise<Data> {
        return put(toURL: url,
                   parameters: params,
                   adapter: nil)
    }
    
    public func put(toURL url: URLConvertible) -> Promise<Data> {
        return put(toURL: url,
                   parameters: nil,
                   adapter: nil)
    }
}

// =======================
// MARK: - DELETE Requests
// =======================
extension HttpGatewayProtocol {
    public func delete(fromURL url: URLConvertible,
                       parameters params: ParameterConvertible?) -> Promise<Data> {
        return delete(fromURL: url,
                      parameters: params,
                      adapter: nil)
    }
    
    public func delete(fromURL url: URLConvertible) -> Promise<Data> {
        return delete(fromURL: url,
                      parameters: nil,
                      adapter: nil)
    }
}

// ============================
// MARK: - Upload File Requests
// ============================
extension HttpGatewayProtocol {
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           parameters params: ParameterConvertible?,
                           adapter: RequestAdapter?) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: params,
                          adapter: adapter,
                          method: .post)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           parameters params: ParameterConvertible?,
                           method: HTTPMethod) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: params,
                          adapter: nil,
                          method: method)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           adapter: RequestAdapter?,
                           method: HTTPMethod) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: nil,
                          adapter: adapter,
                          method: method)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           parameters params: ParameterConvertible?) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: params,
                          adapter: nil,
                          method: .post)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           adapter: RequestAdapter?) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: nil,
                          adapter: adapter,
                          method: .post)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol,
                           method: HTTPMethod) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: nil,
                          adapter: nil,
                          method: method)
    }
    
    public func uploadFile(toURL url: URLConvertible,
                           file: UploadFileProtocol) -> Promise<Data> {
        return uploadFile(toURL: url,
                          file: file,
                          parameters: nil,
                          adapter: nil,
                          method: .post)
    }
}

