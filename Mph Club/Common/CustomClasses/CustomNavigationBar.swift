//
//  CustomNavigationBar.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import UIKit

final class CustomNavigationBar: UINavigationBar {
    // =============
    // MARK: - Enums
    // =============
    enum StyleType {
        case whiteNavigationBar
        case blackNavigationBar
        case transparentWithBlackTint
        case transparentWithWhiteTint
        case transparentWith(alpha: CGFloat)
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    var styleView: StyleType = .whiteNavigationBar {
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
        case .whiteNavigationBar:
            whiteNavigationBar()
        case .blackNavigationBar:
            blackNavigationBar()
        case .transparentWithBlackTint:
            transparentNavigationBarWithBlackTint()
        case .transparentWithWhiteTint:
            transparentNavigationBarWithWhiteTint()
        case .transparentWith(let alpha):
            transparentNavigationBarWithAlpha(alpha)
        }
        //
        setBackButtonImage()
    }
    
    private func transparentNavigationBarWithBlackTint() {
        isTranslucent = true
        //
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        //
        tintColor = .black
        //
        backgroundColor = nil
        //
        setTitleStyle(.black)
    }
    
    private func transparentNavigationBarWithWhiteTint() {
        isTranslucent = true
        //
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        //
        tintColor = .white
        //
        backgroundColor = nil
        //
        setTitleStyle(.white)
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
        //
        setTitleStyle(UIColor.white.withAlphaComponent(alpha))
    }
    
    private func whiteNavigationBar() {
        isTranslucent = true
        //
        barTintColor = .white
        //
        shadowImage = UIImage()
        //
        tintColor = .black
        //
        backgroundColor = .white
        //
        setTitleStyle(.black)
    }
    
    private func blackNavigationBar() {
        isTranslucent = true
        //
        barTintColor = .black
        //
        shadowImage = UIImage()
        //
        tintColor = .white
        //
        backgroundColor = .black
        //
        setTitleStyle(.white)
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
