//
//  NextButton.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class NextButton: UIButton {
    // ===============
    // MARK: - Initial
    // ===============
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //
        setNextButton()
    }
}

// ===============
// MARK: - Methods
// ===============
private extension NextButton {
    func setNextButton() {
        self.backgroundColor = .lightGray
    }
}
