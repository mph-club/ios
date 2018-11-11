//
//  HostPageViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class HostPageViewController: UIPageViewController {
    // MARK: Private
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let listingVehiclesVC: ListingVehiclesViewController = UIStoryboard.host.instantiateViewController()
        //
        return [listingVehiclesVC]
    }()
}

// ============================
// MARK: - Page View Controller
// ============================

// MARK: Life Cycle
extension HostPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}
