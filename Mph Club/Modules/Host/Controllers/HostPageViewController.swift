//
//  HostPageViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class HostPageViewController: UIPageViewController {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Public
    var currentIndex: Int = 1 {
        didSet {
            if oldValue < currentIndex {
                setViewControllers([orderedViewControllers[currentIndex]],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            } else {
                setViewControllers([orderedViewControllers[currentIndex]],
                                   direction: .reverse,
                                   animated: true,
                                   completion: nil)
            }
        }
    }
    
    // MARK: Private
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let hostRequestVC: HostRequestViewController = UIStoryboard.host.instantiateViewController()
        let listingVehiclesVC: ListingVehiclesViewController = UIStoryboard.host.instantiateViewController()
        let hostHistoryVC: HostHistoryViewController = UIStoryboard.host.instantiateViewController()
        //
        return [hostRequestVC, listingVehiclesVC, hostHistoryVC]
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
        setViewControllers([orderedViewControllers[currentIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}
