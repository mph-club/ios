//
//  ListedVehiclesTableViewCell.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ListedVehiclesTableViewCell: UITableViewCell {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var cellBackgroundView: UIView!
    
    // MARK: Label
    @IBOutlet private weak var titleStatusLabel: UILabel!
    @IBOutlet private weak var shortDescriptionTextView: UILabel!
    
    // MARK: Image View
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var statusImageView: UIImageView!
}

// =======================
// MARK: - Table View Cell
// =======================

// MARK: Life Cycle
extension ListedVehiclesTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundView.layer.shadowColor = UIColor.lightGray.cgColor
        cellBackgroundView.layer.shadowOpacity = 0.5
        cellBackgroundView.layer.shadowOffset = .zero
        cellBackgroundView.layer.shadowRadius = 3
    }
}

// ===============
// MARK: - Methods
// ===============
extension ListedVehiclesTableViewCell {
    func setContent(_ vehicles: Vehicles) {
        // Configure the view for the selected state
        if vehicles.viewIndex == 0 {
            switch vehicles.status {
            case .pending:
                statusImageView.image = #imageLiteral(resourceName: "pending-approval")
                titleStatusLabel.text = "Your listing is pending approval"
            case .approved:
                statusImageView.image = nil
                titleStatusLabel.text = "Your listing is approved approval"
            default:
                break
            }
        } else {
            statusImageView.image = #imageLiteral(resourceName: "in-progress")
            titleStatusLabel.text = "Your listing is In-progress"
        }
        
        shortDescriptionTextView.text = "\(vehicles.make ?? "")  \(vehicles.model ?? "") \(vehicles.year ?? 0)"
        //
        carImageView.setImage(with: vehicles.photos?.first)
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension ListedVehiclesTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension ListedVehiclesTableViewCell: NibLoadableView {}
