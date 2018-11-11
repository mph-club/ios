//
//  UploadCarImageParameters.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct UploadCarImageParameters: Encodable {
    let vehicle: String?
}

// =============================
// MARK: - Parameter Convertible
// =============================
extension UploadCarImageParameters: ParameterConvertible {}
