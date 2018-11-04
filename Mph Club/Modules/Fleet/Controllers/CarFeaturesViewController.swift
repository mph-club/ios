//
//  CarFeaturesViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarFeaturesViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register Cell View
            registerTableView()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Mock Data
    private var featureItems = [CarFeature(title: "Automatic transmission", image: "automaticTransmission"),
                                CarFeature(title: "Bluetooth", image: "bluetooth"),
                                CarFeature(title: "Sunroof", image: "sun"),
                                CarFeature(title: "Audio Input", image: "music"),
                                CarFeature(title: "USB Input", image: "usb"),
                                CarFeature(title: "Toll pass", image: "toll")]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CarFeaturesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .whiteNavigationBar
        //
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// ===============
// MARK: - Methods
// ===============
private extension CarFeaturesViewController {
    func registerTableView() {
        tableView.register(CarFeatureTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension CarFeaturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarFeatureTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(featureItems[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension CarFeaturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
