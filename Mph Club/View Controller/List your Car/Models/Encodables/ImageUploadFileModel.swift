//
//  ImageUploadFileModel.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct ImageUploadFileModel: UploadFileProtocol {
    private(set) var key: String
    private(set) var value: Data
    private(set) var name: String
    private(set) var `extension`: String
    private(set) var mimeType: String
}
