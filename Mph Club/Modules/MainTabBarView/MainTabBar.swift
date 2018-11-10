//
//  MainTabBar.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/12/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class MainTabBar: UITabBarController {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private Lazy
    private lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
}

// ===============================
// MARK: - Tab Bar View Controller
// ===============================

// MARK: Life Cycle
extension MainTabBar {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.black
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let newTabBarHeight = defaultTabBarHeight + 16.0
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    
}
