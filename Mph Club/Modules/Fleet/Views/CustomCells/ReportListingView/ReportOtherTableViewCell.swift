//
//  ReportOtherTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ReportOtherTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Image View
    @IBOutlet private weak var radioImageView: UIImageView!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension ReportOtherTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Mehtods
// ===============
extension ReportOtherTableViewCell {
    func setContent(_ report: Report) {
        titleLabel.text = report.title
        //
        if report.isSelected {
            radioImageView.image = #imageLiteral(resourceName: "full-radio")
        } else {
            radioImageView.image = #imageLiteral(resourceName: "epmty-radio")
        }
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension ReportOtherTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ReportOtherTableViewCell: NibLoadableView {}
