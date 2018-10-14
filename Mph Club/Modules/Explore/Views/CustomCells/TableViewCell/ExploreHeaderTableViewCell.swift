//
//  ExploreHeaderTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ExploreHeaderTableViewCell: UITableViewHeaderFooterView {
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
extension ExploreHeaderTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension ExploreHeaderTableViewCell {
    func setContent(_ title: String) {
        titleLabel.text = title
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension ExploreHeaderTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ExploreHeaderTableViewCell: NibLoadableView {}
