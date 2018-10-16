//
//  Endpoint.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import Alamofire

protocol Endpoint: URLConvertible {
    var path: String { get }
    var url: String { get }
}
