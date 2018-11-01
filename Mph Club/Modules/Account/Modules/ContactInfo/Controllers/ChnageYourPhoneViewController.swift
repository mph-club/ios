//
//  ChnageYourPhoneViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ChnageYourPhoneViewController: UIViewController {}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ChnageYourPhoneViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ChnageYourPhoneViewController {
    @IBAction func phoneNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.applyPatternOnNumbers(pattern: "###-###-####", replacmentCharacter: "#")
    }
}
