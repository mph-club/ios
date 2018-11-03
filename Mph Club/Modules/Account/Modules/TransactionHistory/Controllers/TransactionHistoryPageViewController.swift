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
        //
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

// MARK: Data Source
extension TransactionHistoryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
