//
//  CarDetailDescriptionCollectionViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/22/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailDescriptionCollectionViewCell: UICollectionViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Life Cycle
extension CarDetailDescriptionCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailDescriptionCollectionViewCell {
    func setContent(_ carAttribute: CarAttribute?) {
        imageView.image = UIImage(named: carAttribute?.image ?? "")
        titleLabel.text = carAttribute?.title
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailDescriptionCollectionViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailDescriptionCollectionViewCell: NibLoadableView {}
