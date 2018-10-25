//
//  CarDetailFeaturesCollectionViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/22/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailFeaturesCollectionViewCell: UICollectionViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var imageView: UIImageView!
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Life Cycle
extension CarDetailFeaturesCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailFeaturesCollectionViewCell {
    func setContent(_ image: String?) {
        imageView.image = UIImage(named: image ?? "")
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailFeaturesCollectionViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailFeaturesCollectionViewCell: NibLoadableView {}
