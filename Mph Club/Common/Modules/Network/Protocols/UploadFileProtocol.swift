//
//  UploadFileProtocol.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

protocol UploadFileProtocol {
    var key: String { get }
    var value: Data { get }
    var name: String { get }
    var `extension`: String { get }
    var mimeType: String { get }
}
