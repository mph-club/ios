//
//  MainTabBar.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/12/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 95
        tabFrame.origin.y = self.view.frame.size.height-80
        self.tabBar.frame = tabFrame
    }


}
