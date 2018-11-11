//
//  NetworkProtocol.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

protocol NetworkProtocol: class {
    var network: HttpGatewayProtocol { get }
}
