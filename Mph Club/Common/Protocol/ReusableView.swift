//
//  ReusableView.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

protocol ReusableView {
    /// Reuse identifier of this view
    static var reuseIdentifier: String { get }
}
