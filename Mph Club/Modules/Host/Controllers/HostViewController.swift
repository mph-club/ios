//
//  HostViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/11/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class HostViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case embedPageView
        case presentAddCar
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Custom Segment View
    @IBOutlet private weak var segmentView: CustomSegmentView! {
        didSet {
            //
            segmentView.items = ["REQUEST", "VEHICLES", "HISTORY"]
            //
            segmentView.selectedIndex = 1
            //
            segmentView.delegate = self
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private weak var pageViewController: HostPageViewController?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension HostViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: Navigatio
extension HostViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = Segue(rawValue: segue.identifier ?? "") else { return }
        //
        switch identifier {
        case .embedPageView:
            pageViewController = segue.destination as? HostPageViewController
        case .presentAddCar:
            break
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension HostViewController {
    @IBAction func addOwnCar(_ sender: UIBarButtonItem) {
        Constant.viewIndex = 0
        Constant.carKey = ""
        performSegue(withIdentifier: Segue.presentAddCar)
    }
}

// ====================================
// MARK: - Custom Segment View Delegate
// ====================================
extension HostViewController: CustomSegmentViewDelegate {
    func customSegmentView(_ customSegmentView: CustomSegmentView, didSelectItem index: Int) {
        guard let pageViewController = self.pageViewController else { return }
        //
        pageViewController.currentIndex = index
    }
}
