//
//  UIViewExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/13/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /// Get and set layer's corner radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// Get and set layer's border width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Get and set layer's border color
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
