//
//  FleetHeaderTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class FleetHeaderTableViewCell: UITableViewHeaderFooterView {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var tripPreferenceBox: UIView!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension FleetHeaderTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addShadowToTripBox()
    }
}

// ===============
// MARK: - Methods
// ===============
extension FleetHeaderTableViewCell {
    private func addShadowToTripBox() {
        tripPreferenceBox.layer.shadowColor = UIColor.gray.cgColor
        tripPreferenceBox.layer.shadowOpacity = 0.5
        tripPreferenceBox.layer.shadowOffset = CGSize.zero
        tripPreferenceBox.layer.shadowRadius = 5
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension FleetHeaderTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension FleetHeaderTableViewCell: NibLoadableView {}
