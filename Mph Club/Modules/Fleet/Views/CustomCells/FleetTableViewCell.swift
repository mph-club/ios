//
//  FleetTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class FleetTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var carImage: UIImageView!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var tripLabel: UILabel!
    @IBOutlet private weak var milesLabel: UILabel!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension FleetTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension FleetTableViewCell {
    func setContent(_ vehicle: Vehicle) {
        carImage.image = UIImage(named: vehicle.img)
        titleLabel.text = vehicle.title
        priceLabel.text = "\(vehicle.price)"
        tripLabel.text = "\(vehicle.trips) Trips"
        milesLabel.text = "\(vehicle.miles) mil"
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension FleetTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension FleetTableViewCell: NibLoadableView {}
