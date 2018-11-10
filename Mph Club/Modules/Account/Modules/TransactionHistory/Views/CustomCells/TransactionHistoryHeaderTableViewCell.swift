//
//  TransactionHistoryHeaderTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/3/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class TransactionHistoryHeaderTableViewCell: UITableViewHeaderFooterView {}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension TransactionHistoryHeaderTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension TransactionHistoryHeaderTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension TransactionHistoryHeaderTableViewCell: NibLoadableView {}
