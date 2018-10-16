//
//  UITabBarControllerExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/16/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
}
