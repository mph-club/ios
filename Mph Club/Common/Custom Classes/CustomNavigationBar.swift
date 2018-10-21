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
        case transparent(alpha: CGFloat)
        case defaultNavigationBar
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    var styleView: StyleType = .defaultNavigationBar {
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
        case .transparent(let alpha):
            transparentNavigationBarWithAlpha(alpha)
        case .defaultNavigationBar:
            defaultNavigationBar()
        }
    }
    
    private func transparentNavigationBarWithAlpha(_ alpha: CGFloat) {
        isTranslucent = true
        //
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        //
        tintColor = .white
        // set color with alpha
        backgroundColor = UIColor.black.withAlphaComponent(alpha)
        // enable clips to bounds
        clipsToBounds = true
        //
        setTitleStyle(UIColor.white.withAlphaComponent(alpha))
        //
        setBackButtonImage()
    }
    
    private func defaultNavigationBar() {
        isTranslucent = true
        //
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
        //
        setTitleStyle(.black)
        //
        backgroundColor = nil
    }
    
    private func setBackButtonImage() {
        backIndicatorImage = UIImage(named: "back-arrow")
        backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
    }
    
    func setTitleStyle(_ color: UIColor) {
        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color
        ]
    }
}
