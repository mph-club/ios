//
//  UIAlertControllerExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addActions(_ alertActions: [UIAlertAction]) {
        alertActions.forEach { self.addAction($0) }
    }
}
