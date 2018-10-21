//
//  CarDetailDescriptionTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarDetailDescriptionTableViewCell: UITableViewCell {
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
extension CarDetailDescriptionTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailDescriptionTableViewCell {
    func setContent() {}
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension CarDetailDescriptionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: Delegate
extension CarDetailDescriptionTableViewCell: UICollectionViewDelegate {}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailDescriptionTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailDescriptionTableViewCell: NibLoadableView {}
