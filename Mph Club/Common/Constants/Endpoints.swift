//
//  Endpoints.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoints {
    static var baseUrl: String = InfoDictionary.main.baseURL
}

extension URLConvertible where Self: Endpoint {
    func asURL() throws -> URL {
        guard let url = URL(string: url) else { throw AFError.invalidURL(url: self.url) }
        return url
    }
}

extension Endpoints {
    enum APIVersion: Endpoint {
        case version1
        
        var path: String {
            switch self {
            case .version1:
                return "/app/api/v1/"
            }
        }
        
        var url: String {
            switch self {
            case .version1:
                return "\(Endpoints.baseUrl)\(self.path)"
            }
        }
    }
}
