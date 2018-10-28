//
//  CalendarCollectionViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import JTAppleCalendar

final class CalendarCollectionViewCell: JTAppleCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Label
    @IBOutlet private weak var dateLabel: UILabel!
}

// ============================
// MARK: - Collection View Cell
// ============================

// MARK: Life Cycle
extension CalendarCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CalendarCollectionViewCell {
    func setContent(_ date: String?) {
        dateLabel.text = date
    }
    
    func handleCellTextColor(_ cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            dateLabel.textColor = .black
        } else {
            dateLabel.textColor = .darkGray
        }
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CalendarCollectionViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CalendarCollectionViewCell: NibLoadableView {}
