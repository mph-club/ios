//
//  FeatureContainerVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 8/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class FeatureContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon) ?? UIImage()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(EndTimeTVC.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }
}
