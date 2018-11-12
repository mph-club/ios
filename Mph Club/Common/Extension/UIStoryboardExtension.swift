//
//  UIStoryboardExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

extension UIStoryboard {
    /// Instantiates an RTAStoryboardInitiable view controller
    ///
    /// - Returns: An instance of desired view controller
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardInitiable {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Could not initiate view controller with identifer \(T.storyboardIdentifier)")
        }
        return viewController
    }
    
}
