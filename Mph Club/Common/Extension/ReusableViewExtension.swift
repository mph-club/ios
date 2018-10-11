//
//  ReusableViewExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import UIKit

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
