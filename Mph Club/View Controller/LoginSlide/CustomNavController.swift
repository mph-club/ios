//
//  CustomNavController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }


}
