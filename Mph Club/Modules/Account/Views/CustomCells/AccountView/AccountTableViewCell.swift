//
//  AccountTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/30/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class AccountTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension AccountTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension AccountTableViewCell {
    func setContent(_ title: String?) {
        titleLabel?.text = title
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension AccountTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension AccountTableViewCell: NibLoadableView {}
