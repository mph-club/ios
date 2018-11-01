//
//  ContactInfoTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ContactInfoTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension ContactInfoTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension ContactInfoTableViewCell {
    func setContent(_ contactInfo: ContactInfo?) {
        titleLabel.isHidden = contactInfo?.title == nil ? true : false
        //
        titleLabel.text = contactInfo?.title
        valueLabel.text = contactInfo?.value
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension ContactInfoTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ContactInfoTableViewCell: NibLoadableView {}
