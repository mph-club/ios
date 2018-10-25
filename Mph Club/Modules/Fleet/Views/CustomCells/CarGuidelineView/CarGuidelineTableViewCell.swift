//
//  CarGuidelineTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarGuidelineTableViewCell: UITableViewCell {}

// ===============
// MARK: - Methods
// ===============
extension CarGuidelineTableViewCell {
    func setContent(_ guideline: String?) {
        textLabel?.text = guideline
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarGuidelineTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarGuidelineTableViewCell: NibLoadableView {}
