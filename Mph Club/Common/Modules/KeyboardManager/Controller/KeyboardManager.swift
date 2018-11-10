//
//  KeyboardManager.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class KeyboardManager: NSObject {
    // ===============
    // MARK: - Outlets
    // ===============
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            configManager()
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension KeyboardManager {
    @objc func keyboardWasShown(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets: UIEdgeInsets = .zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func tapGestureDidFire() {
        scrollView.endEditing(true)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension KeyboardManager {
    func configManager() {
        // Add observer keyboard did show
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        // Add observer keyboard will hide
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        // add tap gesture for dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDidFire))
        scrollView.addGestureRecognizer(tapGesture)
    }
}
