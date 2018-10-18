//
//  UIApplicationExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/16/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
