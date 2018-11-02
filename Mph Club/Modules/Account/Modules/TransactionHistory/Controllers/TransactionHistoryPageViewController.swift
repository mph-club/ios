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
        dataSource = self
    }
}

// MARK: Data Source
extension TransactionHistoryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
