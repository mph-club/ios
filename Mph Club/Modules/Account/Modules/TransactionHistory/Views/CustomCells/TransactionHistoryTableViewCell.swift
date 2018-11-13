//
//  TransactionHistoryTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/3/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class TransactionHistoryTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: Label
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var carNameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var payoutStatusLabel: UILabel!
    @IBOutlet private weak var payoutAccountLabel: UILabel!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension TransactionHistoryTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension TransactionHistoryTableViewCell {
    func setContent(_ transaction: Transaction) {
        fullNameLabel.text = transaction.fullName
        priceLabel.text = transaction.price
        carNameLabel.text = transaction.carName
        yearLabel.text = transaction.year
        payoutAccountLabel.text = transaction.payoutAccount
        //
        if transaction.payoutStatus == .faild {
            lineView.isHidden = false
            priceLabel.textColor = .mphGray
            payoutStatusLabel.textColor = .mphRed
        } else {
            lineView.isHidden = true
            priceLabel.textColor = .black
            payoutStatusLabel.textColor = .mphGray
        }
        //
        payoutStatusLabel.text = transaction.payoutStatus == .complete ? "Oct 05, 2018" : transaction.payoutStatus.rawValue
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension TransactionHistoryTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension TransactionHistoryTableViewCell: NibLoadableView {}
