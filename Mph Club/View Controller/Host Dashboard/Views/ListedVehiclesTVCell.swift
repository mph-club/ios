//
//  ListedVehiclesTVCell.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ListedVehiclesTVCell: UITableViewCell {

    @IBOutlet private weak var cellBackgroundView: UIView!
    @IBOutlet private weak var titleStatusLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var shortDescriptionTextView: UILabel!
    
    @IBOutlet private weak var carImageView: UIImageView!
    
    enum Status: String {
        case pending = "P"
        case rejected = "R"
        case unlisted = "U"
        case banned = "B"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundView.layer.shadowColor = UIColor.lightGray.cgColor
        cellBackgroundView.layer.shadowOpacity = 0.5
        cellBackgroundView.layer.shadowOffset = CGSize.zero
        cellBackgroundView.layer.shadowRadius = 6
    }


    
    
    func setContent(_ vehicles: Vehicles) {
        // Configure the view for the selected state
        if vehicles.viewIndex == 0 {
            switch vehicles.status {
            case .pending:
                titleStatusLabel.text = "Pending Approval"
                statusLabel.text = "Your listing is pending approval"
            case  .approved:
                titleStatusLabel.text = "Listing Approved"
                statusLabel.text = "Your listing is approved approval"
            case .denied:
                titleStatusLabel.text = "Listing Rejected"
                statusLabel.text = "Your listing is denied approval"
            case .none:
                titleStatusLabel.text = ""
                statusLabel.text = ""
            }
        } else {
            titleStatusLabel.text = "In-progress"
            statusLabel.text = "Your listing is In-progress"
        }
        
        shortDescriptionTextView.text = "\(vehicles.make ?? "")  \(vehicles.model ?? "") \(vehicles.year ?? 0)"
        //
        carImageView.setImage(with: vehicles.photos?.first)
    }

}

