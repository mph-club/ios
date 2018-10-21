//
//  UIViewControllerExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// Performs segue with specified identifier and sends the sender
    ///
    /// **Notes:**
    ///   - This method only works for RawRepresentable identifier
    ///     which has RawValue type of String
    ///   - This method throws an Exception handling if there is no
    ///     segue with the specified identifier.
    ///
    /// **Example:**
    /// ```
    /// enum Segue: String {
    ///     case showLogin
    /// }
    /// ...
    /// @IBAction private func loginButtonTouchUpInside(_ sender: UIButton) {
    ///     self.performSegue(withIdentifier: Segue.showLogin)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - identifier: The RawRepresentable that identifies the triggered segue.
    ///   - sender: _(optional)_ The object that you want to use to initiate the segue.
    func performSegue<IdentifierType: RawRepresentable>(withIdentifier identifier: IdentifierType, sender: Any? = nil) where IdentifierType.RawValue == String {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    /// Description
    ///
    /// - Parameters:
    ///   - title: title description
    ///   - message: message description
    /// - Returns: return value description
    func fireAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    /// Description
    ///
    /// - Parameters:
    ///   - title: title description
    ///   - message: message description
    /// - Returns: return value description
    func fireActionSheet(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        return alert
    }
}
