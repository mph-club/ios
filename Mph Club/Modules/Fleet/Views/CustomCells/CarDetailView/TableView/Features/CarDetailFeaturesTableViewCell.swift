//
//  CarDetailFeaturesTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailFeaturesTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Collection View
    @IBOutlet private weak var collectionView: UICollectionView!
}

// =========================
// MARK: - Table View Header
// =========================

// MARK: Life Cycle
extension CarDetailFeaturesTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailFeaturesTableViewCell {
    func setContent() {}
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension CarDetailFeaturesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: Delegate
extension CarDetailFeaturesTableViewCell: UICollectionViewDelegate {}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailFeaturesTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailFeaturesTableViewCell: NibLoadableView {}
