//
//  Transaction.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/3/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

struct Transaction {
    // =============
    // MARK: - Enums
    // =============
    enum PayoutStatusType: String {
        case inProgress = "In-progress"
        case faild = "Payment faild"
        case complete
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    let fullName: String?
    let price: String?
    let carName: String?
    let year: String?
    let payoutStatus: PayoutStatusType
    let payoutAccount: String?
}
