//
//  CarDetailFeaturesTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

protocol CarDetailFeaturesTableViewCellDelegate: class {
    func showAllFeature(_ cell: CarDetailFeaturesTableViewCell)
}

final class CarDetailFeaturesTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Collection View
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            // Ragister collection view cell
            registerCollectionViewCell()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private let itemSize: CGFloat = 32
    
    // MARK: Delegate
    weak var delegate: CarDetailFeaturesTableViewCellDelegate?
    
    // MARK: Mock Data
    private var featureItems = ["automaticTransmission",
                                "bluetooth",
                                "sun",
                                "music"]
}

// ==================
// MARK: - Table View
// ==================

// MARK: Life Cycle
extension CarDetailFeaturesTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Actions
// ===============
private extension CarDetailFeaturesTableViewCell {
    @IBAction func showAllFeaturesTouchUpInside(_ sender: UIButton) {
        delegate?.showAllFeature(self)
    }
}

// ===============
// MARK: - Methods
// ===============
extension CarDetailFeaturesTableViewCell {
    func setContent() {}
    
    private func registerCollectionViewCell() {
        collectionView.registerCell(CarDetailFeaturesCollectionViewCell.self)
    }
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension CarDetailFeaturesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarDetailFeaturesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(featureItems[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension CarDetailFeaturesTableViewCell: UICollectionViewDelegate {}

// MARK: Delegate Flow Layout
extension CarDetailFeaturesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width - 4 * itemSize) / 4
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailFeaturesTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailFeaturesTableViewCell: NibLoadableView {}
