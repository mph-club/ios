//
//  CustomNavigationBar.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

final class CustomNavigationBar: UINavigationBar {
    // =============
    // MARK: - Enums
    // =============
    enum StyleType {
        case blackWithZeroAlpha
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    var styleView: StyleType = .blackWithZeroAlpha {
        didSet {
            updateNavigationBar()
        }
    }
    
    // ==================
    // MARK: - Initialize
    // ==================
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //
        updateNavigationBar()
    }
}

// ===============
// MARK: - Methods
// ===============
extension CustomNavigationBar {
    private func updateNavigationBar() {
        //
        switch styleView {
        case .blackWithZeroAlpha:
            blackWithZeroAlphaNavigationBar()
        }
    }
    
    private func blackWithZeroAlphaNavigationBar() {
        isTranslucent = true
        //
        barTintColor = UIColor.black.withAlphaComponent(0)
        tintColor = .white
        // Set title attributes
        setTitleStyle(.white)
    }
    
    func setTitleStyle(_ color: UIColor) {
        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color
        ]
    }
}
