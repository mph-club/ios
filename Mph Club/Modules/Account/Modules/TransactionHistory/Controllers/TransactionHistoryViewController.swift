//
//  TransactionHistoryViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/2/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class TransactionHistoryViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case embedPageView
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Segment View
    @IBOutlet private weak var segmentView: CustomSegmentView! {
        didSet {
            //
            segmentView.items = ["UPCOMING PAYOUTS", "COMPLETED PAYOUTS"]
            //
            segmentView.delegate = self
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private weak var pageViewController: TransactionHistoryPageViewController?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension TransactionHistoryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: Navigatio
extension TransactionHistoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = Segue(rawValue: segue.identifier ?? "") else { return }
        //
        switch identifier {
        case .embedPageView:
            pageViewController = segue.destination as? TransactionHistoryPageViewController
        }
    }
}

// ====================================
// MARK: - Custom Segment View Delegate
// ====================================
extension TransactionHistoryViewController: CustomSegmentViewDelegate {
    func customSegmentView(_ customSegmentView: CustomSegmentView, didSelectItem index: Int) {
        guard let pageViewController = self.pageViewController else { return }
        //
        pageViewController.currentIndex = index
    }
}
