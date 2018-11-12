//
//  StoryboardInitiableExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

extension StoryboardInitiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
