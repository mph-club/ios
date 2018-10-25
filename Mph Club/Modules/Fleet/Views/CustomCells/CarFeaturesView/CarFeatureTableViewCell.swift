//
//  CarFeatureTableViewCell.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class CarFeatureTableViewCell: UITableViewCell {}

// ===============
// MARK: - Methods
// ===============
extension CarFeatureTableViewCell {
    func setContent(_ carFeature: CarFeature?) {
        imageView?.image = UIImage(named: carFeature?.image ?? "")
        //
        textLabel?.text = carFeature?.title
    }
}

// =====================
// MARK: - Reusable View
// =====================
extension CarFeatureTableViewCell: ReusableView {}

// =========================
// MARK: - Nib Loadable View
// =========================
extension CarFeatureTableViewCell: NibLoadableView {}
