//
//  PickUpLocationTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class PickUpLocationTableViewCell: UITableViewCell {
    // =============
    // MARK: - Enums
    // =============
    enum TypeCell {
        case `default`
        case delivery
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var customImageView: UIImageView!
    
    // MARK: Label
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension PickUpLocationTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// ===============
// MARK: - Methods
// ===============
extension PickUpLocationTableViewCell {
    func setContent(_ type: TypeCell, pickUpLocation: PickUpLocation) {
        switch type {
        case .default:
            titleLabel.text = pickUpLocation.title
            addressLabel.text = pickUpLocation.address
            descriptionLabel.text = pickUpLocation.description
            priceLabel.text = pickUpLocation.price
            //
            priceLabel.isHidden = pickUpLocation.price == nil ? true : false
            //
            if pickUpLocation.isSelected {
                customImageView.image = #imageLiteral(resourceName: "full-radio")
            } else {
                customImageView.image = #imageLiteral(resourceName: "epmty-radio")
            }
        case .delivery:
            titleLabel.text = pickUpLocation.title
            addressLabel.text = pickUpLocation.address
            descriptionLabel.text = pickUpLocation.description
            priceLabel.text = pickUpLocation.price
            //
            customImageView.image = #imageLiteral(resourceName: "right-arrow")
        }
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension PickUpLocationTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension PickUpLocationTableViewCell: NibLoadableView {}
