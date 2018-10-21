//
//  CarDetailOwnedItemTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailOwnedItemTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension CarDetailOwnedItemTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailOwnedItemTableViewCell {
    func setContent() {}
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailOwnedItemTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailOwnedItemTableViewCell: NibLoadableView {}
