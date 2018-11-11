//
//  NoContentView.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class NoContentView: UIView {
    //================
    // MARK: - Outlets
    //================
    @IBOutlet fileprivate weak var noContentLabel: UILabel!
}

//================================
// MARK: - Complementary Functions
//================================
extension NoContentView {
    func setContent(_ message: String) {
        self.noContentLabel.text = message
    }
}

// ========================
// MARK: - RTAReusable View
// ========================
extension NoContentView: ReusableView {}

// ======================
// MARK: - RTANibLoadable
// ======================
extension NoContentView: NibLoadableView {}
