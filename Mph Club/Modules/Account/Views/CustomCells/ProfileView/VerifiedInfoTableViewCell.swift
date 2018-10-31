//
//  VerifiedInfoTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/27/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class VerifiedInfoTableViewCell: UITableViewCell {}

// ===============
// MARK: - Methods
// ===============
extension VerifiedInfoTableViewCell {
    func setContent(_ verifiedInfo: String?) {
        textLabel?.text = verifiedInfo
        //
        imageView?.image = UIImage(named: "blue-checkmark")
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension VerifiedInfoTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension VerifiedInfoTableViewCell: NibLoadableView {}
