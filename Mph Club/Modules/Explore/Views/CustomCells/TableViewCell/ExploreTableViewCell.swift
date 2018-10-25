//
//  ExploreTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/13/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ExploreTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Collection View
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            // Register collection view cell
            registerCollectionViewCell()
        }
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Life Cycle
extension ExploreViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============

// MARK: Private
private extension ExploreTableViewCell {
    func registerCollectionViewCell() {
        collectionView.registerCell(ExploreCarCollectionViewCell.self)
    }
}

// MARK: Public
extension ExploreTableViewCell {}

// =====================
// MARK: - Reusable View
// =====================
extension ExploreTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ExploreTableViewCell: NibLoadableView {}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension ExploreTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExploreCarCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

// MARK: Delegate
extension ExploreTableViewCell: UICollectionViewDelegate {}

// MARK: Delegate Flow Layout
extension ExploreTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.9534050179, height: collectionView.frame.height)
    }
}
