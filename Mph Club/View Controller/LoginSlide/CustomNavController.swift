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
        navigationBar.barTintColor = UIColor.green
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(CustomNavController.back))
        
        
//        let btn1 = UIButton(type: .custom)
//        btn1.setImage(UIImage(named: "backArrow"), for: .normal)
//        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn1.tintColor = UIColor.white
//        btn1.addTarget(self, action: #selector(CustomNavController.back), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: btn1)
        
//        let btn2 = UIButton(type: .custom)
//        btn2.setImage(UIImage(named: "backArrow"), for: .normal)
//        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn2.addTarget(self, action: #selector(CustomNavController.back), for: .touchUpInside)
//        let item2 = UIBarButtonItem(customView: btn2)
        
        
     //   self.navigationItem.setLeftBarButton(item1, animated: true)
        
      //  self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        
//        let leftButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CustomNavController.back))
//        leftButton.tintColor = UIColor.white
//
//        self.navigationBar.backItem?.backBarButtonItem = leftButton
        
//        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
    }
    
    @objc func back() {
        print("Back")
    }
    


}
