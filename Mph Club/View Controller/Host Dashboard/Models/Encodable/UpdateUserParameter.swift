//
//  UpdateUserParameter.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct UpdateUserParameter: Encodable {
    let email: String = "reeeee@email.com"
    let phone: String = "666666"
}

// =============================
// MARK: - Parameter Convertible
// =============================
extension UpdateUserParameter: ParameterConvertible {}
