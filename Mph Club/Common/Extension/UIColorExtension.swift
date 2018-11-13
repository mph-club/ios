//
//  UIColorExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var mphYellow: UIColor {
        return #colorLiteral(red: 1, green: 0.8164650798, blue: 0.03998695686, alpha: 1)    // #FECF33
    }
    
    @nonobjc class var mphLightOrange: UIColor {
        return #colorLiteral(red: 1, green: 0.746743083, blue: 0.1352950335, alpha: 1)    // #EE6723
    }
    
    @nonobjc class var mphRed: UIColor {
        return #colorLiteral(red: 1, green: 0.007843137255, blue: 0.1176470588, alpha: 1)    // #FF021E
    }
    
    @nonobjc class var mphGray: UIColor {
        return #colorLiteral(red: 0.6054732203, green: 0.6055628657, blue: 0.6054536104, alpha: 1)    // #999999
    }
    
    @nonobjc class var mphGreen: UIColor {
        return #colorLiteral(red: 0, green: 0.8588126898, blue: 0.3436958194, alpha: 1)    // #31DA62
    }
    
    /// Create random color
    ///
    /// - Returns: UIColor
    class func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
}
