//
//  StoryboardInitiable.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

protocol StoryboardInitiable: class {
    /// Identifier set in Storyboard
    static var storyboardIdentifier: String { get }
}
