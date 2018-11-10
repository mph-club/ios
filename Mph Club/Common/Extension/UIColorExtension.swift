//
//  UIColorExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

/// Typealias
typealias PaletteName = UIColor.PaletteName

extension UIColor {
    static let Palette: [String: UIColor] = [
        "yellow": #colorLiteral(red: 1, green: 0.8164650798, blue: 0.03998695686, alpha: 1),                    // #FECF33
        "lightOrange": #colorLiteral(red: 1, green: 0.746743083, blue: 0.1352950335, alpha: 1),               // #FDBD39
        "peach": #colorLiteral(red: 1, green: 0.4046171308, blue: 0.0813671127, alpha: 1),                     // #EE6723
        "red": #colorLiteral(red: 1, green: 0.007843137255, blue: 0.1176470588, alpha: 1),                       // #FF021E
        "gray": #colorLiteral(red: 0.6054732203, green: 0.6055628657, blue: 0.6054536104, alpha: 1),                      // #999999
        "green": #colorLiteral(red: 0, green: 0.8588126898, blue: 0.3436958194, alpha: 1)                      // #31DA62
    ]
    
    /// Enum
    enum PaletteName: String {
        case yellow, lightOrange, peach, red, gray, green
        
        var color: UIColor {
            guard let color = UIColor.Palette[self.rawValue] else {
                fatalError("no color defined for name \(self.rawValue)")
            }
            return color
        }
        
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
