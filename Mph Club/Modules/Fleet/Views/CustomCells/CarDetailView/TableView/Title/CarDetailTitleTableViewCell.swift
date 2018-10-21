//
//  CarDetailTitleTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailTitleTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tripLabel: UILabel!
    @IBOutlet private weak var milesLabel: UILabel!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension CarDetailTitleTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailTitleTableViewCell {
    func setContent(_ vehicle: Vehicle?) {
        titleLabel.text = vehicle?.title
        tripLabel.text = "\(vehicle?.trips ?? 0) trips"
        milesLabel.text = "\(vehicle?.miles ?? 0) mi"
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailTitleTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailTitleTableViewCell: NibLoadableView {}
