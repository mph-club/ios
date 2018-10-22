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
    let itemSize: CGFloat = 71
    
    // MARK: Mock Data
    private let carAttributes: [CarAttribute] = [CarAttribute(title: "2 Seats", image: "seat64Px"),
                                                 CarAttribute(title: "2 Door", image: "door64Px"),
                                                 CarAttribute(title: "13 MPG", image: "gas64Px"),
                                                 CarAttribute(title: "GPS", image: "satellite64Px")]
}

// ==================
// MARK: - Table View
// ==================

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
    
    private func registerCollectionViewCell() {
        collectionView.registerCell(CarDetailDescriptionCollectionViewCell.self)
    }
}

// =======================
// MARK: - Collection View
// =======================

// MARK: Data Source
extension CarDetailDescriptionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carAttributes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarDetailDescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(carAttributes[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension CarDetailDescriptionTableViewCell: UICollectionViewDelegate {}

// MARK: Delegate Flow Layout
extension CarDetailDescriptionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width - 4 * itemSize) / 4
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarDetailDescriptionTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarDetailDescriptionTableViewCell: NibLoadableView {}
