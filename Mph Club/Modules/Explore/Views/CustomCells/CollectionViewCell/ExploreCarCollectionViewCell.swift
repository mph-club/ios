//
//  ExploreCarCollectionViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/14/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ExploreCarCollectionViewCell: UICollectionViewCell {}

// =======================
// MARK: - Collection View
// =======================

// MARK: Life Cycle
extension ExploreCarCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension ExploreCarCollectionViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ExploreCarCollectionViewCell: NibLoadableView {}
