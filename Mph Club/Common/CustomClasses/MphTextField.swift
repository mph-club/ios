//
//  MphTextField.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/3/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class MphTextField: UITextField {
    // ===============
    // MARK: - Initial
    // ===============
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //
        setBottomBorder()
    }
}

// ===============
// MARK: - Methods
// ===============

// MARK: Public
extension MphTextField {
    func setBottomSingleBorder(color: CGColor) {
        self.layer.shadowColor = color
    }
}

// MARK: Private
private extension MphTextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
