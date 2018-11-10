//
//  TransactionHistoryPageViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class TransactionHistoryPageViewController: UIPageViewController {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Public
    var currentIndex: Int = 0 {
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
        let upcomingPayoutVC: UpcomingPayoutViewController = UIStoryboard.transactionHistory.instantiateViewController()
        let completedPayoutVC: CompletedPayoutViewController = UIStoryboard.transactionHistory.instantiateViewController()
        //
        return [upcomingPayoutVC, completedPayoutVC]
    }()
}

// ============================
// MARK: - Page View Controller
// ============================

// MARK: Life Cycle
extension TransactionHistoryPageViewController {
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
