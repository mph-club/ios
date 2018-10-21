//
//  CarDetailHeaderTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailHeaderTableViewCell: UITableViewHeaderFooterView {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension CarDetailHeaderTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailHeaderTableViewCell {
    func setContent(_ title: String?) {
        titleLabel.text = title
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailHeaderTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailHeaderTableViewCell: NibLoadableView {}
